library(lubridate) # For year() function below
library(forecast)

dat = read.csv("C:/~/practical-machine-learning/data/gaData.csv")

training = dat[year(dat$date) < 2012,]

testing = dat[(year(dat$date)) > 2011,]

tstrain = ts(training$visitsTumblr)

# Fit a model using the bats() function in the forecast package to the training time series.
mod <- bats(tstrain)

# Then forecast this model for the remaining time
tstest <- ts(testing$visitsTumblr)

pred <- forecast(mod, h = length(tstest))

# For how many of the testing points is the true value within the 95% prediction interval bounds?
pred$upper[, 2]
pred$lower[, 2]

str(tstest)

mean(as.numeric(tstest) >= pred$lower[, 2] & as.numeric(tstest) <= pred$upper[, 2])

# 0.9617021
