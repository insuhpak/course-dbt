I had trouble determining when an intermediate model was appropriate versus a dim/fct model. Also how granual an intermediate model should be. For example, I had initially created individual int models for each of the following joins: orders (+)addresses; orders (+)promos; orders (+)users; orders (+)order_items (+)products.
However, I condensed them into int_orders_all_details (= orders (+)addresses (+)promos (+)users (+)orders_items (+)products) and int_orders_more_details (= orders (+)addresses (+)promos (+)users).

A question that I have is:
Can dim/fct models reference both intermediate and stage models? Or should dim/fct models only reference intermediate models?

I would like feed back on: model layer structure and my dim/fct models' SQL.

I feel like I came up with some generally helpful dim/fct models.

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
> int_orders_all_details
>> I added this model so all order details, except events details, can be found in one table. (i.e. user, address, and promo details) Since this table also includes product details for each order, there can be multiple rows for one order.
>>
>> I added this at the intermediate level because it can be reused for different types of analyses. You can isolate/view data from the desired level without losing other order details or having to join tables at the dim/facts layer. For example, I can isolate all orders made with promotions and also view related order details in one table. (I will use this table to create the fct_promo_orders_all_details table.)

> int_orders_more_details
>> I added this model with the same reasoning as the int_orders_all_details table. I made this version because I wanted an int_ table with one row for each order. Therefore, this table does not have any order items/product information details but still has the other order details. (I could also make a fct_promo_orders_more_details table from this table. In general, most tables derived from int_orders_all_details can also have a int_orders_more_details version.)

> int_events_product_details
>> I added this model so product details can be found for each event. I do not add order items details because that information exists in the int_order_all_details table.
>>
>> I added this at the intermdiate level because it can be reused for different types of analyses.

#### dim_ :
> dim_users_more_details
>
>> I added this model so more user details can be found in one table. 
>>
>> I added this at the dim/fact level because it is ready for analysis or to be loaded into a BI tool.

#### fct_ :
> fct_promo_orders_all_details
>
>> I added this model to isolate all orders made with promotions.
>>
>> I added this at the dim/fact level because it is ready for analysis or to be loaded into a BI tool.

> fct_orders_status_preparing
>
>> I added this model to isolate all orders that have a status of preparing.
>>
>> I added this at the dim/fact level because it is ready for analysis or to be loaded into a BI tool.

> fct_product_details
>
>> I added this model to describe product interaction from events. 
>>
>> I added this at the dim/fact level because it is ready for analysis or to be loaded into a BI tool.

## (4) What assumptions are you making about each model? (i.e. why are you adding each test?)

> For all source tables, I am testing unique and not null for the primary keys. Except for order_items, I am only testing not null because there can be multiple products associated to one order_id.

> I am also testing for acceptable values and value formats at the stage level. 
>> stg_addresses: (various tests can be applied to address elements depending on where we ship to)
>>> zipcode: needs to be 5 digits (data type is integer so I am not checking if zipcode is numeric)
>>
>> stg_users:
>>> email:  needs to include an '@' and '.'


## (5) Did you find any “bad” data as you added and ran tests on your models? How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests?

> stg_addresses.zipcode had some zipcodes that did not match a 5 digit integer format. The test will result in an error but still compile the table. Someone will need to go in an replace the incorrect zipcode with the correct zipcode at the source level. So the change does not need to be continously reapplied.