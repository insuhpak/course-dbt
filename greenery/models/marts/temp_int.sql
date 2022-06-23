with events_sessions as (

    select * from {{ ref('stg_events') }}

)
,

