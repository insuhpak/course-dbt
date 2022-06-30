with temp_t as(
  select
   count ( distinct ( case when page_view > 0  then session_id end) ) as total_sessions
   , count ( distinct ( case when add_to_cart > 0  then session_id end) ) as add_to_cart
   , count ( distinct ( case when checkout > 0  then session_id end) ) as checkout
  
  from dbt_insuh_p.fct_unique_sessions_events
)

select 
  total_sessions
  , round( add_to_cart/total_sessions :: numeric * 100, 2) || '%' as add_to_cart_perct
  , round( checkout/total_sessions :: numeric * 100, 2) || '%' as checkout_perct
  
from temp_t

-- change rate from level to level