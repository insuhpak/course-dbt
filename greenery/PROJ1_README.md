3.1 How many users do we have?

    select  

        count(distinct id) as number_of_users

    from dbt_insuh_p.stg_users

=> 130

3.2 On average, how many orders do we receive per hour?

    select distinct 
    
        count(id) / 24 as avg_orders_per_hour
        
    from dbt_insuh_p.stg_orders

=> 15

3.3 On average, how long does an order take from being placed to being delivered?

    select 

        sum(delivered_at_utc - created_at_utc) / count(id) as avg_delivery_time

    from dbt_insuh_p.stg_orders

    where delivered_at is not null

==> 3 days 2124:11.803279

3.4 How many users have only made one purchase? Two purchases? Three+ purchases?

    with orders_per_user as (
    select 
    
        user_id,
        count(distinct id) as orders_per_user
    
    from dbt_insuh_p.stg_orders
    
    group by user_id
    )

    select 
    
        orders_per_user,
        count( distinct user_id) as number_of_users

    from orders_per_user

    group by orders_per_user

=> orders_per_user | number_of_users
    1                25
    2                28
    3                34
    4                20
    5                10
    6                2
    7                4
    8                1

3.5 On average, how many unique sessions do we have per hour?

    select 

        count(distinct session_id) / 21 as avg_distinct_sessions_per_hour

    from dbt_insuh_p.stg_events

=> 27