with addresses as (

    select * from {{ ref('stg_addresses') }}

),

promos as (

    select * from {{ ref('stg_promos') }}

),

users as (

    select * from {{ ref('stg_users') }}

),

orders as (

    select * from {{ ref('stg_orders') }}

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

),

base as (

    select 
    orders.*
    , order_items_product_info.ordered_quantity_of_product as ordered_quantity_of_product
    , order_items_product_info.product_name as product_name
    , order_items_product_info.product_price as product_price
    , order_items_product_info.product_inventory as product_inventory
    , order_items_product_info.product_id as product_id


    from orders
    left join order_items_product_info
    on orders.id = order_items_product_info.order_id

)

select 
    users.full_name as full_name
    , users.first_name as first_name
    , users.last_name as last_name
    , base.user_id as user_id
    , base.id as order_id
    , base.created_at_utc as order_created_at_utc
    , base.product_name as product_name
    , base.product_id as product_id
    , base.product_price as product_price
    , base.ordered_quantity_of_product as ordered_quantity_of_product
    , base.product_inventory as product_inventory
    , base.promo_id as promo_id
    , promos.status as promo_status
    , promos.discount as promo_discount_amount
    , base.order_cost as order_cost
    , base.shipping_cost as shipping_cost
    , base.order_total as order_total_promo_applied
    , base.status as order_status
    , base.shipping_service as shipping_service
    , base.tracking_id as tracking_id
    , addresses.address as street_address
    , addresses.zipcode as zipcode
    , addresses.state as state
    , addresses.country as country
    , base.address_id as address_id
    , base.estimated_delivery_at_utc as estimate_delivery_at_utc
    , base.delivered_at_utc as delivered_at_utc
    , users.email as user_email
    , users.phone_number as user_phone_number


from base
left join users
on base.user_id = users.id

left join promos
on base.promo_id = promos.id

left join addresses
on base.address_id = addresses.id

order by order_status
    , order_id
    , product_name