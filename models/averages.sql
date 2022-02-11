with durations as (

    select * from {{ ref('durations') }}

),

start_date as (
    select ride_id, date_trunc('day', started_at) as started
    from {{ source('citibike', 'trips') }}
),

final as (
    select started as date, rideable_type as type, avg(duration_seconds) as duration_seconds
    from {{ source('citibike', 'trips') }}
        left join durations using (ride_id)
        left join start_date using (ride_id)
    group by started, rideable_type
)

select * from final