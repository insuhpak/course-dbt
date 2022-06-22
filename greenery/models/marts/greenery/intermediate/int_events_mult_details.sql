with base as (

    select * from {{ ref('int_events_single_details') }}

),

order_items_product_info as (

    select
        order_items.order_id as order_id
        , order_items.quantity as ordered_quantity_of_product
        , product_info.name as product_name
        , product_info.price as product_price
        , product_info.inventory as product_inventory
        , order_items.product_id as product_id

    from {{ ref('stg_order_items') }} as order_items
    left join {{ ref('stg_products') }} as product_info
    on order_items.product_id = product_info.id

    order by order_items.order_id
        , order_items.product_id
        , order_items.quantity

)

select 
    base.id
    , base.session_id
    , base.user_id
    , base.event_type
    , base.page_url
    , base.created_at_utc
    , base.order_id
    , order_items_product_info.ordered_quantity_of_product
    , coalesce(base.product_id, order_items_product_info.product_id) as product_id
    , coalesce(base.product_name, order_items_product_info.product_name) as product_name
    , coalesce(base.product_price, order_items_product_info.product_price) as product_price
    , coalesce(base.product_inventory, order_items_product_info.product_inventory) as product_inventory

from base
left join order_items_product_info
on base.order_id = order_items_product_info.order_id