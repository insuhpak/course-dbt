with base as (

    select * from {{ ref('int_sessions_order_and_product_info_notunique_pk') }}

)


select
    distinct session_id
    , {{ sum_case_when_1_0('event_type', 'page_view' ) }} as page_views

from base

group by 1

