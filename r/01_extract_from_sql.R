# 01_extract_from_sql.R
# Extract data from the SQL database (e.g. SQLite/Postgres) into R.
# Run after SQL pipeline (01–03) has been executed.

# Example using DBI + RSQLite (adjust driver/connection for your DB):
# library(DBI)
# library(RSQLite)
# con <- dbConnect(RSQLite::SQLite(), "path/to/your/churn.db")
# staging <- dbReadTable(con, "staging_churn")
# base    <- dbReadTable(con, "base_churn")
# dbDisconnect(con)
