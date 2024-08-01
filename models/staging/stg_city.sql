{{
  config(
    materialized='table'
  )
}}

WITH cte_city AS (
    SELECT
        city.city AS city_name
        , CAST(state_id AS integer) AS state_id
        , CAST(city_id AS integer) AS city_id 
    FROM {{ source('raw-data', 'city')}}
)

SELECT * FROM cte_city