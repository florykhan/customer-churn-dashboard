-- 02_kpi_views.sql
-- KPI views for churn rate, revenue at risk, and segment-level metrics.
-- Run after queries/01_clean_staging.sql. Consumed by R and/or Tableau.

-- Example: overall churn KPI
/*
CREATE VIEW IF NOT EXISTS v_churn_kpi AS
SELECT
    COUNT(*) AS total_customers,
    SUM(churn) AS churned,
    ROUND(100.0 * SUM(churn) / NULLIF(COUNT(*), 0), 2) AS churn_rate_pct,
    SUM(CASE WHEN churn = 1 THEN monthly_charges ELSE 0 END) AS mrr_at_risk
FROM base_churn;
*/

-- Example: churn by segment (e.g. contract type)
/*
CREATE VIEW IF NOT EXISTS v_churn_by_contract AS
SELECT
    contract,
    COUNT(*) AS n,
    SUM(churn) AS churned,
    ROUND(100.0 * SUM(churn) / NULLIF(COUNT(*), 0), 2) AS churn_rate_pct
FROM base_churn
GROUP BY contract;
*/
