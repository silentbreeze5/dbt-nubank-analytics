{{
  config(
    materialized='table'
  )
}}

WITH cte_d_weekday AS (
    SELECT
        CAST(weekday_id AS integer) AS weekday_id
        , CAST(action_weekday AS integer) AS action_weekday
    FROM {{ source('raw-data', 'd_weekday')}}
)

SELECT * FROM cte_d_weekday
