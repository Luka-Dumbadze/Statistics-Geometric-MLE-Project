# 1. Load the data from the file
#    Make sure the file is in your current working directory!
data <- read.csv("ConcurrentUsers.csv")

# 2. Check if it loaded correctly
#    (We expect a column named 'N')
head(data)

# 3. Extract the column into a vector for easier analysis
concurrent_data <- data$N

# 4. Descriptive Statistics
cat("--- Descriptive Statistics ---\n")
summary(concurrent_data)
cat("Standard Deviation:", sd(concurrent_data, na.rm = TRUE), "\n")

# 5. Hypothesis Testing
#    Null Hypothesis (H0): Mean users = 15
#    Alt Hypothesis (H1): Mean users > 15
test_result <- t.test(concurrent_data, mu = 15, alternative = "greater")

# 6. Output results
print(test_result)

# 7. Boxplot (Save this plot for your report!)
boxplot(concurrent_data, main = "Boxplot of Concurrent Users", 
        ylab = "Number of Users", col = "orange")
abline(h = 15, col = "blue", lty = 2, lwd = 2)

# 8. Histogram (Optional bonus for report)
hist(concurrent_data, main = "Distribution of Concurrent Users",
     xlab = "Number of Users", col = "lightblue", border = "white")
abline(v = mean(concurrent_data, na.rm=TRUE), col="red", lwd=2)