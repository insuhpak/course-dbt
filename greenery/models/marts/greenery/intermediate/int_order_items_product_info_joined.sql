with 

-- ORDER ITEMS INFORMATION
base as (

    select * from {{ ref('stg_order_items') }}

)
,

-- PRODUCT INFORMATION
product_info as (

    select * from {{ ref('stg_products') }}

)
,

final as (

    select

            -- ORDER ITEM INFORMATION
            base.order_id as order_id
            , base.quantity as ordered_quantity_of_product

            --  PRODUCT INFORMATION
            , product_info.name as product_name
            , product_info.price as product_price
            , product_info.inventory as product_inventory
            , base.product_id as product_id

    from base
    left join product_info
    on base.product_id = product_info.id

    order by base.order_id
        , base.product_id
        , base.quantity
)

select * from final