# Krish Naik Youtube interviews
- [Live Virtual Interview Of Experienced For Data Scientist](https://www.youtube.com/watch?v=fUH4H-lVMQU)
1. What is pdf and cdf?
pdf is the distribution of a given variable. Cdf is the summation of the distribution of a variable.

A point in pdf corresponds to the prob variable on x-axis.
A point in cdf corresponds to the total probabilities up to that point in x-axis.
```
Pr (a<= x<=b) = int_a_b  f(x)dx

if F(x) is cdf of f(x) then,

F(x) = int_-inf_x f(u) du
CDF is always monotonically increasing function.

for standard normal distribution,
prob density fun pdf f(x) = int_-inf_+inf x f(x)dx

for normal dist,
f(x) = 1/sigma sqrt(2pi)  exp(-(x-mu)sq / 2sigma_sq )
area under pdf is summed to 1 but not cdf.
```
1. can u calculate percentile from cdf?

```
area under cdf is not summed to 1. but still  calculating a percentile (or a p-quantile) is equivalent to finding the inverse of a CDF.


```