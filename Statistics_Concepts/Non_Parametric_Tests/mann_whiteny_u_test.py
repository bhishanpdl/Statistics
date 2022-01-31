from numpy.random import seed
from numpy.random import randn
from scipy.stats import mannwhitneyu

# Mann-Whitney U test and Wilcoxon rank-sum test are both nonparametric tests.

# For Gaussian data, the Mann-Whitney U test is equivalent to the t-test of the mean.


# The U statistic is approximately a t statistic with large degrees of freedom.

# for two independent samples we use the Mann-Whitney U test
# for two dependent samples we use the Wilcoxon rank-sum test

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
    print('Reject H0')
    print('Different distribution')
else:
    print('Fail to reject H0')
    print('Same distribution')