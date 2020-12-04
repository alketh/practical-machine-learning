set.seed(3523)

library(AppliedPredictiveModeling)
library(caret)
library(e1071)

data(concrete)

inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]

training = concrete[ inTrain,]

testing = concrete[-inTrain, ]

# Set the seed to 325 and fit a support vector machine using the e1071 package
# to predict Compressive Strength using the default settings.

set.seed(325)

mod <- svm(CompressiveStrength~ ., data = training)

# Predict on the testing set. What is the RMSE?
pred <- predict(mod, testing)

sqrt(mean((testing$CompressiveStrength - pred)^2))

accuracy(pred, testing$CompressiveStrength)

# difference due to package versions
# my answer 7.962075
# correct answer 6.72
