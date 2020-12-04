# Three aspects that pertain to qualitative activity recognition
# - the problem of specifying correct execution
# - the automatic and robust detection of execution mistakes
# - how to provide feedback on the quality of execution to the user.

# We tried out an on-body sensing approach (dataset here), but also an
# "ambient sensing approach" (by using Microsoft Kinect - dataset still unavailable)

# Six young health participants were asked to perform one set of 10 repetitions
# of the Unilateral Dumbbell Biceps Curl in five different fashions:
# - A: exactly according to the specification
# - B: throwing the elbows to the front
# - C: lifting the dumbbell only halfway
# - D: lowering the dumbbell only halfway
# - E: throwing the hips to the front

# The data for this project come from this source: http://groupware.les.inf.puc-rio.br/har.

# The goal of your project is to predict the manner in which they did the exercise.
# This is the "classe" variable in the training set. You may use any of the other
# variables to predict with. You should create a report describing how you built
# your model, how you used cross validation, what you think the expected out of
# sample error is, and why you made the choices you did. You will also use your
# prediction model to predict 20 different test cases.

library(readr)
library(caret)
library(ggplot2)
library(dplyr)
library(corrplot)
library(tidyr)

set.seed(1234)

col_classes <- paste0("iciicci", paste0(rep("d", 152), collapse = ""), "c")

data <- read_csv("data/pml-training.csv", col_types = col_classes)

# Some of the variables have not many data points.
col_ids <- sapply(data, function(x) sum(is.na(x))) <= 19000

data <- data[, col_ids]
data <- data[, -(1:7)]

# Create train and test datasets
inTrain = createDataPartition(data$classe, p = 3/4)[[1]]

training = data[ inTrain,]
testing = data[-inTrain,]

# summary(training)

# Let's do some preliminary data analysis
cm <- cor(training[, -ncol(training)])

corrplot(cm, method = "circle")

tidy_training <- pivot_longer(training, cols = !any_of("classe"))

ggplot(tidy_training, aes(x = classe, y = value, fill = classe)) +
  geom_violin() +
  facet_wrap(~name, scale = "free")

# Build model
mod1 <- train(classe~ ., data = training, method = "lda")
mod2 <- train(diagnosis~ ., data = training, method = "gbm")
mod3 <- train(classe~ ., data = training, method = "rf", prox = TRUE)

pred <- predict(mod1, testing)

confusionMatrix(pred, as.factor(testing$classe))$overall['Accuracy']

final_model <- mod1

# Final Prediction
final_pred <- read_csv("data/pml-testing.csv", col_types = col_classes)

final_pred <- final_pred[, col_ids]
final_pred <- final_pred[, -(1:7)]

predict(final_model, final_pred)
