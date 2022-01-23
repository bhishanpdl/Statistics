# Q-Q plot
Quantile-Quantile plots are useful for checking the normality of the given data. For example, we need to check normality of a feature in linear regression modelling and we can use q-q plot to see if the residual errors are normally distributed.

```python
import numpy as np
from scipy import stats
import statsmodels.api as sm
import matplotlib.pyplot as plt

x = stats.norm.rvs(size=1000)
sm.qqplot(x,line='45')
plt.show()

# using other distribution
x = stats.norm.rvs(size=1000)
sm.qqplot(x,line='45',dist=stats.gamma,fit=True)
plt.show()

# example 2
data = sm.datasets.longley.load(as_pandas=False)
data.exog = sm.add_constant(data.exog)
mod_fit = sm.OLS(data.endog, data.exog).fit()
res = mod_fit.resid # residuals
fig = sm.qqplot(res)
plt.show()

# example 3
df = sm.datasets.longley.load_pandas().data
y = df.iloc[:,0]
X = df.iloc[:,1:]
X1 = X.assign(const=1)

mod_fit = sm.OLS(y,X1).fit()

resids = mod_fit.resid
fig,ax = plt.subplots(figsize=(8,8))
sm.qqplot(resids,ax=ax,line=None)
plt.show()
```