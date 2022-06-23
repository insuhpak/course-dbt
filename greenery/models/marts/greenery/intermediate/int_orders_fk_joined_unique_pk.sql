with base as (

    select * from {{ ref('stg_orders') }}

)
,

addresses as (

    select * from {{ ref('stg_addresses') }}

)
,

promos as (

    select * from {{ ref('stg_promos') }}

)
,

users as (

    select * from {{ ref('stg_users') }}

)
,

final as (
    select 
        users.full_name as full_name
        , users.first_name as first_name
        , users.last_name as last_name
        , base.user_id as user_id
        , base.id as order_id
        , base.created_at_utc as order_created_at_utc
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

    order by order_status, order_id
)

select * from final