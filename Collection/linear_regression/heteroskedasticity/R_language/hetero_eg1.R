# https://stats.stackexchange.com/questions/258485/simulate-linear-regression-with-heteroscedasticity
library(zoo)
library(lmtest) # bptest

#===============================================================================
# To simulate data with a varying error variance, 
# you need to specify the data generating process for the error variance. 
# As has been pointed out in the comments, you did that when you generated your original data. 
# If you have real data and want to try this, you just need to identify the function that
# specifies how the residual variance depends on your covariates. 
# The standard way to do that is to fit your model,
# check that it is reasonable (other than the heteroscedasticity), and save the residuals. 
# Those residuals become the Y variable of a new model.
# Below I have done that for your data generating process. 
# (I don't see where you set the random seed, so these won't literally be the same data, 
# but should be similar, and you can reproduce mine exactly by using my seed.)


set.seed(568)  # this makes the example exactly reproducible

n      = rep(1:100,2)
a      = 0
b      = 1
sigma2 = n^1.3
eps    = rnorm(n,mean=0,sd=sqrt(sigma2))
y      = a+b*n + eps
mod    = lm(y ~ n)
res    = residuals(mod)


layout(matrix(1:2, nrow=2))
plot(n,y)
abline(coef(mod), col="red")
plot(mod, which=3)
#===============================================================================

# Note that R's ?plot.lm will give you a plot (cf., here) of the square root of the absolute values of the residuals, 
# helpfully overlaid with a lowess fit, which is just what you need. 
# (If you have multiple covariates, you might want to assess this against each covariate separately.) 
# There is the slightest hint of a curve, but this looks like a straight line does a good job of fitting the data. 
# So let's explicitly fit that model:

res.mod = lm(sqrt(abs(res))~fitted(mod))
summary(res.mod)

layout(matrix(1:4, nrow=2, ncol=2, byrow=TRUE))
plot(res.mod, which=1)
plot(res.mod, which=2)
plot(res.mod, which=3)
plot(res.mod, which=5)


#===============================================================================
# We needn't be concerned that the residual variance seems to be increasing in the scale-location
# plot for this model as well—that essentially has to happen. 
# There is again the slightest hint of a curve, 
# so we can try to fit a squared term and see if that helps (but it doesn't):
res.mod2 = lm(sqrt(abs(res))~poly(fitted(mod), 2))
summary(res.mod2)
# output omitted
anova(res.mod, res.mod2)

# If we're satisfied with this, we can now use this process as an add-on to simulate data.
set.seed(4396)  # this makes the example exactly reproducible
x = n
expected.y = coef(mod)[1] + coef(mod)[2]*x
sim.errors = rnorm(length(x), mean=0,
                   sd=(coef(res.mod)[1] + coef(res.mod)[2]*expected.y)^2)
observed.y = expected.y + sim.errors

#===============================================================================
# Note that this process is no more guaranteed to find the true data generating process than any 
# other statistical method. You used a non-linear function to generate the error SDs, 
# and we approximated it with a linear function. 
# If you actually know the true data generating process a-priori 
# (as in this case, because you simulated the original data), you might as well use it. 
# You can decide if the approximation here is good enough for your purposes. 
# We typically don't know the true data generating process, however, and based on Occam's razor, 
# go with the simplest function that adequately fits the data we have given the amount of 
# information available. You can also try splines or fancier approaches if you prefer. 
# The bivariate distributions look reasonably similar to me, 
# but we can see that while the estimated function largely parallels the true function, 
# they do not overlap:


  
  

