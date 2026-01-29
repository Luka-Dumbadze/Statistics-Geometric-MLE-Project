# Statistical Inference: Geometric Distribution Analysis

## 📌 Overview
This project explores the **Geometric Distribution** through analytical derivation, computational simulation, and applied data analysis. It demonstrates the properties of Maximum Likelihood Estimators (MLE) and applies statistical inference to real-world server traffic data.

## 📂 Project Structure

### **1. Analytic Derivation**
*   **File:** \`01_mle_derivation.R\`
*   **Goal:** Derive and visualize the Log-Likelihood function.
*   **Outcome:** Proved analytically and computationally that the MLE for $p$ is the reciprocal of the sample mean ($1/\\bar{x}$).

### **2. Computational Verification**
*   **File:** \`02_simulation.R\`
*   **Goal:** Verify consistency using the **Inverse Transform Method**.
*   **Outcome:** Implemented a custom simulation algorithm (without using \`rgeom\`) and demonstrated the convergence of the estimator as $n \\to \\infty$ (Law of Large Numbers).

### **3. Data Analysis**
*   **File:** \`03_data_analysis.R\`
*   **Data:** \`ConcurrentUsers.csv\`
*   **Goal:** Perform statistical inference on server user counts.
*   **Outcome:** Verified normality assumptions (Shapiro-Wilk) and performed a one-sample t-test ($p < 0.001$), confirming average traffic exceeds the baseline.

## 🛠️ Tools Used
*   **R (v4.3.3):** Core statistical computing.
*   **ggplot2:** Advanced data visualization.
*   **Typst:** Scientific typesetting for the final report.

## 📄 Final Report
The complete analysis and mathematical proofs can be found in [final_report.pdf](./final_report.pdf).

---
*Author: Luka Dumbadze*
EOF