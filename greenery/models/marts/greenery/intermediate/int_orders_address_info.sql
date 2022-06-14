with orders as (

    select * from {{ ref('stg_orders') }}

),

address_info as (

    select * from {{ ref('stg_addresses') }}

)

select 
    orders.*,
    address_info.address as street_address,
    address_info.zipcode as zipcode,
    address_info.state as state,
    address_info.country as country

from orders
left join address_info
on orders.address_id = address_info.id