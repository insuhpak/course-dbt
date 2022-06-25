with base as (

    select * from {{ ref('int_events_order_and_product_info_cpk') }}

)


select

    -- SESSION INFORMATION
    distinct session_id
    , user_id

    , {{sum_case_when('event_type', 'page_view', '1', '0') }} as page_view
    , {{sum_case_when('event_type', 'add_to_cart', '1', '0') }} as add_to_cart
    , {{sum_case_when('event_type', 'checkout', '1', '0') }} as checkout
    , {{sum_case_when('event_type', 'package_shipped', '1', '0') }} as package_shipped

from base

group by 1, 2
order by session_id