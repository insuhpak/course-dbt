with products as (

    select * from {{ ref('stg_products') }}

),

base as (

    select * from {{ ref('stg_events') }}

)

select
    base.*
    , products.name as product_name
    , products.price as product_price
    , products.inventory as product_inventory

from base
left join products
on base.product_id = products.id