with orders as (

    select * from {{ ref('stg_orders') }}

),

order_items_product_info as (

    -- with order_items as (

    -- select * from {{ ref('stg_order_items') }}

    -- ),

    -- product_info as (

    --     select * from {{ ref('stg_products') }}

    -- )

    select
        order_items.order_id as order_id,
        order_items.quantity as ordered_quantity_of_product,
        product_info.name as product_name,
        product_info.price as product_price,
        product_info.inventory as product_inventory,
        order_items.product_id as product_id

    from {{ ref('stg_order_items') }} as order_items
    left join {{ ref('stg_products') }} as product_info
    on order_items.product_id = product_info.id

    order by order_items.order_id, order_items.product_id, order_items.quantity

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