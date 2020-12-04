library(caret)
library(gbm)
library(AppliedPredictiveModeling)
library(ggplot2)

set.seed(3433)

data(AlzheimerDisease)

adData = data.frame(diagnosis,predictors)

inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]

training = adData[ inTrain,]

testing = adData[-inTrain,]

# Set the seed to 62433
set.seed(62433)

# predict diagnosis with all the other variables using a random forest ("rf"),
mod1 <- train(diagnosis~ ., data = training, method = "rf", prox = TRUE)

# boosted trees ("gbm") and
mod2 <- train(diagnosis~ ., data = training, method = "gbm")

# linear discriminant analysis ("lda") model.
mod3 <- train(diagnosis~ ., data = training, method = "lda")

# Stack the predictions together using random forests ("rf").
pred1 <- predict(mod1, testing)
pred2 <- predict(mod2, testing)
pred3 <- predict(mod3, testing)

# What is the resulting accuracy on the test set? Is it better or worse than each of the individual predictions?
preds <- data.frame(pred1, pred2, pred3, diagnosis = testing$diagnosis)

mod_comb <- train(diagnosis~ ., data = preds, method = "rf", prox = TRUE)

pred_comb <- predict(mod_comb, preds)

sum(pred1 == testing$diagnosis)/nrow(testing)
sum(pred2 == testing$diagnosis)/nrow(testing)
sum(pred3 == testing$diagnosis)/nrow(testing)
sum(pred_comb == testing$diagnosis)

sum(pred_comb == testing$diagnosis)/nrow(testing)

# Compare Accuracy
confusionMatrix(pred1, testing$diagnosis)$overall['Accuracy']
confusionMatrix(pred2, testing$diagnosis)$overall['Accuracy']
confusionMatrix(pred3, testing$diagnosis)$overall['Accuracy']

confusionMatrix(pred_comb, testing$diagnosis)$overall['Accuracy']

# legacy answer differs, boosting had the same accuracy as the model ensemble.
