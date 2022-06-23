with base as (

    select * from {{ ref('int_orders_fk_joined_unique_pk') }}

)
,

order_items_product_info as (
    
    select * from {{ ref('int_order_items_product_info_joined') }}

)
,

final as (
    select
        base.*
        , order_items_product_info.ordered_quantity_of_product as ordered_quantity_of_product
        , order_items_product_info.product_name as product_name
        , order_items_product_info.product_price as product_price
        , order_items_product_info.product_inventory as product_inventory
        , order_items_product_info.product_id as product_id


    from base
    left join order_items_product_info
    on base.order_id = order_items_product_info.order_id
)

select * from final