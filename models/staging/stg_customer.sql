{{
  config(
    materialized='table'
  )
}}

WITH cte_customers AS (
    SELECT
        CAST(customer_id AS integer) AS customer_id
        , CAST(first_name AS STRING) AS first_name
        , CAST(last_name AS STRING) AS last_name
        , CAST(customer_city AS integer) AS customer_city
        , CAST(cpf AS integer) AS cpf
        , CAST(country_name AS STRING) AS country_name
    FROM {{ source('raw-data', 'customers')}}
)

SELECT * FROM cte_customers
