# 03_churn_drivers.R
# Analyze churn drivers and export segment-level tables for Tableau.
# Reads base_churn from the database; run after SQL pipeline.
# Set working directory to project root.

library(DBI)
library(RSQLite)
library(dplyr)
library(readr)

db_path <- "data/churn.db"
out_dir <- "data/processed"

if (!file.exists(db_path)) {
  stop("Database not found at ", db_path, ". Run the SQL pipeline first.")
}
dir.create(out_dir, showWarnings = FALSE, recursive = TRUE)

con <- dbConnect(RSQLite::SQLite(), db_path)
base_churn <- dbReadTable(con, "base_churn")
dbDisconnect(con)

# Coerce numeric columns (SQLite can return mixed types via dbReadTable)
base_churn <- base_churn %>%
  mutate(
    tenure = as.integer(tenure),
    senior_citizen = as.integer(senior_citizen),
    monthly_charges = as.numeric(monthly_charges),
    total_charges = as.numeric(total_charges),
    churn = as.integer(churn)
  )

# Tenure bucket (match SQL view: 0-12, 13-24, 25-36, 37-48, 49+)
base_churn <- base_churn %>%
  mutate(
    tenure_bucket = case_when(
      tenure <= 12  ~ "0-12",
      tenure <= 24  ~ "13-24",
      tenure <= 36  ~ "25-36",
      tenure <= 48  ~ "37-48",
      TRUE          ~ "49+"
    )
  )

# Contract x tenure bucket: churn rate and MRR at risk (for Tableau)
churn_by_contract_tenure <- base_churn %>%
  group_by(contract, tenure_bucket) %>%
  summarise(
    n = n(),
    churned = sum(churn),
    churn_rate_pct = round(100 * mean(churn), 2),
    mrr = round(sum(monthly_charges), 2),
    mrr_at_risk = round(sum(monthly_charges * churn), 2),
    .groups = "drop"
  )

write_csv(churn_by_contract_tenure, file.path(out_dir, "churn_drivers_contract_tenure.csv"))

# Contract x internet service: high-risk segment view
churn_by_contract_internet <- base_churn %>%
  group_by(contract, internet_service) %>%
  summarise(
    n = n(),
    churned = sum(churn),
    churn_rate_pct = round(100 * mean(churn), 2),
    mrr = round(sum(monthly_charges), 2),
    mrr_at_risk = round(sum(monthly_charges * churn), 2),
    .groups = "drop"
  )

write_csv(churn_by_contract_internet, file.path(out_dir, "churn_drivers_contract_internet.csv"))

message("Exported churn driver tables to ", out_dir, ".")
