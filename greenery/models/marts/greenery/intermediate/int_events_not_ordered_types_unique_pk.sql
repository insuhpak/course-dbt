-- SESSION INFORMATION FROM EVENTS TABLE
with all_events as (

    select * from {{ ref('stg_events') }}

)
,

-- PRODUCT INFORMATION FROM PRODUCTS TABLE
product_info as (

    select * from {{ ref('stg_products') }}

)
,

-- EXCLUDES EVENTS THAT HAVE ORDER_IDS
not_ordered_events as (

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

    where order_id is null
    order by session_id, event_type

)
,

-- EVENTS  WITHOUT ORDER_IDS AND PRODUCT INFORMATION
-- JOIN NOT_ORDERED_EVENTS AND PRODUCT_INFO
final as (

    select
        -- TABLE PRIMARY KEY (PK)
        not_ordered_events.event_id as pk_event_id

        -- EVENT INFORMATION
        , not_ordered_events.*

        -- EVENT PRODUCT INFORMATION
        , product_info.name as product_name
        , product_info.price as product_price
        , product_info.inventory as inventory

    from not_ordered_events
    left join product_info
    on not_ordered_events.product_id = product_info.id


)

select * from final

