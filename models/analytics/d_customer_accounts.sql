{{
  config(
    materialized='table'
  )
}}

WITH cte_customers AS (
    SELECT
        customer_id,
        first_name,
        last_name,
        customer_city,
        cpf,
        country_name
    FROM {{ ref('stg_customer') }}
),

cte_accounts AS (
    SELECT
        account_id,
        customer_id,
        created_at,
        status,
        account_branch,
        account_check_digit,
        account_number
    FROM {{ ref('stg_accounts') }}
)

SELECT 
    a.account_id,
    a.customer_id,
    c.first_name,
    c.last_name,
    c.customer_city,
    c.cpf,
    c.country_name,
    a.created_at,
    a.status,
    a.account_branch,
    a.account_check_digit,
    a.account_number
FROM cte_accounts a
JOIN cte_customers c ON a.customer_id = c.customer_id
