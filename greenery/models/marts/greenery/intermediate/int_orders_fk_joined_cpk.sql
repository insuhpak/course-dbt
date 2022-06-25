with base as (

    select * from {{ ref('int_orders_fk_joined_pk') }}

)
,

order_items_product_info as (
    
    select * from {{ ref('int_order_items_product_info_joined') }}

)
,

final as (
    select
        -- # Table composite primary key (cpk)
        base.order_id as cpk_order_id
        , order_items_product_info.product_id as cpk_product_id

        -- # User information
        , base.full_name as full_name
        , base.first_name as first_name
        , base.last_name as last_name
        , base.user_id as user_id
        , base.user_email as user_email
        , base.user_phone_number as user_phone_number

        -- # Order information
        , base.order_id as order_id
        , base.order_created_at_utc as order_created_at_utc

        -- # Product information
        , order_items_product_info.product_id as product_id
        , order_items_product_info.ordered_quantity_of_product as ordered_quantity_of_product
        , order_items_product_info.product_name as product_name
        , order_items_product_info.product_price as product_price
        , order_items_product_info.product_inventory as product_inventory

        -- # Promo information
        , base.promo_id as promo_id
        , base.promo_status as promo_status
        , base.promo_discount_amount as promo_discount_amount

        -- # Order cost information
        , base.order_cost as order_cost
        , base.shipping_cost as shipping_cost
        , base.order_total_promo_applied as order_total_promo_applied

        -- # Order shipping information
        , base.order_status as order_status
        , base.shipping_service as shipping_service
        , base.tracking_id as tracking_id
        , base.street_address as street_address
        , base.zipcode as zipcode
        , base.state as state
        , base.country as country
        , base.address_id as address_id
        , base.estimated_delivery_at_utc as estimated_delivery_at_utc
        , base.delivered_at_utc as delivered_at_utc

    from base
    left join order_items_product_info
    on base.order_id = order_items_product_info.order_id
)

select * from final