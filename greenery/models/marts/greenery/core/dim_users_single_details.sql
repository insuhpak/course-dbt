-- # LIST OF ALL USERS AND BASIC INFORMATION
with users as (

    select * from {{ ref('stg_users') }}

),

-- # LIST OF ALL ORDERS
orders as (

    select * from {{ ref('stg_orders') }}

),

-- # COUNT OF ORDERS PER USER
users_with_orders as (

    select
        user_id,
        count(id) as number_of_orders
    from
        orders

    group by user_id

),

-- # USERS ADDRESS INFORMATION
addresses as (

    select * from {{ ref('stg_addresses') }}

)

-- # ADDRESSES AND AGG'D ORDER INFORMATION ADDED
select
    users.full_name as full_name
    , users.first_name as first_name
    , users.last_name as last_name
    , users.email as email
    , users.phone_number as phone_number
    , addresses.address as street_address
    , addresses.zipcode as zipcode
    , addresses.state as state
    , addresses.country as country
    , coalesce( users_with_orders.number_of_orders, 0) as number_of_orders

from users
left join addresses
on users.address_id = addresses.id

left join users_with_orders
on users.id = users_with_orders.user_id

order by last_name