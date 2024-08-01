{{
  config(
    materialized='table'
  )
}}

WITH cte_pix_moviments AS (
    SELECT
        CAST(id AS integer) AS id
        , CAST(account_id AS integer) AS account_id
        , CAST(pix_amount AS NUMERIC) AS pix_amount
        , CAST(pix_requested_at AS integer) AS pix_requested_at
        , CAST(pix_completed_at AS STRING) AS pix_completed_at
        , CAST(status AS STRING) AS status
        , CAST(in_or_out AS STRING) AS in_or_out
    FROM {{ source('raw-data', 'pix_moviments')}}
)

SELECT * FROM cte_pix_moviments
