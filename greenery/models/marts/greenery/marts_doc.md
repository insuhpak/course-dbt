# int_orders_fk_joined_notunique_pl
{% docs int_orders_fk_joined_notunique_pk %}
- This table is produced by the following joins:
stg_orders (+)stg_users (+)stg_promos (+)stg_addresses (+)stg_order_items (+)stg_products

- The base table is stg_orders. All base table's foreign keys have be joined. Therefore, the base table's primary key's uniquness is broken. 

- There may be multiple rows for one order_id because one order may contain multiple products. There is one row for each product item per order_id. 

- The primary key to this table would be a composite key of order_id and product_id.

{% enddocs %}

# int_orders_fk_joined_unique_pk
{% docs int_orders_fk_joined_unique_pk %}

- This table is produced by the following joins:
stg_orders (+)stg_users (+)stg_promos (+)stg_addresses

- The base table is stg_orders. All possible base table's foreign keys have been join while still maintaining the primary key's uniqueness. (Not all foreign keys have been joined to the base table.)

{% enddocs %}

# int_order_items_product_info_joined
{% docs int_order_items_product_info_joined %}

- This table is produced by the following join:
stg_order_items (+)stg_products

- The primary key to this table would be a composite key of order_id and product_id. 

{% enddocs %}

# int_sessions_order_and_product_info_notunique_pk
{% docs int_sessions_order_and_product_info_notunique_pk %}

- This table is produced by the following join: stg_events (+)stg_order_items (+)stg_products

- The primary key to this table would be a composite key of event_id and product_id

- There may be multiple rows for one event_id if it is a checkout or package_shipped event because one order may have multiple products.

{%enddocs%}