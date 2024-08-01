{{
  config(
    materialized='table'
  )
}}

WITH cte_state AS (
    SELECT
        state.state AS state_name
        , CAST(state.country_id AS integer) AS country_id
        , CAST(state.state_id AS integer) AS state_id
    FROM {{ source('raw-data', 'state')}}
)

SELECT * FROM cte_state

