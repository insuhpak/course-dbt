with address as (

    select * from {{ ref('stg_addresses') }}

),

promo as (

    select * from {{ ref('stg_promos') }}

),

users as (

    select * from {{ ref('stg_users') }}

),

orders as (

    select * from {{ ref('stg_orders') }}

),


base as (

    select * from orders

)

select 
    users.full_name as full_name,
    users.first_name as first_name,
    users.last_name as last_name,
    base.id as order_id,
    base.created_at_utc as order_created_at_utc,
    base.promo_id as promo_id,
    promo.status as promo_status,
    promo.discount as promo_discount_amount,
    base.order_cost as order_cost,
    base.shipping_cost as shipping_cost,
    base.order_total as order_total_promo_applied,
    base.status as order_status,
    base.shipping_service as shipping_service,
    base.tracking_id as tracking_id,
    address.address as street_address,
    address.zipcode as zipcode,
    address.state as state,
    address.country as country,
    base.estimated_delivery_at_utc as estimate_delivery_at_utc,
    base.delivered_at_utc as delivered_at_utc,
    users.email as user_email,
    users.phone_number as user_phone_number


from base
left join users
on base.user_id = users.id

left join promo
on base.promo_id = promo.id

left join address
on base.address_id = address.id

order by order_status, order_id