# Week 1 Project 

## 3.1 How many users do we have?

``` sql
select  
    count(distinct id) as number_of_users

from dbt_insuh_p.stg_users
```

> 130

## 3.2 On average, how many orders do we receive per hour?

``` sql
with orders_per_hour as (
  select 
    date_trunc('hour', created_at_utc) as created_at_utc_hour,
    count(created_at_utc) as number_of_orders
    
  from dbt_insuh_p.stg_orders
  
  group by created_at_utc_hour
)

select 
  -- sum(number_of_orders) / count( distinct created_at_utc_hour) as avg_orders_per_hour
  avg(number_of_orders) as avg_orders_per_hour

from orders_per_hour
```

> 7.5208333333333333

## 3.3 On average, how long does an order take from being placed to being delivered?

``` sql
select 
    sum(delivered_at_utc - created_at_utc) / count(id) as avg_delivery_time

from dbt_insuh_p.stg_orders

where delivered_at_utc is not null
```

> 3 days 21:24:11.803279

## 3.4 How many users have only made one purchase? Two purchases? Three+ purchases?

```sql
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
```

> | orders_per_user      | number_of_users |
> | ----------- | ----------- |
> | 1      | 25       |
> | 2   | 28        |
> | 3      | 34       |
> | 4   | 20        |
> | 5      | 10       |
> | 6   | 2        |
> | 7      | 4       |
> | 8   | 1        |

## 3.5 On average, how many unique sessions do we have per hour?

```sql 
with sessions_per_hour as (
  select 
    date_trunc('hour', created_at_utc) as created_at_utc_hour,
    count(distinct session_id) as number_of_sessions
  
  from dbt_insuh_p.stg_events
  
  group by created_at_utc_hour
)
  
select 
    avg(number_of_sessions) as avg_sessions_per_hour
    
from sessions_per_hour

```

> 6.3275862068965517