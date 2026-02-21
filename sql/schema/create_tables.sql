-- create_tables.sql
-- Create schema and staging tables for Telco Customer Churn data.
-- Run this first when setting up the analytics database.

-- Example: staging table for raw churn data
-- Adjust column types to match your Telco CSV (e.g. from Kaggle).
/*
CREATE TABLE IF NOT EXISTS staging_churn (
    customer_id     TEXT,
    gender          TEXT,
    senior_citizen  INTEGER,
    partner         TEXT,
    dependents      TEXT,
    tenure          INTEGER,
    phone_service   TEXT,
    multiple_lines  TEXT,
    internet_service TEXT,
    online_security TEXT,
    online_backup   TEXT,
    device_protection TEXT,
    tech_support    TEXT,
    streaming_tv    TEXT,
    streaming_movies TEXT,
    contract        TEXT,
    paperless_billing TEXT,
    payment_method  TEXT,
    monthly_charges REAL,
    total_charges   TEXT,
    churn_label     TEXT
);
*/
