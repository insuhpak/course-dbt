-- LIST OF PRODUCTS AND SOME BASIC INFOMRATION
with product_list as (

    select * from {{ ref('stg_products') }}

),

-- EVENT DETAILS WITH BASIC PRODUCT INFORMATION INCLUDED
events_product_details as (

    select * from {{ ref('int_events_product_details') }}

),

-- ORDER INFORMATION WITH BASIC PRODUCT INFORMATION INCLUDED
orders_all_details as (

    select * from {{ ref('int_orders_mult_details') }}

),

-- ORDERED COUNT COLUMN ISOLATED 
ordered_column as (

    select
        product_id
        , product_name
        , sum(ordered_quantity_of_product) as ordered

    from orders_all_details

    group by 1, 2

),

-- NOT ORDERED RELATED EVENT TYPES COUNT ISOLATED IN SEPARATE COLUMNS
-- CHECKOUT AND PACKAGE_SHIPPED (ORDERED) EVENTS DO NOT HAVE PRODUCT INFORMATION
-- IN THE INT_EVENTS_PRODUCT_DETAILS TABLE SO THEIR VALUES ARE NULL
-- ORDERED RELATED PRODUCT INFORMATION SOURCED FROM INT_ORDERS_ALL_DETAILS
not_ordered_event_types_agg as (

    select 
        product_id
        , product_name
        , {{ dbt_utils.pivot('event_type', 
                             dbt_utils.get_column_values(ref('int_events_product_details'), 'event_type' )
                            ) 
          }}

    from events_product_details

    where product_id is not null
    group by 1, 2
    order by product_name

)

-- # SHOW COUNT OF VIEWED, IN CART AND ORDERED FOR EACH PRODUCT
select 
    product_list.*
    , not_ordered_columns.page_view as viewed
    , not_ordered_columns.add_to_cart as added_to_cart
    , ordered_column.ordered as ordered

from product_list
left join not_ordered_event_types_agg as not_ordered_columns
on product_list.id = not_ordered_columns.product_id

left join ordered_column
on product_list.id = ordered_column.product_id

order by name
