# Heteroskedasticity
https://stats.stackexchange.com/questions/23887/linear-model-heteroscedasticity

What is your goal? We know that heteroskedasticity does not bias our coefficient estimates; it only makes our standard errors incorrect. Hence, if you only care about the fit of the model, then heteroskedasticity doesn't matter.

You can get a more efficient model (i.e., one with smaller standard errors) if you use weighted least squares. In this case, you need to estimate the variance for each observation and weight each observation by the inverse of that observation-specific variance (in the case of the weights argument to lm). This estimation procedure changes your estimates.

Alternatively, to correct the standard errors for heteroskedasticity without changing your estimates, you can use robust standard errors. For an R application, see the package sandwich.

Using the log transformation can be a good approach to correct for heteroskedasticity, but only if all your values are positive and the new model provides a reasonable interpretation relative to the question that you are asking.

# heteroske for one column of continuous data
https://stats.stackexchange.com/questions/147119/best-way-to-deal-with-heteroscedasticity


For your situation, weighted least squares (perhaps combined with robust regression if you suspect there may be some outliers) would be a reasonable choice. Using the Huber-White sandwich errors would also be good.

Here are some answers to your specific questions:

- Robust regression is a viable option, but would be better if paired with weights in my opinion. If you aren't worried that the heteroscedasticity is due to outliers, you could just use regular linear regression with weights. Be aware that the variance can be very sensitive to outliers, and your results can be sensitive to inappropriate weights, so what might be more important than using robust regression for the final model would be using a robust measure of dispersion to estimate the weights. In the linked thread, I use 1/IQR, for example.

- The standard errors are wrong because of the heteroscedasticity. You can adjust the standard errors with the Huber-White sandwich estimator. That is what @GavinSimpson is doing in the linked SO thread.
The heteroscedasticity does not make your linear model totally invalid. It primarily affects the standard errors. If you don't have outliers, least squares methods should remain unbiased. Therefore the predictive accuracy of point predictions should be unaffected. The coverage of interval predictions would be affected if you didn't model the variance as a function of 𝑋 and use that to adjust the width of your prediction intervals conditional on 𝑋.