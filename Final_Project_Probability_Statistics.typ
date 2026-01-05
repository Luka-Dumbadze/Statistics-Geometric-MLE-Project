#set document(title: "Statistical Inference and Analysis", author: "Your Name")
#set page(margin: 1in)
#set text(font: "New Computer Modern", size: 11pt)
#set par(justify: true)

// Title and metadata
#align(center)[
  #text(size: 16pt, weight: "bold")[
    Statistical Inference and Analysis: Geometric Distribution and Concurrent Users
  ]
  
  #v(0.5em)
  
  #text(size: 12pt)[
    *Student Name:* [Your Name] \
    *Date:* January 5, 2026
  ]
]

#v(1em)
#line(length: 100%)
#v(1em)

= 1. Analytical Derivation: Maximum Likelihood Estimator

*Objective:* To derive the Maximum Likelihood Estimator (MLE) for the parameter $p$ of a Geometric distribution.

The probability mass function for a Geometric random variable $X$ (representing the number of trials up to and including the first success) is given by:

$ P(X=x) = (1-p)^(x-1)p $

Assuming $n$ independent and identically distributed observations $x_1, x_2, dots, x_n$, the likelihood function is:

$ L(p) = product_(i=1)^n (1-p)^(x_i-1)p = p^n (1-p)^(sum x_i - n) $

Taking the natural logarithm yields the log-likelihood function:

$ ell(p) = n ln(p) + (sum_(i=1)^n x_i - n) ln(1-p) $

Differentiating with respect to $p$ and setting to zero:

$ (d ell)/(d p) = n/p - (sum x_i - n)/(1-p) = 0 $

Solving for $p$ yields the estimator $hat(p) = n/(sum x_i) = 1/overline(x)$. Thus, the MLE is the reciprocal of the sample mean.

#pagebreak()

= 2. Computational Verification

*Objective:* To verify the analytical result using R simulations and visualize the log-likelihood function.

== 2.1 Log-Likelihood Visualization

We simulated a geometric dataset with $p=0.5$. The log-likelihood function was plotted against a range of possible $p$ values. The maximum of the curve corresponds to the MLE, confirming our derivation.

#figure(
  image("Rplot.png", width: 80%),
  caption: [Log-likelihood function showing maximum at MLE]
)

== 2.2 Inverse Transform Simulation

We implemented the Inverse Transform Method to simulate 1,000 geometric random variables. The algorithm used was:

$ X = "ceiling"((ln(1 - U))/(ln(1 - p))) $

The simulation results (mean = 2.447) closely matched the theoretical expectation (mean = 2.5), validating the algorithm.

#figure(
  image("Rplot02.png", width: 80%),
  caption: [Histogram of simulated geometric random variables]
)

#pagebreak()

= 3. Data Analysis

*Objective:* To analyze the `ConcurrentUsers` dataset and test if the mean number of users exceeds 15.

== 3.1 Descriptive Statistics

- *Mean:* 17.95
- *Median:* 17.55
- *Standard Deviation:* 3.16

#figure(
  image("Rplot03.png", width: 80%),
  caption: [Boxplot of concurrent users data]
)

== 3.2 Statistical Inference

We performed a one-sample t-test ($H_0: mu = 15$ vs $H_1: mu > 15$).

- *Test Statistic:* $t = 6.6159$
- *P-value:* $1.306 times 10^(-8)$

*Conclusion:* Since $p < 0.05$, we reject the null hypothesis. There is strong evidence that the average number of concurrent users is significantly greater than 15.

#pagebreak()

= Appendix: R Code

== Part 1 Code

#raw(read("PART 1: MAXIMUM LIKELIHOOD ESTIMATION (COMPUTATIONAL).R"), lang: "r", block: true)

== Part 2 Code

#raw(read("PART 2: SIMULATION (INVERSE TRANSFORM METHOD).R"), lang: "r", block: true)

== Part 3 Code

#raw(read("PART 3: DATA ANALYSIS.R"), lang: "r", block: true)