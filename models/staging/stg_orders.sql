{{ config(materialized='view') }}

with raw_orders as (

    -- Using source() instead of hardcoded table name!
    select * from {{ source('raw', 'raw_orders') }}

)

select
    order_id,
    customer_id,
    status,
    amount,
    amount * 1.18       as total_amount_with_tax,
    order_date::date    as order_date,
    current_timestamp   as loaded_at

from raw_orders
where status != 'cancelled'