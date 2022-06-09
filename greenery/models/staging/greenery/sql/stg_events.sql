select
    event_id as id,
    session_id, 
    user_id,
    event_type,
    page_url,
    created_at,
    order_id,
    product_id

from {{ source( 'greenery', 'events' ) }}