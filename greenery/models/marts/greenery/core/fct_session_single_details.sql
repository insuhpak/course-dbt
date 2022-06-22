with events_details as (

    select * from {{ ref('int_events_single_details') }}

)

select 
    session_id
    , {{ dbt_utils.pivot('event_type', 
                             dbt_utils.get_column_values(ref('int_events_single_details'), 'event_type' )
                            ) 
          }}

from events_details

group by 1
