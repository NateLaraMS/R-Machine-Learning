#train multi-layer nn (neuralnet)
library(neuralnet)

concrete <- read.csv("C:/Users/nalara/OneDrive - Microsoft/Desktop/TTU/Previous/FINAL SEMESTER/ML/8/concrete.csv")
str(concrete)
#remove i..
colnames(concrete)[1] <- gsub('^...','',colnames(concrete)[1])

#normalize or standardize data

#define normalization function (rather than using scale, normalizing between 0 and 1)
normalize <- function(x){
  return((x-min(x))/(max(x)-min(x)))
}

concrete_norm <- as.data.frame(lapply(concrete, normalize))
summary(concrete_norm$strength)

#observe original data vs standardized data
str(concrete)
str(concrete_norm)

#partition data
train<- concrete_norm[1:773,]
test<-concrete_norm[774:1030,]

#build model with training data set
model <-neuralnet(strength~cement + slag + ash + water + superplastic + coarseagg + fineagg +
                    age, data=train)

#plot network topology
plot(model)

#
#evaluate model performance using test data set
#
model_results <- neuralnet::compute(model, test[1:8]) #must specify neuralnet::compute bc dyplr also has compute function
summary(model_results)


#this is a numeric production (rather than a classification problem)
#thus, cannot use a confusion matrix to exam model accuracy
#so measure correlation between predicted_strength and true value
predicted_strength <- model_results$net.result
cor(predicted_strength, test$strength)

#second model (with more than 1 hidden node)
model2<-neuralnet(strength~cement + slag + ash + water + superplastic + coarseagg + fineagg +
                    age, data=train, hidden=5)

plot(model2)

model_results2 <- compute(model2, test[1:8])
summary(model_results)

predicted_strength2 <- model_results2$net.result

cor(predicted_strength2, test$strength)




















model2<-neuralnet(strength~cement + slag + ash + water + superplastic + coarseagg + fineagg +
                    age, data=train, hidden=7)

plot(model2)

model_results2 <- compute(model2, test[1:8])
summary(model_results)
predicted_strength2 <- model_results2$net.result

#observe correlation between both linear vectors
cor(predicted_strength2, test$strength)




