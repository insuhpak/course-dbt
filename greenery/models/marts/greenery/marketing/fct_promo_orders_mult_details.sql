-- # LIST OF ORDERS WITH MORE THAN BASIC DETAILS
with orders_all_details as (

    select * from {{ ref('int_orders_mult_details') }}
    
)

-- # LIST OF ORDERS MADE USING PROMO CODES
select * from orders_all_details

where promo_id is not null

order by promo_id, order_id, product_name