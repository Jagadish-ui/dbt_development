{% macro calculate_tax(amount, tax_rate=0.18) %}
    {{ amount }} * (1 + {{ tax_rate }})
{% endmacro %}