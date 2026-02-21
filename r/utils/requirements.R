# requirements.R
# R dependencies for the churn analytics pipeline (SQL → R → Tableau)
# Run in R: source("r/utils/requirements.R") or install packages manually.

# Database connectivity
if (!requireNamespace("DBI",      quietly = TRUE)) install.packages("DBI")
if (!requireNamespace("RSQLite",  quietly = TRUE)) install.packages("RSQLite")

# Data manipulation and export
if (!requireNamespace("dplyr",   quietly = TRUE)) install.packages("dplyr")
if (!requireNamespace("tidyr",   quietly = TRUE)) install.packages("tidyr")
if (!requireNamespace("readr",   quietly = TRUE)) install.packages("readr")

# Optional: for other DB backends (e.g. Postgres)
# if (!requireNamespace("RPostgres", quietly = TRUE)) install.packages("RPostgres")
# if (!requireNamespace("odbc",      quietly = TRUE)) install.packages("odbc")
