WITH cte_accounts AS (
    SELECT
        CAST(account_id AS integer) AS account_id
        , CAST(customer_id AS integer) AS customer_id
        , CAST(created_at AS timestamp) AS created_at
        , CAST(status AS STRING) AS status
        , CAST(account_branch AS integer) AS account_branch
        , CAST(account_check_digit AS integer) AS account_check_digit
        , CAST(account_number AS integer) AS account_number
    FROM {{ source('raw-data', 'accounts')}}
)

SELECT * FROM cte_accounts