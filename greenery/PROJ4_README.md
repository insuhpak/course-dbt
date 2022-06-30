# Week 4 Project 

### Product funnel is defined with 3 levels for our dataset:

* Sessions with any event of type page_view / add_to_cart / checkout
* Sessions with any event of type add_to_cart / checkout
* Sessions with any event of type checkout

```sql
    with funnel as(
    select
    count ( distinct ( case when page_view > 0  then session_id end) ) as total_sessions
    , count ( distinct ( case when add_to_cart > 0  then session_id end) ) as add_to_cart
    , count ( distinct ( case when checkout > 0  then session_id end) ) as checkout
    
    from dbt_insuh_p.fct_unique_sessions_events
    )

    select 
    total_sessions
    , add_to_cart as add_to_cart_count
    , round( add_to_cart/total_sessions :: numeric * 100, 2) || '%' as add_to_cart_perct
    , checkout as checkout_count
    , round( checkout/total_sessions :: numeric * 100, 2) || '%' as checkout_perct
    , round( checkout/add_to_cart :: numeric * 100, 2) || '%' as from_add_to_cart_to_checkout_perct
    
    from funnel
```

|total_sessions|add_to_cart_count|add_to_cart_perct|checkout_count|checkout_perct|from_add_to_cart_to_checkout_perct|
|---|---|---|---|---|---|
|578|467|80.80%|361|62.46%|77.30%|

