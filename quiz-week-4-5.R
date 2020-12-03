set.seed(3523)

library(AppliedPredictiveModeling)

data(concrete)

inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]

training = concrete[ inTrain,]

testin

# Set the seed to 325 and fit a support vector machine using the e1071 package
# to predict Compressive Strength using the default settings.

# Predict on the testing set. What is the RMSE?
