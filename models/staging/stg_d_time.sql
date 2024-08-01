{{
  config(
    materialized='table'
  )
}}

WITH cte_d_time AS (
    SELECT
        CAST(time_id AS integer) AS time_id
        , CAST(action_timestamp AS timestamp) AS action_timestamp
        , CAST(week_id AS integer) AS week_id
        , CAST(month_id AS integer) AS month_id
        , CAST(year_id AS integer) AS year_id
        , CAST(weekday_id AS integer) AS weekday_id
    FROM {{ source('raw-data', 'd_time')}}
)

SELECT * FROM cte_d_time
