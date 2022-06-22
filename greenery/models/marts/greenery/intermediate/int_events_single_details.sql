with 

base as (

    select * from {{ ref('stg_events') }}

)
,

 products as (

    select * from {{ ref('stg_products') }}

)

select
    base.*
    , products.name as product_name
    , products.price as product_price
    , products.inventory as product_inventory

from base
left join products
on base.product_id = products.id