{{ config(materialized='view') }}

with raw_orders as (

    select * from {{ source('raw', 'raw_orders') }}

)

select
    order_id,
    customer_id,
    status,
    amount,
    {{ calculate_tax('amount') }}           as total_amount_with_tax,
    {{ calculate_tax('amount', 0.05) }}     as total_amount_with_gst,
    order_date::date                        as order_date,
    {{ audit_columns() }}

from raw_orders
where status != 'cancelled'