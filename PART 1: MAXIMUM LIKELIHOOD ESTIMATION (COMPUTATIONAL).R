# --- PART 1: MAXIMUM LIKELIHOOD ESTIMATION (PREMIUM) ---

# 1. Setup Image Export (High Resolution)
png("Rplot01.png", width = 800, height = 600, res = 100)

# 2. Define the Log-Likelihood function for Geometric Distribution
#    Math: l(p) = n*ln(p) + (sum(x)-n)*ln(1-p)
geom_loglik <- function(prob, x) {
  n <- length(x)
  # Safety check to avoid log(0)
  if (prob <= 0 || prob >= 1) return(-Inf)
  return(n * log(prob) + (sum(x) - n) * log(1 - prob))
}

# 3. Generate synthetic data for verification
set.seed(123)
n_samples <- 10
true_prob <- 0.5

# Note: rgeom counts failures. We add 1 to model 'trials until success'.
x <- rgeom(n_samples, true_prob) + 1 

# 4. Find the MLE using Computational Optimization
#    We ask R to find the peak of the curve automatically.
MLE_result <- optimize(f = geom_loglik, interval = c(0.001, 0.999), 
                       x = x, maximum = TRUE)
estimated_p <- MLE_result$maximum

# 5. Visualization
#    Calculate points for the curve
prob_values <- seq(0.01, 0.99, length = 1000)
loglik_values <- sapply(prob_values, geom_loglik, x = x)

#    Plot the curve
plot(prob_values, loglik_values, type = "l", lwd = 3, col = "darkblue",
     xlab = "Parameter p (Probability of Success)", 
     ylab = "Log-Likelihood Value",
     main = "Log-Likelihood Function for Geometric Distribution",
     cex.main = 1.2, cex.lab = 1.1)

#    Add grid and MLE line
grid()
abline(v = estimated_p, col = "red", lwd = 2, lty = 2)

#    Add Legend
legend("bottom", 
       legend = c("Log-Likelihood Curve", paste("Maximum (MLE) =", round(estimated_p, 4))),
       col = c("darkblue", "red"), lwd = c(3, 2), lty = c(1, 2), bg = "white")

# Close the image file
dev.off()

# 6. Terminal Output (Verification)
cat("================================================\n")
cat("   PART 1: ANALYTICAL vs COMPUTATIONAL CHECK    \n")
cat("================================================\n")
cat("True Parameter (p):        ", true_prob, "\n")
cat("Simulated Data (x):        ", paste(x, collapse=", "), "\n")
cat("Sample Mean (x_bar):       ", mean(x), "\n")
cat("------------------------------------------------\n")
cat("Analytical MLE (1/x_bar):  ", 1/mean(x), "\n")
cat("Computational MLE (R):     ", estimated_p, "\n")
cat("------------------------------------------------\n")
cat("Difference:                ", abs((1/mean(x)) - estimated_p), "\n")
cat("Conclusion:                ", "Analytical and Computational results match!\n")
cat("[INFO] Plot saved as 'Rplot01.png'\n")