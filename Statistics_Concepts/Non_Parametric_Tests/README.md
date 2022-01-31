# Non-parametric Tests
## Mann Whitney U test
- [machinelearningmastery: A Gentle Introduction to Normality Tests in Python](https://machinelearningmastery.com/a-gentle-introduction-to-normality-tests-in-python/)

```
If Data Is Gaussian:
	Use Parametric Statistical Methods
Else:
	Use Nonparametric Statistical Methods
```

An important decision point when working with a sample of data is whether to use parametric or nonparametric statistical methods.

Parametric statistical methods assume that the data has a known and specific distribution, often a Gaussian distribution. If a data sample is not Gaussian, then the assumptions of parametric statistical tests are violated and nonparametric statistical methods must be used.

Four nonparametric statistical significance tests that you can use are:

1. Mann-Whitney U Test.
1. Wilcoxon Signed-Rank Test.
1. Kruskal-Wallis H Test.
1. Friedman Test.

[mannwhitneyu](https://docs.scipy.org/doc/scipy/reference/generated/scipy.stats.mannwhitneyu.html#scipy.stats.mannwhitneyu) is for independent samples. For related or paired samples, consider [scipy.stats.wilcoxon](https://docs.scipy.org/doc/scipy/reference/generated/scipy.stats.wilcoxon.html#scipy.stats.wilcoxon).

> H0: null hypothesis is that there is no difference between the distributions of the data samples.

> H1: Two samples are different

For the test to be effective, it requires at least 20 observations in each data sample.

```python
males = [19, 22, 16, 29, 24]
females = [20, 11, 17, 12]

from scipy.stats import mannwhitneyu

U1, p = mannwhitneyu(males, females, method="exact")
print(U1) # 17.0

alpha = 0.05

if p <= alpha:
    print('Reject H0: different samples')
else:
    print('Fail to reject H0)')
    print("Same Distribution")
```

mannwhitneyu always reports the statistic associated with the first sample, which, in this case, is males. This agrees with 
 reported in [4]. The statistic associated with the second statistic can be calculated:

 ```python
nx, ny = len(males), len(females)
U2 = nx*ny - U1
print(U2) # 3.0
 ```

 Another Example:
 ```python
# Mann-Whitney U test
from numpy.random import seed
from numpy.random import randn
from scipy.stats import mannwhitneyu
# seed the random number generator
seed(1)
# generate two independent samples
data1 = 5 * randn(100) + 50
data2 = 5 * randn(100) + 51
# compare samples
stat, p = mannwhitneyu(data1, data2)
print('Statistics=%.3f, p=%.3f' % (stat, p))
# interpret
alpha = 0.05

if p <= alpha:
    print('Different distribution (reject H0)')
else:
    print('Same distribution (fail to reject H0)')

# The p-value strongly suggests that the sample distributions are different, as is expected.
# Statistics=4025.000, p=0.009
# Different distribution (reject H0)
 ```