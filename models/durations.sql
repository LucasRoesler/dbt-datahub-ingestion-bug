
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(materialized='table') }}

select
    ride_id,
    avg({{ dbt_utils.datediff("started_at", "ended_at", 'second')}}) as duration_seconds
from {{ source('citibike', 'trips') }}
group by ride_id
