# 02_kpi_tables.R
# Build KPI tables and aggregates for Tableau (e.g. export to data/processed/).
# Depends on scripts/01_extract_from_sql.R (or equivalent data load).

# Example:
# kpi_overall <- dbGetQuery(con, "SELECT * FROM v_churn_kpi")
# kpi_by_contract <- dbGetQuery(con, "SELECT * FROM v_churn_by_contract")
# write.csv(kpi_overall, "data/processed/kpi_overall.csv", row.names = FALSE)
# write.csv(kpi_by_contract, "data/processed/kpi_by_contract.csv", row.names = FALSE)
