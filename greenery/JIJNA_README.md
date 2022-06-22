# Jinja Syntax

Jinja is wrapped with ```{% %}```.

To strip whitespace add a - in the syntax: ```{%- -%}```.

# Retrieving a list of values

## using a **variable**

```sql
{% set variable_name = ["value1", "value2", "value3"] %}
```
Simply refer to the variable_name by using *variable_name*. No special syntax needed.

## using a **macro**
```sql
{% macro macro_name() %}
    {{ return(["value1","value2","value3"]) }}
{% endmacro %}
```

We can use a variable to store the macro output to use in our SQL. (Note, the above macro takes in no input.)
```sql
{% set macro_return_variable = macro_name() %}
```

## using a **statement block** (dynamic method)
You could write your own macro. However, dbt_utils.get_column_values() will retrieve column values for you. 



