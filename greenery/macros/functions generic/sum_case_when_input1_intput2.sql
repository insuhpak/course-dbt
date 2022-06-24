{%- macro sum_case_when_input1_input2(column_name, value, then_value, else_value) -%}

    sum( case when {{column_name}} = '{{value}}' then {{then_value}} else {{else_value}} end )

{%- endmacro -%}