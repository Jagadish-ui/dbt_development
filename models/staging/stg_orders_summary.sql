{{ config(materialized='view') }}

with orders as (

    select * from {{ ref('stg_orders') }}

),

summary as (

    select
        status,
        count(order_id)                         as total_orders,
        sum(amount)                             as total_amount,
        {{ calculate_tax('sum(amount)') }}      as total_with_tax,
        min(order_date)                         as first_order_date,
        max(order_date)                         as latest_order_date

    from orders
    group by status

)

select * from summary