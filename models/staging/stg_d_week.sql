{{
  config(
    materialized='table'
  )
}}

WITH cte_d_week AS (
    SELECT
        CAST(week_id AS integer) AS week_id
        , CAST(action_week AS integer) AS action_week
    FROM {{ source('raw-data', 'd_week')}}
)

SELECT * FROM cte_d_week
