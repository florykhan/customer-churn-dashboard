-- 02_clean_staging.sql
-- Clean and normalize staging data: handle nulls, types, and derived flags.
-- Run after 01_create_tables.sql and after loading raw data into staging.

-- Example: cleaned base table with consistent types and churn flag
/*
CREATE TABLE IF NOT EXISTS base_churn AS
SELECT
    customer_id,
    COALESCE(NULLIF(TRIM(gender), ''), 'Unknown') AS gender,
    COALESCE(senior_citizen, 0) AS senior_citizen,
    COALESCE(NULLIF(TRIM(contract), ''), 'Unknown') AS contract,
    CAST(COALESCE(NULLIF(TRIM(tenure), ''), '0') AS INTEGER) AS tenure,
    CAST(COALESCE(monthly_charges, 0) AS REAL) AS monthly_charges,
    CASE WHEN LOWER(COALESCE(churn_label, '')) IN ('yes', '1', 'true') THEN 1 ELSE 0 END AS churn
FROM staging_churn;
*/
