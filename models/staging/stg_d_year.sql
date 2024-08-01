{{
  config(
    materialized='table'
  )
}}

WITH cte_d_year AS (
    SELECT
        CAST(year_id AS integer) AS year_id
        , CAST(action_year AS integer) AS action_year
    FROM {{ source('raw-data', 'd_year')}}
)

SELECT * FROM cte_d_year
