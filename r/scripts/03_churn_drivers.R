# 03_churn_drivers.R
# Analyze churn drivers (e.g. tenure, contract, services) and export
# summary tables or model outputs for the Tableau dashboard.

# Example: segment-level churn rates and revenue at risk for dashboard.
# driver_summary <- base %>%
#   group_by(contract, tenure_bucket) %>%
#   summarise(n = n(), churn_rate = mean(churn), mrr = sum(monthly_charges), .groups = "drop")
# write.csv(driver_summary, "data/processed/churn_drivers.csv", row.names = FALSE)
