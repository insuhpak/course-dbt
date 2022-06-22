-- # LIST OF PRODUCTS AND SOME BASIC INFOMRATION
with product_list as (

    select * from {{ ref('stg_products') }}

),

-- # EVENT DETAILS WITH BASIC PRODUCT INFORMATION INCLUDED
events_product_details as (

    select * from {{ ref('int_events_product_details') }}

),

-- # ORDER INFORMATION WITH BASIC PRODUCT INFORMATION INCLUDED
orders_all_details as (

    select * from {{ ref('int_orders_all_details') }}

),

-- # VIEWED AND IN CART COUNTS FOR PRODUCTS (VIEWED AND IN CART ARE STILL IN ONE COLUMN)
not_ordered_rows as (

    select 
        product_id
        , product_name
        , event_type
        , count(id) as not_ordered
    from events_product_details
    where order_id is null

    group by product_id
        , product_name
        , event_type
        
    order by product_name, event_type

),

-- # VIEWED AND IN CART HAVE BEEN SPLIT INTO TWO COLUMNS (NULLS IN EMPTY ROWS)
not_ordered_columns as (

    select 
        product_id
        , case event_type
            when 'add_to_cart' then not_ordered
            else null
        end as in_cart 
        , case event_type
            when 'page_view' then not_ordered
            else null
        end as viewed

    from not_ordered_rows

),

-- # VIEWED IN SEPARATE TABLE THAN IN CART (TO REMOVE NULL ROWS)
viewed_column as (

    select 
        product_id
        , viewed

    from not_ordered_columns
    where viewed is not null
),

-- # IN CART IN SEPARATE TABLE THAN VIEWED (TO REMOVE NULL ROWS)
in_cart_column as (

    select 
        product_id
        , in_cart

    from not_ordered_columns
    where in_cart is not null

), 

-- # ORDERED COUNT COLUMN ISOLATED 
ordered_column as (

    select
        product_id
        , product_name
        , sum(ordered_quantity_of_product) as ordered

    from orders_all_details

    group by product_id
        , product_name

)

-- # SHOW COUNT OF VIEWED, IN CART AND ORDERED FOR EACH PRODUCT
select 
    product_list.*
    , viewed_column.viewed
    , in_cart_column.in_cart
    , ordered_column.ordered

from product_list
left join viewed_column
on product_list.id = viewed_column.product_id

left join in_cart_column
on product_list.id = in_cart_column.product_id

left join ordered_column
on product_list.id = ordered_column.product_id

order by name
