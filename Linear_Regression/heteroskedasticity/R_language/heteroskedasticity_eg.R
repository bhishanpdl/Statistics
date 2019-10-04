# http://marubon-ds.blogspot.com/2017/09/how-to-deal-with-heteroscedasticity.html
library(zoo)
library(lmtest) # bptest

# homo vs hetero
x <- seq(1, 100)
y_homogeneous <- x * 5 + 100 + rnorm(100, x, 5)
y_heteroscedastic <- x * 5 + 100 + rnorm(100, x, 2 * x) 
par(mfrow=c(1,2))
plot(x, y_homogeneous, col = 'blue')
plot(x, y_heteroscedastic, col = 'green')


#==========================================
# Generate heteroskedastic data
x <- seq(1, 100)
y_heteroscedastic <- x * 5 + 100 + rnorm(100, x, 2 * x) 

# plot
line1 <- lm(y_heteroscedastic~x)
summary(line1)
plot(x, y_heteroscedastic)
abline(line1, col='red')

bptest(line1) # p-value = 1.03e-05

# Log-transformation
log_x <- log(x)
log_y_heteroscedastic <- log(y_heteroscedastic)

log_line <- lm(log_y_heteroscedastic~log_x)
bptest(log_line) # p-value = 0.648
plot(log_x, log_y_heteroscedastic)
abline(log_line, col='red')

#========================================================
# https://rstudio-pubs-static.s3.amazonaws.com/187387_3ca34c107405427db0e0f01252b3fbdb.html
food = data.frame(food_exp = y_heteroscedastic, income=x)
head(food)



food.ols <- lm(food_exp ~ income, data = food)
food$resi <- food.ols$residuals
library(ggplot2)
ggplot(data = food, aes(y = resi, x = income)) + geom_point(col = 'blue') + geom_abline(slope = 0)

var.func <- lm(resi^2 ~ income, data = food)
summary(var.func)

qchisq(.95, df = 1)

bptest(food.ols) # p-value = 5.038e-05

# If the p-value is less than the level of significance 
# (in this case if the p-value is less than α=0.05), then you reject the null hypothesis. 
# Since 0.006579 < 0.05, we can reject the null hypothesis.

#-------------------------------------------------
# Resolving Heteroskedasticity
summary(food.ols)

library(lmtest)
library(sandwich)
coeftest(food.ols, vcov = vcovHC(food.ols, "HC1"))   # HC1 gives us the White standard errors

# ##before
# Estimate Std. Error t value Pr(>|t|)    
# (Intercept)  98.6129    23.7776   4.147 7.16e-05 ***
#   income        6.1215     0.4088  14.975  < 2e-16 ***

# ##after
#   Estimate Std. Error t value  Pr(>|t|)    
# (Intercept) 98.61287   14.75063  6.6853 1.421e-09 ***
#   income       6.12145    0.43958 13.9256 < 2.2e-16 ***
#** this has smaller std errors

# apply least squares to get our parameter estimates
food.ols <- lm(food_exp ~ income, data = food) # Fit our model to get our residuals.
food$resi <- food.ols$residuals
varfunc.ols <- lm(log(resi^2) ~ log(income), data = food)
summary(varfunc.ols)

food.ols <- lm(food_exp ~ income, data = food)
food$resi <- food.ols$residuals
varfunc.ols <- lm(log(resi^2) ~ log(income), data = food)
food$varfunc <- exp(varfunc.ols$fitted.values)
food.gls <- lm(food_exp ~ income, weights = 1/sqrt(varfunc), data = food)

summary(food.ols)

# Estimate Std. Error t value Pr(>|t|)    
# (Intercept)  72.7164    25.1769   2.888  0.00477 ** 
#   income        6.7818     0.4328  15.668  < 2e-16 ***

summary(food.gls)
# Estimate Std. Error t value Pr(>|t|)    
# (Intercept)  97.8960     9.0927   10.77   <2e-16 ***
#   income        6.1726     0.2757   22.39   <2e-16 ***

library(ggplot2)
g <- ggplot(data = food, aes(y = food_exp, x = income)) + geom_point(col = 'blue')
g + geom_abline(slope = food.ols$coefficients[2], intercept = food.ols$coefficients[1], col = 'red') + geom_abline(slope = food.gls$coefficients[2], intercept = food.gls$coefficients[1], col = 'green')
