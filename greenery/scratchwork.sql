    select 
        user_id,
        count(distinct id) as orders_per_user,
        1 as temp_value

    from dbt_insuh_p.stg_orders

    group by user_id
    order by orders_per_user