library(AppliedPredictiveModeling)
library(elasticnet)

set.seed(3523)

data(concrete)

inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]

training = concrete[ inTrain,]

testing = concrete[-inTrain,]

# Set the seed to 233 and

set.seed(233)

# fit a lasso model to predict Compressive Strength.
modFit <- train(CompressiveStrength ~ ., method = "lasso", data = training)

# Which variable is the last coefficient to be set to zero as the penalty increases?
# (Hint: it may be useful to look up ?plot.enet).
plot.enet(modFit$finalModel, xvar = "penalty", use.color = TRUE)
