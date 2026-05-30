{{ config(materialized='view') }}

with raw_orders as (

    select
        1 as order_id,
        'customer_001' as customer_id,
        'completed' as status,
        100.00 as amount,
        '2024-01-01' as order_date

    union all

    select
        2,
        'customer_002',
        'pending',
        200.00,
        '2024-01-02'

    union all

    select
        3,
        'customer_003',
        'cancelled',
        50.00,
        '2024-01-03'

)

select
    order_id,
    customer_id,
    status,
    amount,
    amount * 1.18 as total_amount_with_tax,   -- add 18% tax
    order_date::date as order_date,
    current_timestamp as loaded_at             -- audit column

from raw_orders
where status != 'cancelled'                   -- filter cancelled orders