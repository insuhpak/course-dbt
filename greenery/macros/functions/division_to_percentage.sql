{% macro division_to_percentage(numerator, denominator, precision=2) %}

    round(
            {{ numerator }} / {{ denominator }} :: numeric * 100,
            {{ precision }}
         ) || '%'


{% endmacro %}