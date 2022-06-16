{% docs int_orders_all_details %}

This table includes all order details (except event details). There may be multiple rows for one order because one order may contain multiple different products. There is one row for each product item per order.

stg_orders (+)stg_users (+)stg_promos (+)stg_addresses (+)stg_order_items (+)stg_products

{% enddocs %}

{% docs int_orders_more_details %}

This table includes more order details (except event, order item, and product details. Unlike int_orders_all_details, one order may only have one row in this table.
      

stg_orders (+)stg_users (+)stg_promos (+)stg_addresses

{% enddocs %}