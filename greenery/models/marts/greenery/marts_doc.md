{% docs int_orders_fk_joined_notunique_pk %}
    This table is produced by the following joins:
    stg_orders (+)stg_users (+)stg_promos (+)stg_addresses (+)stg_order_items (+)stg_products

    The base table is stg_orders. All base table's foreign keys have be joined. Therefore, the base table's primary key's uniquness is broken. 

    There may be multiple rows for one order_id because one order may contain multiple products. There is one row for each product item per order_id. 

    The primary key to this table would be a composite key of order_id and product_id.

{% enddocs %}

{% docs int_orders_fk_joined_unique_pk %}

    This table is produced by the following joins:
    stg_orders (+)stg_users (+)stg_promos (+)stg_addresses

    The base table is stg_orders. All possible base table's foreign keys have been join while still maintaining the primary key's uniqueness. (Not all foreign keys have been joined to the base table.)

{% enddocs %}

{% docs int_order_items_product_info_joined %}

    This table included events details with product detail added. Product detail is only added for events that do not have order_ids. 

    This table is produced by the following join:
    stg_events (+)stg_products


    The base table is stg_events. The base table's product_id foreign key is the only join. (Not all foreing keys have been joined to the base table.)

{% enddocs %}