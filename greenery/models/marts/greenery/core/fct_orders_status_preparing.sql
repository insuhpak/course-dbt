-- # LIST OF ORDERS WITH MORE THAN THE BASIC DETAILS
with orders_more_details as (

    select * from {{ ref('int_orders_fk_joined_unique_pk') }}
    
)

-- # LIST ORDERS WITH PREPARING STATUS AND THE TIME ELAPSED SINCE ORDER
select 
    current_timestamp - order_created_at_utc as time_elapsed
    , *

from orders_more_details

where order_status = 'preparing'

order by time_elapsed desc, full_name