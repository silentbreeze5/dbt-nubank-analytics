{{
  config(
    materialized='table'
  )
}}

WITH cte_pix_movements AS (
SELECT 
  id
  , account_id
  , pix_amount AS amount
  , pix_requested_at AS movement_requested_at
  , pix_completed_at AS movement_completed_at
  , status
  , 'PIX' AS movement_type
  , CASE WHEN in_or_out = 'pix_in' THEN 'in' ELSE 'out' END AS in_or_out
FROM `analytics-data-431111.dbt_sfaster.stg_pix_movements`
)

, cte_transfer_ins_movements AS (
 SELECT 
  id
  , account_id
  , amount
  , transaction_requested_at AS move_requested_at
  , transaction_completed_at AS move_completed_at
  , status
  , 'TRANSACTION' AS movement_type
  , 'in' AS in_or_out
 FROM `analytics-data-431111.dbt_sfaster.stg_transfer_ins`
)

, cte_transfer_outs_movements AS (
 SELECT 
  id
  , account_id
  , amount
  , transaction_requested_at AS move_requested_at
  , transaction_completed_at AS move_completed_at
  , status
  , 'TRANSACTION' AS movement_type
  , 'out' AS in_or_out
 FROM `analytics-data-431111.dbt_sfaster.stg_transfer_outs`
)

, cte_unioned AS (
  SELECT * FROM cte_pix_movements
  UNION ALL
  SELECT * FROM cte_transfer_ins_movements
  UNION ALL
  SELECT * FROM cte_transfer_outs_movements
)

SELECT * FROM cte_unioned