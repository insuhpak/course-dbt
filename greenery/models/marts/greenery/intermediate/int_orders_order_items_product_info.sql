with orders as (

    select * from {{ ref('stg_orders') }}

),

order_items_product_info as (

    select * from {{ ref('fct_order_items_product_info') }}

)

select 
    orders.*,
    order_items_product_info.ordered_quantity_of_product as ordered_quantity_of_product,
    order_items_product_info.product_name as product_name,
    order_items_product_info.product_price as product_price,
    order_items_product_info.product_inventory as product_inventory,
    order_items_product_info.product_id as product_id


from orders
left join order_items_product_info
on orders.id = order_items_product_info.order_id