WITH monthly_movements AS (
  SELECT
    c.action_month,
    m.account_id,
    CONCAT(a.first_name, ' ', a.last_name) AS account_name,
    SUM(IF(in_or_out = 'in', amount, 0)) AS sum_amount_in,
    SUM(IF(in_or_out = 'out', amount, 0)) AS sum_amount_out
  FROM
    `analytics-data-431111.dbt_sfaster.f_movements` m
  LEFT JOIN
    `dbt_sfaster.d_calendar` c
  ON
    m.movement_requested_at = c.time_id
  LEFT JOIN `dbt_sfaster.d_customer_accounts` a
  ON m.account_id = a.account_id
  WHERE c.action_timestamp BETWEEN '2020-01-01' AND '2020-12-31'
  AND m.status = 'completed'
  GROUP BY
    c.action_month,
    m.account_id,
    CONCAT(a.first_name, ' ', a.last_name)
),
cumulative_balances AS (
  SELECT
    account_id,
    account_name,
    action_month,
    sum_amount_in,
    sum_amount_out,
    SUM(sum_amount_in - sum_amount_out) 
      OVER (PARTITION BY account_id ORDER BY action_month ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_balance
  FROM
    monthly_movements
)
SELECT
  action_month,
  account_id,
  account_name,
  sum_amount_in,
  sum_amount_out,
  cumulative_balance
FROM
  cumulative_balances
ORDER BY
  account_id,
  action_month
