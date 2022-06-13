# WEEK 2 PROJECT

## (1) What is our user repeat rate?

```sql
with all_users as (

    select 
        user_id,
        count(distinct id) as orders_per_user,
        1 as temp_value

    from dbt_insuh_p.stg_orders

    group by user_id
    order by orders_per_user
),

repeat_users as (

  select 
    *
    
  from all_users
  where orders_per_user >=2
  
),

all_and_repeat_users_joined as (

  select 
    all_users.user_id,
    all_users.temp_value as all_temp_value,
    coalesce(repeat_users.temp_value, 0) as repeat_temp_value
    
  from all_users
  left join repeat_users on
    all_users.user_id = repeat_users.user_id
)

select 
  sum(repeat_temp_value) / sum(all_temp_value) :: float * 100 || '%' as repeat_rate
  
from
  all_and_repeat_users_joined
```
> 79.83870967741935%

## (2) What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?

#### Good indicators:
> We could check 'seasonality' of a repeat user's purchases. Do they make purchases once a week, every other month, semi-annualy? During a holiday season? Is there an obvious purchase pattern? 

> Users with multiple website events/interactions may indicate a likelihood to purchase again. (They are monitoring our products or may be looking out for promotions.)

#### Bad indicators:
> Users who have made a purchase but never interacted with our site after their purchase may have a likelihood to never purchase again.

> Users who have made only one purchase using a promotion.

> Time elapsed after their first purchase.

#### More data:
> User demographic information. (For example, more than 50% of users in X age group have made multiple purchases.)

> How did they find our product? Instagram, Facebook, search bar, word of mouth?


## (3) Adding int, dim, and/or fct models.

#### int_ :
> int_orders_full_address
>> This is an intermediate model because no analysis is done to produce it or in it. It joins two tables to be readily available for use elsewhere in the DAG.

#### dim_ :

#### fct_ :
> fct_promo_orders.sql
>> This is fact model because it reflects orders/transactions. The model contains all orders made with a promotion code and information about each promotion.