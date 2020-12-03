library(lubridate) # For year() function below

dat = read.csv("~/Desktop/gaData.csv")

training = dat[year(dat$date) < 2012,]

testing = dat[(year(dat$date)) > 2011,]

tstrain = ts(training$visitsTumblr)

# Fit a model using the bats() function in the forecast package to the training time series.

# Then forecast this model for the remaining time points.

# For how many of the testing points is the true value within the 95% prediction interval bounds?
