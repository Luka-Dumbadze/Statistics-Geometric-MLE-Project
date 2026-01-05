# 1. Define the Log-Likelihood function for Geometric Distribution
#    (We use log-likelihood because it is numerically more stable)
geom_loglik <- function(prob, x) {
  n <- length(x)
  # Log-likelihood formula: n*ln(p) + (sum(x)-n)*ln(1-p)
  # Note: In our definition, x is trials until success (1, 2, 3...)
  return(n * log(prob) + (sum(x) - n) * log(1 - prob))
}

# 2. Generate synthetic data to test the estimator
set.seed(123)
n <- 10
true_prob <- 0.5
# Generate data (adding 1 because R's rgeom counts failures, we want trials)
x <- rgeom(n, true_prob) + 1 

# 3. Find the Maximum Likelihood Estimator (MLE) using optimize()
MLE_result <- optimize(f = geom_loglik, interval = c(0.001, 0.999), x = x, maximum = TRUE)

# 4. Output the results
cat("True Probability:", true_prob, "\n")
cat("Estimated Probability (MLE):", MLE_result$maximum, "\n")

# 5. Plot the Log-Likelihood Curve (Save this plot for your report!)
prob_values <- seq(0.01, 0.99, length = 1000)
loglik_values <- sapply(prob_values, geom_loglik, x = x)

plot(prob_values, loglik_values, type = "l", lwd = 2, col = "blue",
     xlab = "Parameter p (Probability of Success)", 
     ylab = "Log-Likelihood",
     main = "Log-Likelihood Function for Geometric Distribution")
abline(v = MLE_result$maximum, col = "red", lwd = 2, lty = 2)
legend("bottom", legend = c("Log-Likelihood", "Maximum (MLE)"),
       col = c("blue", "red"), lwd = 2, lty = c(1, 2))