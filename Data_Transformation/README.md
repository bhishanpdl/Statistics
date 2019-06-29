# Tranform data with negative values
Ref: https://stats.stackexchange.com/questions/94628/how-to-transform-negative-data-to-be-homoscedastic

On a mechanistic level, cube roots act symmetrically on a variable that is positive, zero and negative and
may pull in the tails of a distribution that is approximately symmetric but heavier-tailed than Gaussian or normal. 
I have sometimes found this useful for raw data.
```
# symmetric transformations:
sign(x) * log(abs(x) + 1)
asinh(x)
sign(x) * abs(x)^(1/3)
```

**method2** 
```
x_transformed = log(x + C)
C = 1 - min(x)

advantage: can use log transform and box-cox transform.

disadvantage: This is unlikely to normalise a variable that is residual-like and
both positive and negative as it doesn't act symmetrically. 
```
