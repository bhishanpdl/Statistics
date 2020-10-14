## simulate some non-stationary data  ---- 
 
set.seed(100) 
 
df <- data.frame(x = cumsum(rnorm(100)), 
                 y = cumsum(rnorm(100))) 
 
## split between training and test ---- 
 
train_df <- df[1:80,] 
test_df <- df[81:100,] 
 
### fit OLS ---- 
 
lm.bias <- lm(y ~ x, data=train_df) 
 
summary(lm.bias)$r.squared ## R^2 = 31.49% (in-sample) 
 
### create a R^2 function --- 
 
r2 <- function(data, model, response){ 
  preds <- predict(model, newdata=data) 
  mean_response <- mean(data[,response]) 
  actuals <- data[,response] 
   
  null_mse <- mean( (mean_response - actuals)^2 )  # NULL MODEL b/c mean_response is constant 
  model_mse <- mean( ( preds - actuals)^2 )  
   
  r_squared <- (null_mse - model_mse) / null_mse 
   
  return(r_squared) 
} 
 
r2(train_df, lm.bias, "y")  ### the same as summary(); R^2 = 31.49% (in-sample) 
 
### calculate out-of-sample R^2 ---- 
 
r2(test_df, lm.bias, "y")  ## **NEGATIVE** 103% R^2 (out-sample) 