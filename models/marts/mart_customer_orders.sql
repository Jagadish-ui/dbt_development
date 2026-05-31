{{ config(materialized='table') }}

with orders as (

    select * from {{ ref('stg_orders') }}    -- ← ref() chains to staging model!

),

customer_summary as (

    select
        customer_id,
        count(order_id)                    as total_orders,
        sum(amount)                        as total_amount,
        sum(total_amount_with_tax)         as total_amount_with_tax,
        min(order_date)                    as first_order_date,
        max(order_date)                    as latest_order_date

    from orders
    group by customer_id

)

select
    customer_id,
    total_orders,
    total_amount,
    total_amount_with_tax,
    first_order_date,
    latest_order_date,
    datediff('day', first_order_date, latest_order_date) as customer_age_days

from customer_summary