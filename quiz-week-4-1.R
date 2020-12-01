# install.packages(c("ElemStatLearn", "AppliedPredictiveModeling", "caret", "pgmm",
#                     "rpart", "gbm", "lubridate", "forecast", "e107", "e1071", "randomForest"))

library(ElemStatLearn)
library(caret)

data(vowel.train)

data(vowel.test)

# Set the variable y to be a factor variable in both the training and test set.
str(vowel.test)

vowel.test$y <- as.factor(vowel.test$y)
vowel.train$y <- as.factor(vowel.train$y)

# Then set the seed to 33833.
set.seed(33833)

# Fit (1) a random forest predictor relating the factor variable y to the remaining variables and
rf <- train(y~ ., data = vowel.train, method = "rf", prox = TRUE)

# (2) a boosted predictor using the "gbm" method.
boost <- train(y~ ., data = vowel.train, method = "gbm")

# Fit these both with the train() command in the caret package.

# What are the accuracies for the two approaches on the test data set?
pred_rf <- predict(rf, vowel.test)
sum(pred_rf == vowel.test$y)/nrow(vowel.test)
# 0.5995671

pred_boost <- predict(boost, vowel.test)
sum(pred_boost == vowel.test$y)/nrow(vowel.test)
# 0.5367965

# What is the accuracy among the test set samples where the two methods agree?
sum(pred_rf == pred_boost)/nrow(vowel.test)
# 0.6948052
