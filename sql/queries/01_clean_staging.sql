-- 01_clean_staging.sql
-- Clean staging data and build base table for analytics.
-- Run after schema/create_tables.sql and after loading data into staging_churn.

-- Drop and recreate so the script is idempotent
DROP TABLE IF EXISTS base_churn;

CREATE TABLE base_churn AS
SELECT
    customerID AS customer_id,
    TRIM(COALESCE(gender, '')) AS gender,
    COALESCE(SeniorCitizen, 0) AS senior_citizen,
    TRIM(COALESCE(Partner, '')) AS partner,
    TRIM(COALESCE(Dependents, '')) AS dependents,
    COALESCE(tenure, 0) AS tenure,
    TRIM(COALESCE(PhoneService, '')) AS phone_service,
    TRIM(COALESCE(MultipleLines, '')) AS multiple_lines,
    TRIM(COALESCE(InternetService, '')) AS internet_service,
    TRIM(COALESCE(Contract, '')) AS contract,
    TRIM(COALESCE(PaperlessBilling, '')) AS paperless_billing,
    TRIM(COALESCE(PaymentMethod, '')) AS payment_method,
    COALESCE(MonthlyCharges, 0) AS monthly_charges,
    CAST(
        CASE
            WHEN TRIM(COALESCE(TotalCharges, '')) = '' THEN NULL
            ELSE TRIM(TotalCharges)
        END AS REAL
    ) AS total_charges,
    CASE
        WHEN LOWER(TRIM(COALESCE(Churn, ''))) IN ('yes', '1', 'true') THEN 1
        ELSE 0
    END AS churn
FROM staging_churn;

-- Index for downstream joins and filters
CREATE INDEX IF NOT EXISTS idx_base_churn_customer_id ON base_churn(customer_id);
CREATE INDEX IF NOT EXISTS idx_base_churn_churn ON base_churn(churn);
CREATE INDEX IF NOT EXISTS idx_base_churn_contract ON base_churn(contract);
