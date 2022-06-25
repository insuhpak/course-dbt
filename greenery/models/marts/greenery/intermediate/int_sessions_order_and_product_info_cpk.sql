with 

-- EVENT INFORMATION
-- INCLUDES EVENT INFORMATION FOR ORDERED PRODUCTS AND NOT ORDERED PRODUCTS
base as (

    select * from {{ ref('stg_events') }}

)
,

-- PROVIDE ALL PRODUCT INFORMATION
-- WHERE AS ORDER_PRODUCT_INFO WILL ONLY PROVIDE PRODUCT INFO FOR PRODUCTS THAT HAVE BEEN ORDERED
 product_info as (

    select * from {{ ref('stg_products') }}

)
,

-- PRODIVE ORDER INFORMATION FOR ORDERED PRODUCTS
order_product_info as (

    select * from {{ ref('int_order_items_product_info_joined') }}

)

select
    -- TABLE COMPOSITE PRIMARY KEY
    base.id as cpk_event_id
    , coalesce( order_product_info.product_id, base.product_id) as cpk_product_id

    -- EVENT INFORMATION
    , base.id as event_id
    , base.session_id as session_id
    , base.user_id
    , base.event_type
    , base.page_url
    , base.created_at_utc

    -- PRODUCT INFORMATION
    , coalesce( order_product_info.product_id, base.product_id) as product_id
    , coalesce( order_product_info.product_name, product_info.name) as product_name
    , coalesce( order_product_info.product_price, product_info.price) as product_price
    , coalesce( order_product_info.product_inventory, product_info.inventory) as product_inventory

    -- ORDER INFORMATION
    , base.order_id
    , order_product_info.ordered_quantity_of_product



from base
left join order_product_info
on base.order_id = order_product_info.order_id

left join product_info
on base.product_id = product_info.id