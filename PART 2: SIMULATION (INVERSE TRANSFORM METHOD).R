# 1. Define the Simulation Function
#    Formula: X = ceiling( ln(1-U) / ln(1-p) )
sim_geometric_inverse <- function(p, n_sims) {
  U <- runif(n_sims) # Generate Uniform(0,1) numbers
  X <- ceiling(log(1 - U) / log(1 - p))
  return(X)
}

# 2. Run the simulation
p_target <- 0.4
N_sims <- 1000
simulated_data <- sim_geometric_inverse(p = p_target, n_sims = N_sims)

# 3. Verify results
theoretical_mean <- 1 / p_target
simulated_mean <- mean(simulated_data)

cat("--- Simulation Results ---\n")
cat("Target p:", p_target, "\n")
cat("Theoretical Mean (1/p):", theoretical_mean, "\n")
cat("Simulated Mean:", simulated_mean, "\n")

# 4. Create Histogram (Save this plot for your report!)
hist(simulated_data, breaks = 20, col = "lightblue", 
     main = "Histogram of Simulated Geometric Data",
     xlab = "Number of Trials to Success")
abline(v = theoretical_mean, col = "red", lwd = 3)
legend("topright", legend = "Theoretical Mean", col = "red", lwd = 3)