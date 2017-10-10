# Data Preprocessing Template

# Importing the dataset
dataset = read.csv('movie_metadata_test.csv')

# missing data
dataset$gross = ifelse(is.na(dataset$gross),
                     ave(dataset$gross, FUN = function(x) mean(x, na.rm = TRUE)),
                     dataset$gross)

# Splitting the dataset into the Training set and Test set
# install.packages('caTools')
library(caTools)
set.seed(123)
split = sample.split(dataset$gross, SplitRatio = 0.8)
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)

# Feature Scaling
# training_set = scale(training_set)
# test_set = scale(test_set)

#fitting linear regression model into the dataset

y_pred=predict(regressor, newdata = test_set)

# visulaize the data

install.packages('ggplot2')
library(ggplot2)
ggplot()+
  geom_point(aes( x = training_set$duration, y= training_set$gross), color = 'red')+
  geom_line(aes(x = training_set$duration , y= predict(regressor, newdata = training_set)), color = 'blue')+
  ggtitle('Duration vs Gross (Training Set)')+
  xlab('Duration')+
  ylab('Gross')+ scale_y_continuous(labels = scales::comma)


ggplot()+
  geom_point(aes( x = test_set$duration, y= test_set$gross), color = 'red')+
  geom_line(aes(x = training_set$duration , y= predict(regressor, newdata = training_set)), color = 'blue')+
  ggtitle('Duration vs Gross (Test Set)')+
  xlab('Duration')+
  ylab('Gross')+ scale_y_continuous(labels = scales::comma)

 