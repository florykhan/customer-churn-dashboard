# 01_extract_from_sql.R
# Extract data from the SQLite database into R.
# Run after SQL pipeline (schema + queries) has been executed.
# Set working directory to project root, or adjust db_path accordingly.
# Source r/utils/requirements.R first if needed.

library(DBI)
library(RSQLite)

db_path <- "data/churn.db"
if (!file.exists(db_path)) {
  stop("Database not found at ", db_path, ". Run the SQL pipeline first (schema + load CSV + queries).")
}

con <- dbConnect(RSQLite::SQLite(), db_path)

staging_churn <- dbReadTable(con, "staging_churn")
base_churn    <- dbReadTable(con, "base_churn")

dbDisconnect(con)

# Optional: attach to search path for interactive use or downstream scripts
# attach(base_churn)  # or keep in global env as base_churn
message("Loaded staging_churn (", nrow(staging_churn), " rows) and base_churn (", nrow(base_churn), " rows).")
