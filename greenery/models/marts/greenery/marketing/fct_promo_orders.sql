with orders as (

    select * from {{ ref('stg_orders') }}

),

promo_info as (

    select * from {{ ref('stg_promos') }}

)

select
    orders.user_id as user_id,
    orders.id as order_id,
    orders.promo_id as promo_id,
    promo_info.status as promo_status,
    promo_info.discount as promo_discount_amount,
    orders.order_cost + promo_info.discount as original_cost,
    orders.order_cost as discounted_order_cost,
    orders.shipping_cost as shipping_cost,
    orders.order_total as paid_order_total,
    orders.created_at_utc as order_created_at_utc,
    orders.status as order_status
    

from orders
inner join promo_info
on orders.promo_id = promo_info.id

order by promo_status, promo_id
