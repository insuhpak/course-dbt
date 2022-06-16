with product_list as (

    select * from {{ ref('stg_products') }}

),

events_product_details as (

    select * from {{ ref('int_events_product_details') }}

),

orders_all_details as (

    select * from {{ ref('int_orders_all_details') }}

),

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

viewed_column as (

    select 
        product_id
        , viewed

    from not_ordered_columns
    where viewed is not null
),

in_cart_column as (

    select 
        product_id
        , in_cart

    from not_ordered_columns
    where in_cart is not null

), 

ordered_column as (

    select
        product_id
        , product_name
        , sum(ordered_quantity_of_product) as ordered

    from orders_all_details

    group by product_id
        , product_name

)

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
