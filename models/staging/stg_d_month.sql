{{
  config(
    materialized='table'
  )
}}

WITH cte_d_month AS (
    SELECT
        CAST(month_id AS integer) AS month_id
        , CAST(action_month AS integer) AS action_month
    FROM {{ source('raw-data', 'd_month')}}
)

SELECT * FROM cte_d_month
