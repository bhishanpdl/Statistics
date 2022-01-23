# Module: open-turns

- https://openturns.github.io/www/
- https://stackoverflow.com/questions/6620471/fitting-empirical-distribution-to-theoretical-ones-with-scipy-python/59147630#59147630
- https://stackoverflow.com/questions/55897917/fitting-gamma-distribution-in-python

Get the distribution

```python
import statsmodels.api as sm
dta = sm.datasets.elnino.load_pandas().data
dta['YEAR'] = dta.YEAR.astype(int).astype(str)
dta = dta.set_index('YEAR').T.unstack()
data = dta.values

sample = ot.Sample([[p] for p in data]) # data reshaping
tested_factories = ot.DistributionFactory.GetContinuousUniVariateFactories()
best_model, best_bic = ot.FittingTest.BestModelBIC(sample,
                                                   tested_factories)
print("Best=",best_model)

# Best= Beta(alpha = 1.64258, beta = 2.4348, a = 18.936, b = 29.254)

import openturns.viewer as otv
graph = ot.HistogramFactory().build(sample).drawPDF()
bestPDF = best_model.drawPDF()
bestPDF.setColors(["blue"])
graph.add(bestPDF)
graph.setTitle("Best BIC fit")
name = best_model.getImplementation().getClassName()
graph.setLegends(["Histogram",name])
graph.setXTitle("Temperature (°C)")
otv.View(graph)

```

# Fitting gamma distributions:

```python
import openturns as ot

sample = ot.Sample([[x] for x in data])
gamma_fitting = ot.GammaFactory().build(sample)
print (gamma_fitting)
>>> Gamma(k = 1.49938, lambda = 79.5426, gamma = 0.02325)
```