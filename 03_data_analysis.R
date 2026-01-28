# --- PART 3: ADVANCED DATA ANALYSIS (PREMIUM) ---
library(ggplot2)

# 1. Load Data Manually (Ensures reproducibility)
concurrent_data <- c(17.2, 22.1, 18.5, 17.2, 18.6, 14.8, 21.7, 15.8, 16.3, 22.8, 
                     24.1, 13.3, 16.2, 17.5, 19.0, 23.9, 14.8, 22.2, 21.7, 20.7, 
                     13.5, 15.8, 13.1, 16.1, 21.9, 23.9, 19.3, 12.0, 19.9, 19.4, 
                     15.4, 16.7, 19.5, 16.2, 16.9, 17.1, 20.2, 13.4, 19.8, 17.7, 
                     19.7, 18.7, 17.6, 15.9, 15.2, 17.1, 15.0, 18.8, 21.6, 11.9)

# Create a data frame for ggplot
df <- data.frame(Users = concurrent_data)

# 2. Assumption Checking (Normality)
#    A t-test assumes the data is normally distributed.
cat("================================================\n")
cat("   PART 3: DATA ANALYSIS & INFERENCE            \n")
cat("================================================\n")

shapiro_res <- shapiro.test(concurrent_data)
cat("1. Normality Check (Shapiro-Wilk Test):\n")
print(shapiro_res)

if(shapiro_res$p.value > 0.05) {
  cat(">> CONCLUSION: p > 0.05. Data is Normal. T-test is valid.\n")
} else {
  cat(">> CONCLUSION: p < 0.05. Data is NOT Normal (Use Wilcoxon).\n")
}

# 3. Visualization: Histogram + Density Curve
#    This visually confirms what the Shapiro test told us.
mean_val <- mean(concurrent_data)

p2 <- ggplot(df, aes(x = Users)) +
  # Histogram
  geom_histogram(aes(y = ..density..), bins = 8, 
                 fill = "#69b3a2", color = "white", alpha = 0.7) +
  # Density Curve (Smooth)
  geom_density(color = "#FF6666", size = 1.2) +
  # Mean Line
  geom_vline(aes(xintercept = mean_val), color = "blue", linetype = "dashed", size = 1) +
  # Labels
  labs(title = "Distribution of Concurrent Users",
       subtitle = paste("Shapiro-Wilk p =", round(shapiro_res$p.value, 3), 
                        "| Mean =", round(mean_val, 2)),
       x = "Number of Users",
       y = "Density") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold", size = 14))

ggsave("Distribution_Check.png", p2, width = 8, height = 5, dpi = 300)

# 4. Statistical Inference (One-Sample t-test)
#    Hypothesis: Is the mean > 15?
cat("------------------------------------------------\n")
cat("2. Statistical Inference (t-test):\n")
t_test_res <- t.test(concurrent_data, mu = 15, alternative = "greater")
print(t_test_res)

cat("------------------------------------------------\n")
cat("Result Interpretation:\n")
cat("P-value:   ", t_test_res$p.value, "\n")
if(t_test_res$p.value < 0.05) {
  cat("Decision:   REJECT Null Hypothesis.\n")
  cat("Conclusion: Average users are significantly greater than 15.\n")
} else {
  cat("Decision:   FAIL TO REJECT Null Hypothesis.\n")
}
cat("[INFO] Plot saved as 'Distribution_Check.png'\n")