-- SESSION INFORMATION FROM EVENTS TABLE
with all_events as (

    select * from {{ ref('stg_events') }}

)
,

-- PRODUCT INFORMATION FROM PRODUCTS TABLE
order_product_info as (

    select * from {{ ref('int_order_items_product_info_joined') }}

)
,

-- ONLY INCLUDES EVENTS THAT HAVE ORDER_IDS
ordered_events as (

    select 
        session_id
        , id as event_id
        , user_id
        , event_type
        , page_url
        , created_at_utc
        , order_id
        , product_id

    from all_events

    where order_id is not null
    order by session_id, event_type

)
,

-- EVENTS  WITHOUT ORDER_IDS AND PRODUCT INFORMATION
-- JOIN NOT_ORDERED_EVENTS AND PRODUCT_INFO
final as (

    select
        --  TABLE COMPOSITE PRIMARY KEY (CPK)
        ordered_events.event_id as cpk_event_id
        , order_product_info.product_id as cpk_product_id   

        -- EVENT INFORMATION
        , ordered_events.session_id
        , ordered_events.event_id
        , ordered_events.user_id
        , ordered_events.event_type
        , ordered_events.page_url
        , ordered_events.created_at_utc
        , ordered_events.order_id

        -- EVENT PRODUCT INFORMATION
        , coalesce(ordered_events.product_id, order_product_info.product_id) as product_id
        , order_product_info.product_name
        , order_product_info.product_price
        , order_product_info.product_inventory

    from ordered_events
    left join order_product_info
    on ordered_events.order_id = order_product_info.order_id

)

select * from final

