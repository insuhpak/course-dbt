with base as (

    select * from {{ ref('int_sessions_order_and_product_info_cpk') }}

)
,

final as (

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

select * from final