{% test five_digit_integer(model, column_name) %}

    select * from {{ model }}
    
    where char_length({{ column_name }}::varchar) <> 5

{% endtest %}