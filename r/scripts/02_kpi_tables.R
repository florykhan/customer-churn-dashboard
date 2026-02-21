# 02_kpi_tables.R
# Query KPI views from the database and export CSVs for Tableau.
# Run after SQL pipeline and (optionally) after 01_extract_from_sql.R.
# Set working directory to project root.

library(DBI)
library(RSQLite)
library(readr)

db_path <- "data/churn.db"
out_dir <- "data/processed"

if (!file.exists(db_path)) {
  stop("Database not found at ", db_path, ". Run the SQL pipeline first.")
}
dir.create(out_dir, showWarnings = FALSE, recursive = TRUE)

con <- dbConnect(RSQLite::SQLite(), db_path)

# Overall KPI (single row)
kpi_overall <- dbGetQuery(con, "SELECT * FROM v_churn_kpi")
write_csv(kpi_overall, file.path(out_dir, "kpi_overall.csv"))

# By contract
kpi_by_contract <- dbGetQuery(con, "SELECT * FROM v_churn_by_contract")
write_csv(kpi_by_contract, file.path(out_dir, "kpi_by_contract.csv"))

# By payment method
kpi_by_payment <- dbGetQuery(con, "SELECT * FROM v_churn_by_payment")
write_csv(kpi_by_payment, file.path(out_dir, "kpi_by_payment.csv"))

# By tenure bucket
kpi_by_tenure_bucket <- dbGetQuery(con, "SELECT * FROM v_churn_by_tenure_bucket")
write_csv(kpi_by_tenure_bucket, file.path(out_dir, "kpi_by_tenure_bucket.csv"))

# By internet service
kpi_by_internet <- dbGetQuery(con, "SELECT * FROM v_churn_by_internet")
write_csv(kpi_by_internet, file.path(out_dir, "kpi_by_internet.csv"))

dbDisconnect(con)

message("Exported 5 KPI tables to ", out_dir, ".")
