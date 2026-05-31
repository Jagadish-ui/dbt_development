{{
    config(
        materialized='incremental',
        unique_key='order_id'
    )
}}

with new_orders as (

    select
        1                       as order_id,
        'customer_001'          as customer_id,
        'completed'             as status,
        100.00                  as amount,
        '2024-01-01'::date      as order_date,
        '2024-01-01'::timestamp as created_at

    union all

    select
        2,
        'customer_002',
        'pending',
        200.00,
        '2024-01-02'::date,
        '2024-01-02'::timestamp

    union all

    select
        3,
        'customer_003',
        'completed',
        300.00,
        '2024-01-03'::date,
        '2024-01-03'::timestamp

    union all

    select
        4,
        'customer_004',
        'completed',
        400.00,
        '2024-01-04'::date,
        '2024-01-04'::timestamp     -- ← newer timestamp!

)

select * from new_orders

{% if is_incremental() %}

    -- This filter only runs on SUBSEQUENT runs
    -- Only picks up records newer than what's already in the table
    where created_at > (
        select max(created_at) from {{ this }}
    )

{% endif %}