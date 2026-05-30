
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(materialized='table') }}

with source_data as (
    select 1 as id
    union all
    select 2 as id
)

select
    id,
    case
        when id is not null then true
        else false
    end as is_valid,
    id * 2 as id_doubled        -- ← new column!

from source_data

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
