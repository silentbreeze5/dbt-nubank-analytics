{{
  config(
    materialized='table'
  )
}}

WITH cte_d_time AS (
    SELECT
        time_id,
        action_timestamp,
        week_id,
        month_id,
        year_id,
        weekday_id
    FROM {{ ref('stg_d_time') }}
),

cte_d_week AS (
    SELECT
        week_id,
        action_week
    FROM {{ ref('stg_d_week') }}
),

cte_d_weekday AS (
    SELECT
        weekday_id,
        action_weekday
    FROM {{ ref('stg_d_weekday') }}
),

cte_d_month AS (
    SELECT
        month_id,
        action_month
    FROM {{ ref('stg_d_month') }}
),

cte_d_year AS (
    SELECT
        year_id,
        action_year
    FROM {{ ref('stg_d_year') }}
)

SELECT 
    t.time_id,
    t.action_timestamp,
    t.week_id,
    w.action_week,
    t.weekday_id,
    wd.action_weekday,
    t.month_id,
    m.action_month,
    t.year_id,
    y.action_year
FROM cte_d_time t
LEFT JOIN cte_d_week w ON t.week_id = w.week_id
LEFT JOIN cte_d_weekday wd ON t.weekday_id = wd.weekday_id
LEFT JOIN cte_d_month m ON t.month_id = m.month_id
LEFT JOIN cte_d_year y ON t.year_id = y.year_id
