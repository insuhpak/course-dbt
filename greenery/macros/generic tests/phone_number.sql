{% test phone_number(model, column_name) %}

    select * from {{ model }}

    where {{ column_name }} not like '___-___-____'

{% endtest %}