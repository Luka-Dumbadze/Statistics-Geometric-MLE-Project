# --- PART 3: ADVANCED DATA ANALYSIS (FINAL) ---
library(ggplot2)

# 1. Load Data
concurrent_data <- c(17.2, 22.1, 18.5, 17.2, 18.6, 14.8, 21.7, 15.8, 16.3, 22.8, 
                     24.1, 13.3, 16.2, 17.5, 19.0, 23.9, 14.8, 22.2, 21.7, 20.7, 
                     13.5, 15.8, 13.1, 16.1, 21.9, 23.9, 19.3, 12.0, 19.9, 19.4, 
                     15.4, 16.7, 19.5, 16.2, 16.9, 17.1, 20.2, 13.4, 19.8, 17.7, 
                     19.7, 18.7, 17.6, 15.9, 15.2, 17.1, 15.0, 18.8, 21.6, 11.9)
df <- data.frame(Users = concurrent_data)

# 2. Normality Checking (Shapiro + Q-Q Plot)
shapiro_res <- shapiro.test(concurrent_data)
print(shapiro_res)

# Q-Q Plot (The new addition)
p_qq <- ggplot(df, aes(sample = Users)) +
  stat_qq(color = "#69b3a2", size = 2) +
  stat_qq_line(color = "red", linetype = "dashed", size = 1) +
  labs(title = "Q-Q Plot: Normality Check",
       subtitle = "Points hug the red line = Normal Data",
       x = "Theoretical Quantiles", y = "Sample Quantiles") +
  theme_minimal()

ggsave("QQ_Plot.png", p_qq, width = 6, height = 5)

# 3. Density Plot (Existing)
mean_val <- mean(concurrent_data)
p2 <- ggplot(df, aes(x = Users)) +
  geom_histogram(aes(y = ..density..), bins = 8, 
                 fill = "#69b3a2", color = "white", alpha = 0.7) +
  geom_density(color = "#FF6666", size = 1.2) +
  geom_vline(aes(xintercept = mean_val), color = "blue", linetype = "dashed") +
  labs(title = "Distribution of Concurrent Users",
       subtitle = paste("Shapiro-Wilk p =", round(shapiro_res$p.value, 3)),
       x = "Number of Users", y = "Density") +
  theme_minimal()
ggsave("Distribution_Check.png", p2, width = 7, height = 5)

# 4. Inference
t_test_res <- t.test(concurrent_data, mu = 15, alternative = "greater")
print(t_test_res)