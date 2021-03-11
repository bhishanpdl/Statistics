import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

#Create a pandas DataFrame for the djia data set.
df = pd.read_csv('djia.csv', header=0, infer_datetime_format=True, parse_dates=[0], index_col=[0])

################################
######## THE MEAN MODEL ########
################################

mean = round(df['Closing Price'].mean(),2)
y_pred = np.full(len(df['Closing Price']), mean)

fig = plt.figure()
fig.suptitle('DJIA Closing Price')
actual, = plt.plot(df.index, df['Closing Price'], 'go-', label='Actual Closing Price')
predicted, = plt.plot(df.index, y_pred, 'ro-', label='Predicted Closing Price')
plt.xlabel('Date')
plt.ylabel('Closing Price (USD)')
plt.legend(handles=[predicted, actual])
plt.show()

###########################################
######## THE LAGGED VARIABLE MODEL ########
###########################################

import pandas as pd
import numpy as np
import statsmodels.api as sm

#Read the data set into a Pandas Data Frame
df = pd.read_csv('djia.csv', header=0, infer_datetime_format=True, parse_dates=[0], index_col=[0])

#Add the lagged column
df['CP_LAGGED'] = df['Closing Price'].shift(1)

#Let's remove the first row as it contains an NaN:
df_lagged = df.drop(df.index[0])

split_index = round(len(df_lagged)*0.8)
split_date = df_lagged.index[split_index]
df_train = df_lagged.loc[df_lagged.index <= split_date].copy()
df_test = df_lagged.loc[df_lagged.index > split_date].copy()
X_train = df_train['CP_LAGGED'].values
#Add a placeholder for the constant so that model computes an intercept value i.e. the regression equation will take the form: y = Beta_0 + Beta_1*x
X_train = sm.add_constant(X_train)
y_train = df_train['Closing Price'].values
X_test = df_test['CP_LAGGED'].values
#Add a placeholder for the constant so that model computes an intercept value
X_test = sm.add_constant(X_test)
y_test = df_test['Closing Price'].values


#Construct and fit the OLS regression model:
ols_model = sm.OLS(y_train,X_train)
ols_results = ols_model.fit()

#Use the fitted model to make predictions on the training and testing data sets:
y_pred_train = ols_results.predict(X_train)
y_pred_test = ols_results.predict(X_test)

#Use the fitted model to make predictions on the training and testing data sets:
y_pred_train = ols_results.predict(X_train)
y_pred_test = ols_results.predict(X_test)

#Plot the model's performance against the test data set:
fig = plt.figure()
fig.suptitle('DJIA Closing Price')
actual, = plt.plot(df_test.index, y_test, 'go-', label='Actual Closing Price')
predicted, = plt.plot(df_test.index, y_pred_test, 'ro-', label='Predicted Closing Price')
plt.xlabel('Date')
plt.ylabel('Closing Price (USD)')
plt.legend(handles=[predicted, actual])
plt.show()

#print the summary of regression results
print(ols_results.summary())
