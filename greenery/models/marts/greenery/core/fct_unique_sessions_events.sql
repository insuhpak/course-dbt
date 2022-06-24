with base as (

    select * from {{ ref('int_sessions_order_and_product_info_notunique_pk') }}

)


select

    -- SESSION INFORMATION
    distinct session_id
    , user_id
    , event_type
    , count( event_id) as events_per_session
    , sum( count(  event_id) ) over( partition by session_id ) as total_events_per_session

from base

group by 1, 2, 3
order by session_id