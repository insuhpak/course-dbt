with orders as (

    select * from {{ ref('stg_orders') }}

),

addresses as (

    select * from {{ ref('stg_addresses') }}

)

select 
    orders.*,
    addresses.address as street_address,
    addresses.zipcode as zipcode,
    addresses.state as state,
    addresses.country as country

from orders
left join addresses
on orders.address_id = addresses.id