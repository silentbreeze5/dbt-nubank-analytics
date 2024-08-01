{{
  config(
    materialized='table'
  )
}}

WITH cte_country AS (
    SELECT
        country.country as country_name
        , CAST(country_id AS integer) AS country_id
    FROM {{ source('raw-data', 'country')}}
)

SELECT * FROM cte_country
