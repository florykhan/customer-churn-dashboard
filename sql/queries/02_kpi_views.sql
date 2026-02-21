-- 02_kpi_views.sql
-- KPI views for churn rate, revenue at risk, and segment breakdowns.
-- Run after queries/01_clean_staging.sql. Consumed by R and Tableau.

-- Overall churn KPI (single row)
CREATE VIEW IF NOT EXISTS v_churn_kpi AS
SELECT
    COUNT(*) AS total_customers,
    SUM(churn) AS churned,
    COUNT(*) - SUM(churn) AS retained,
    ROUND(100.0 * SUM(churn) / NULLIF(COUNT(*), 0), 2) AS churn_rate_pct,
    ROUND(SUM(monthly_charges), 2) AS total_mrr,
    ROUND(SUM(CASE WHEN churn = 1 THEN monthly_charges ELSE 0 END), 2) AS mrr_at_risk,
    ROUND(100.0 * SUM(CASE WHEN churn = 1 THEN monthly_charges ELSE 0 END) / NULLIF(SUM(monthly_charges), 0), 2) AS pct_revenue_at_risk
FROM base_churn;

-- Churn and MRR by contract type
CREATE VIEW IF NOT EXISTS v_churn_by_contract AS
SELECT
    contract,
    COUNT(*) AS n,
    SUM(churn) AS churned,
    ROUND(100.0 * SUM(churn) / NULLIF(COUNT(*), 0), 2) AS churn_rate_pct,
    ROUND(SUM(monthly_charges), 2) AS mrr,
    ROUND(SUM(CASE WHEN churn = 1 THEN monthly_charges ELSE 0 END), 2) AS mrr_at_risk
FROM base_churn
GROUP BY contract
ORDER BY churn_rate_pct DESC;

-- Churn and MRR by payment method
CREATE VIEW IF NOT EXISTS v_churn_by_payment AS
SELECT
    payment_method,
    COUNT(*) AS n,
    SUM(churn) AS churned,
    ROUND(100.0 * SUM(churn) / NULLIF(COUNT(*), 0), 2) AS churn_rate_pct,
    ROUND(SUM(monthly_charges), 2) AS mrr,
    ROUND(SUM(CASE WHEN churn = 1 THEN monthly_charges ELSE 0 END), 2) AS mrr_at_risk
FROM base_churn
GROUP BY payment_method
ORDER BY n DESC;

-- Churn and MRR by tenure bucket (0–12, 13–24, 25–36, 37–48, 49+ months)
CREATE VIEW IF NOT EXISTS v_churn_by_tenure_bucket AS
SELECT
    CASE
        WHEN tenure <= 12  THEN '0-12'
        WHEN tenure <= 24 THEN '13-24'
        WHEN tenure <= 36 THEN '25-36'
        WHEN tenure <= 48 THEN '37-48'
        ELSE '49+'
    END AS tenure_bucket,
    COUNT(*) AS n,
    SUM(churn) AS churned,
    ROUND(100.0 * SUM(churn) / NULLIF(COUNT(*), 0), 2) AS churn_rate_pct,
    ROUND(SUM(monthly_charges), 2) AS mrr,
    ROUND(SUM(CASE WHEN churn = 1 THEN monthly_charges ELSE 0 END), 2) AS mrr_at_risk
FROM base_churn
GROUP BY tenure_bucket
ORDER BY MIN(tenure);

-- Churn by internet service type
CREATE VIEW IF NOT EXISTS v_churn_by_internet AS
SELECT
    internet_service,
    COUNT(*) AS n,
    SUM(churn) AS churned,
    ROUND(100.0 * SUM(churn) / NULLIF(COUNT(*), 0), 2) AS churn_rate_pct,
    ROUND(SUM(monthly_charges), 2) AS mrr,
    ROUND(SUM(CASE WHEN churn = 1 THEN monthly_charges ELSE 0 END), 2) AS mrr_at_risk
FROM base_churn
GROUP BY internet_service
ORDER BY n DESC;
