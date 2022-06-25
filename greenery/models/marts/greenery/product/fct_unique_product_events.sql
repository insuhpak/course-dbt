with base as (

    select * from {{ ref('int_events_order_and_product_info_cpk') }}

)
,

distinct_sessions as (

    select

        -- PRODUCT INFORMATION
        distinct product_id
        , product_name
        , product_price
        , product_inventory

        -- SESSION INFORMATION
        , event_type
        , count( distinct session_id) as unique_sessions_per_product
        , sum( count(distinct session_id) ) over( partition by product_id ) as total_sessions_per_product

    from base

    group by 1, 2, 3, 4, 5
    order by product_name

)
,

final as (
    
    select
        distinct product_id
        , product_name

        , {{ sum_case_when('event_type', 'page_view', 'unique_sessions_per_product', '0') }} as page_view
        , {{ sum_case_when('event_type', 'add_to_cart', 'unique_sessions_per_product', '0') }} as add_to_cart
        , {{ sum_case_when('event_type', 'checkout', 'unique_sessions_per_product', '0') }} as checkout
        , {{ sum_case_when('event_type', 'package_shipped', 'unique_sessions_per_product', '0') }} as package_shipped

        , {{ division_to_percentage( sum_case_when('event_type', 'checkout', 'unique_sessions_per_product', '0') ,
            sum_case_when('event_type', 'page_view', 'unique_sessions_per_product', '0') ) }} as product_conversion_rate

    from distinct_sessions

    group by 1, 2
    order by product_name

)


select * from final