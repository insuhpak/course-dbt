with orders as (

    select * from {{ ref('stg_orders') }}

),

promo_info as (

    select * from {{ ref('stg_promos') }}

)

select 
    orders.*,
    promo_info.discount as promo_discount_amount,
    promo_info.status as promo_status


from orders
left join promo_info
on orders.promo_id = promo_info.id