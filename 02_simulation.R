# --- PART 2: SIMULATION & CONSISTENCY (PREMIUM) ---
library(ggplot2) # Required for high-quality plots

# 1. Define the Inverse Transform Function
#    Formula: X = ceiling( ln(1-U) / ln(1-p) )
sim_geometric_inverse <- function(p, n_sims) {
  U <- runif(n_sims) 
  # Note: 1-U and U have the same distribution, so we can use log(U) or log(1-U)
  return(ceiling(log(1 - U) / log(1 - p)))
}

# 2. Consistency Check (Law of Large Numbers)
#    We simulate increasing sample sizes to show error decreasing.
set.seed(123)
p_true <- 0.25 
sample_sizes <- seq(10, 5000, by = 10) # From n=10 to n=5000
estimates <- numeric(length(sample_sizes))

cat("================================================\n")
cat("   PART 2: CONSISTENCY SIMULATION RUNNING...    \n")
cat("================================================\n")

# 3. Run Simulation Loop
for (i in 1:length(sample_sizes)) {
  n <- sample_sizes[i]
  data <- sim_geometric_inverse(p_true, n)
  # Calculate MLE: 1 / sample_mean
  estimates[i] <- 1 / mean(data)
}

# 4. Visualization (ggplot2)
conv_data <- data.frame(SampleSize = sample_sizes, Estimate = estimates)

p1 <- ggplot(conv_data, aes(x = SampleSize, y = Estimate)) +
  # Add the simulation line
  geom_line(color = "steelblue", alpha = 0.8, size = 0.8) +
  # Add the True Parameter line
  geom_hline(yintercept = p_true, color = "red", linetype = "dashed", size = 1) +
  # Add labels and theme
  labs(title = "Consistency of MLE: Convergence to True Parameter",
       subtitle = paste("True p =", p_true, "| Estimator = 1 / SampleMean"),
       x = "Sample Size (n)",
       y = "Estimated Parameter (p)") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold", size = 14),
        axis.title = element_text(size = 12))

# Save the plot
ggsave("Convergence.png", p1, width = 8, height = 5, dpi = 300)

# 5. Terminal Output (Verification)
# Compare the first (small n) and last (large n) estimates
start_est <- estimates[1]
end_est <- estimates[length(estimates)]

cat("True Parameter p:      ", p_true, "\n")
cat("Estimate at n=10:      ", round(start_est, 4), " (High Error)\n")
cat("Estimate at n=5000:    ", round(end_est, 4),   " (Low Error)\n")
cat("------------------------------------------------\n")
cat("Error Reduction:       ", abs(start_est - p_true), "->", abs(end_est - p_true), "\n")
cat("Conclusion:            ", "Estimator converges to truth as n increases.\n")
cat("[INFO] Plot saved as 'Convergence.png'\n")