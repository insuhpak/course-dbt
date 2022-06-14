with order_items as (

    select * from {{ ref('stg_order_items') }}

),

product_info as (

    select * from {{ ref('stg_products') }}

)

select
    order_items.order_id as order_id,
    order_items.quantity as ordered_quantity_of_product,
    product_info.name as product_name,
    product_info.price as product_price,
    product_info.inventory as product_inventory,
    order_items.product_id as product_id

from order_items
left join product_info
on order_items.product_id = product_info.id

order by order_items.order_id, order_items.product_id, order_items.quantity