Table of Contents
=================
   * [Important Links](#important-links)
   * [Statistics Books](#statistics-books)
   * [Fitting lognormal distribution](#fitting-lognormal-distribution)
   * [T-test and KS(Kolmogorov-Smirnov) test for one sample](#t-test-and-kskolmogorov-smirnov-test-for-one-sample)
   * [p-values](#p-values)
   * [Hypothesis Testing](#hypothesis-testing)
      * [One tailed z-test](#one-tailed-z-test)
      * [Two-tailed z-test](#two-tailed-z-test)

# Important Links
- [Excellent: Duke University Compuational Statistics in Python](https://people.duke.edu/~ccc14/sta-663/ComputationalStatisticsMotivation.html)
- [blog: various probability distributions rshiny app online](https://ben18785.shinyapps.io/distribution-zoo/)
- [youtube: Fourier wave transformation](https://www.youtube.com/watch?v=r18Gi8lSkfM)
- [datasciencecentral: 29 statistical concepts](https://www.datasciencecentral.com/profiles/blogs/29-statistical-concepts-explained-in-simple-english-part-16)
- [(Very good) machinelearningmastery: 17 Statistical Hypothesis Tests in Python](https://machinelearningmastery.com/statistical-hypothesis-tests-in-python-cheat-sheet/)
- [TWS: Hypothesis testing in Machine learning using Python ](https://towardsdatascience.com/hypothesis-testing-in-machine-learning-using-python-a0dc89e169ce)

# Statistics Books
- [ESL The Elements of Statistical Learning by  Friedman, Hastie, and Tibshirani](https://web.stanford.edu/~hastie/ElemStatLearn/)
- [ISL An Introduction to Statistical Learning: With Applications in R by  Friedman, Hastie, and Tibshirani](http://www-bcf.usc.edu/~gareth/ISL/)
- [Why Dividing By N Underestimates the Variance youtube](https://www.youtube.com/watch?v=sHRBg6BhKjI)

# scipy stats distributions

```python
"""
A random variable X is normal with mean 1020 and a standard deviation 50. Calculate P(X>1200)

"""
from scipy import stats

# for norm, loc=mean and scale=std
p =  1 - stats.norm.cdf(x=1200,loc=1020,scale=50)
# excel: p =1-norm.dist(x=1200, mean=1020, std=50, cumulative=true)
```

# Fitting lognormal distribution
```python
import numpy as np
import scipy.stats as stats
import matplotlib.pyplot as plt


sample = stats.lognorm.rvs(loc=0, s=1, size=1000, random_state=0)

# plot sample
x_axis = np.linspace(0,10,1000)

plt.figure(figsize=(12,8))
plt.plot(x_axis, sample,'b.',label='Orignal data')
#plt.hist(sample);


# fit lognormal
params = stats.lognorm.fit(sample, floc=0)
y_axis = stats.lognorm.pdf(x_axis, *params)

# plot
plt.title('Fitted Lognormal')
plt.plot(x_axis, y_axis,label='Fitted Lognormal')
plt.legend()
plt.show()
```

# T-test and KS(Kolmogorov-Smirnov) test for one sample
https://docs.scipy.org/doc/scipy/reference/tutorial/stats.html
(Scroll down pages to T-test and KS test)


# p-values
```python
from functools import partial
import scipy.stats as stats

def compare(x, y, func):
    """Returne p-value for some appropriate comparison test."""
    return func(x, y)[1]

x, y = np.random.normal(0, 1, (100,2)).T

print ("p value assuming equal variance    =%.8f" % compare(x, y, stats.ttest_ind))

test = partial(stats.ttest_ind, equal_var=False)
print ("p value not assuming equal variance=%.8f" % compare(x, y, test))
```

# Hypothesis Testing
https://www.statisticshowto.datasciencecentral.com/probability-and-statistics/hypothesis-testing/

NOTE:    
  1. There is some established theory. Think H0, alpha, and statistic of alpha (one or two tailed) (z-score, t-score etc)
  2. Researcher wants to test his new idea. Think H1, test-statistic.
  3. If researchers test-statistic > established statistic, Then researcher is happy, his assumption is statistically significant.

## One tailed z-test
A principal at a certain school claims that the students in his school are above average intelligence. A random sample of thirty students IQ scores have a mean score of 112. Is there sufficient evidence to support the principal’s claim? The mean population IQ is 100 with a standard deviation of 15.

Step 1: State the Null hypothesis. The accepted fact is that the population mean is 100, so: H0: μ=100.

Step 2: State the Alternate Hypothesis. The claim is that the students have above average IQ scores, so:
H1: μ > 100.
The fact that we are looking for scores “greater than” a certain point means that this is a one-tailed test.

Step 3: Draw a picture to help you visualize the problem.

![](images/hypothesis-testing-example.jpg)

Step 4: State the alpha level. If you aren’t given an alpha level, use 5% (0.05).

Step 5: Find the rejection region area (given by your alpha level above) from the z-table. An area of .05 is equal to a z-score of 1.645.

Step 6: Find the test statistic using this formula: z score formula
For this set of data: z= (112.5-100) / (15/√30)=4.56.

Step 6: If Step 6 is greater than Step 5, reject the null hypothesis. If it’s less than Step 5, you cannot reject the null hypothesis. In this case, it is greater (4.56 > 1.645), so you can reject the null. Rejecting null means we can say alternative is true. This means principle's claim is statistically supported with 5 % level of confidence.

## Two-tailed z-test
Blood glucose levels for obese patients have a mean of 100 with a standard deviation of 15. A researcher thinks that a diet high in raw cornstarch will have a positive or negative effect on blood glucose levels. A sample of 30 patients who have tried the raw cornstarch diet have a mean glucose level of 140. Test the hypothesis that the raw cornstarch had an ef

Step 1: State the null hypothesis: H0:μ=100

Step 2: State the alternate hypothesis: H1:≠100

Step 3: State your alpha level. We’ll use 0.05 for this example. As this is a two-tailed test, split the alpha into two.
0.05/2=0.025

Step 4: Find the z-score associated with your alpha level. You’re looking for the area in one tail only. A z-score for 0.75(1-0.025=0.975) is 1.96. As this is a two-tailed test, you would also be considering the left tail (z=1.96)

Step 5: Find the test statistic using this formula: z score formula
z=(140-100)/(15/√30)=14.60.

Step 6: If Step 5 is less than -1.96 or greater than 1.96 (Step 3), reject the null hypothesis. In this case, it is greater, so you can reject the null. Rejecting null hypothesis means accepting alternative hypothesis. This means the raw starch has some effects on patients.

# 1-sampled t-test
```python
from scipy import stats

x = sample drawn from population
mu = you say population mean is 30
t_statistic, pval = stats.ttest_1samp(x,mu)

if pval < 0.05: reject null hypothesis
```

# 2-sampled t-test
```python
tstat,pval = stats.ttest_ind(x1,x2)
```

# paired sampled t-test

```python
# eg. glucose level before and after
tstat,pval = stats.ttest_rel(x_before,x_after)
```

# 1-sampled z-test
- sample size more than 30
- data ponts should be iid
- data should be normally distributed
- sample size should be similar
```python
from statsmodels.stats import weightstats as stests

x = blood pressure before
mu = mean blood pressure, eg. 156

zstat,pval = stests.ztest(x,x2=None,value=mu)
```

# 2-sampled z-test
```python
zstat,pval = stests.ztest(x1,x2,value=0,alternative='two-sided')
```

# ANOVA F-test
```python
x1 = control group
x2 = treatement 1 group
x3 = treatment 2 group
fstat,pval = stats.f_oneway(x1,x2,x3)

# another example
import statsmodels.api as sm
from statsmodels.formula.api import ols
df_anova2 = pd.read_csv("https://raw.githubusercontent.com/Opensourcefordatascience/Data-sets/master/crop_yield.csv")
model = ols('Yield ~ C(Fert)*C(Water)', df_anova2).fit()
print(f"Overall model F({model.df_model: .0f},{model.df_resid: .0f}) = {model.fvalue: .3f}, p = {model.f_pvalue: .4f}")
res = sm.stats.anova_lm(model, typ= 2)
```

# Normality Test: Shapiro-Wilk
- https://machinelearningmastery.com/statistical-hypothesis-tests-in-python-cheat-sheet/
```python
# H0: sample has Gaussian distribution for all 3 tests
# Shapiro-Wilk Test
swstat,pval = stats.shapiro(x)

# D'Agostino's K^2 Normality Test
stat,pval = stats.normaltest(x)

# Anderson-Darling Test
adstat,pval = stats.anderson(x)
```
# Correlation Tests
- https://machinelearningmastery.com/statistical-hypothesis-tests-in-python-cheat-sheet/

```python
# H0: the two samples are independent.
stat,p = stats.pearsonr(x1,x2)

# if observation can be ranked we use Spearman rank corr
stat,p = stats.spearmanr(x1,x2)

# Kendall’s Rank Correlation
# This Tests whether two samples have a monotonic relationship.

stat,p = stats.kendalltau(x1,x2)
```

# chi-squared test
```python
# Example of the Chi-Squared Test
from scipy.stats import chi2_contingency
table = [[10, 20, 30],[6,  9,  17]]
stat, p, dof, expected = chi2_contingency(table)
print('stat=%.3f, p=%.3f' % (stat, p))
if p > 0.05:
	print('Probably independent')
else:
	print('Probably dependent')
```

# Stationary Check

```python

#Augmented Dickey-Fuller Unit Root Test
#H0: a unit root is present (series is non-stationary).
# Example of the Augmented Dickey-Fuller unit root test
from statsmodels.tsa.stattools import adfuller
data = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
stat, p, lags, obs, crit, t = adfuller(data)
print('stat=%.3f, p=%.3f' % (stat, p))
if p > 0.05:
	print('Probably not Stationary')
else:
	print('Probably Stationary')
```

```python
#Kwiatkowski-Phillips-Schmidt-Shin
#H0: the time series is not trend-stationary.

# Example of the Kwiatkowski-Phillips-Schmidt-Shin test
from statsmodels.tsa.stattools import kpss
data = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
stat, p, lags, crit = kpss(data)
print('stat=%.3f, p=%.3f' % (stat, p))
if p > 0.05:
	print('Probably not Stationary')
else:
	print('Probably Stationary')
```

# Nonparametric Statistical Hypothesis Tests
- https://machinelearningmastery.com/statistical-hypothesis-tests-in-python-cheat-sheet/
Parametric Statistical test
- Student’s t-test
- Paired Student’s t-test
- Analysis of Variance Test (ANOVA)
- Repeated Measures ANOVA Test

Non parametric statistical tests
- Mann-Whitney U Test
- Wilcoxon Signed-Rank Test
- Kruskal-Wallis H Test
- Friedman Test