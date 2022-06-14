with orders as (

    select * from {{ ref('stg_orders') }}

),

user_info as (

    select * from {{ ref('stg_users') }}

)

select 
    orders.*,
    user_info.first_name as first_name,
    user_info.last_name as last_name,
    first_name || ' ' || last_name as full_name,
    user_info.email as user_email,
    user_info.phone_number as user_phone_number

from orders
left join user_info
on orders.user_id = user_info.id