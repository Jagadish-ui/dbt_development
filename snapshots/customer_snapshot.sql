{% snapshot customer_snapshot %}

{{
    config(
        target_schema='snapshots',
        unique_key='customer_id',
        strategy='timestamp',
        updated_at='updated_at'
    )
}}

with customer_data as (

    select
        'customer_001'              as customer_id,
        'John Doe'                  as customer_name,
        'john.NEW@gmail.com'        as email,
        'Bengaluru'                 as city,
        '2024-02-01'::timestamp     as updated_at

    union all

    select
        'customer_002',
        'Jane Smith',
        'jane@gmail.com',
        'Mumbai',
        '2024-01-01'::timestamp

)

select * from customer_data

{% endsnapshot %}