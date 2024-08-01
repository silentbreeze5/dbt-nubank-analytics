{{
  config(
    materialized='table'
  )
}}

WITH cte_tranfer_ins AS (
    SELECT
        CAST(id AS integer) AS id
        , CAST(account_id AS integer) AS account_id
        , CAST(amount AS NUMERIC) AS amount
        , CAST(transaction_requested_at AS integer) AS transaction_requested_at
        , CAST(transaction_completed_at AS STRING) AS transaction_completed_at
        , CAST(status AS STRING) AS status
    FROM {{ source('raw-data', 'transfer_ins')}}
)

SELECT * FROM cte_tranfer_ins
