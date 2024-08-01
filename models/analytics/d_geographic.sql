WITH cte_geographic AS (
SELECT
    c.city_id
    , c.city_name
    , s.state_id
    , s.state_name
    , co.country_id
    , co.country_name
    , md5(CONCAT(c.city_id, s.state_id, co.country_id)) AS geo_id
FROM {{ ref('stg_city') }} c
LEFT JOIN {{ ref('stg_state') }} s ON c.state_id = s.state_id
LEFT JOIN {{ ref('stg_country') }} co ON s.country_id = co.country_id
)

SELECT * FROM cte_geographic