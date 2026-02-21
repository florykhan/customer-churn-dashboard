-- create_tables.sql
-- Schema for Telco Customer Churn data

-- Staging table: columns match the raw CSV header for direct import
CREATE TABLE IF NOT EXISTS staging_churn (
    customerID       TEXT,
    gender           TEXT,
    SeniorCitizen    INTEGER,
    Partner          TEXT,
    Dependents       TEXT,
    tenure           INTEGER,
    PhoneService     TEXT,
    MultipleLines    TEXT,
    InternetService  TEXT,
    OnlineSecurity   TEXT,
    OnlineBackup     TEXT,
    DeviceProtection TEXT,
    TechSupport      TEXT,
    StreamingTV      TEXT,
    StreamingMovies  TEXT,
    Contract         TEXT,
    PaperlessBilling TEXT,
    PaymentMethod    TEXT,
    MonthlyCharges   REAL,
    TotalCharges     TEXT,
    Churn            TEXT
);

-- index for lookups and joins
CREATE INDEX IF NOT EXISTS idx_staging_churn_customerID ON staging_churn(customerID);
