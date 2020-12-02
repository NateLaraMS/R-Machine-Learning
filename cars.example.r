library(neuralnet)
#import data
toyota <-read.csv("C:/Users/nalara/OneDrive - Microsoft/Desktop/TTU/Previous/FINAL SEMESTER/ML/8/toyota.csv")

str(toyota)
levels(toyota$Fuel_Type)

#create dummy variables

toyota$Fuel_Type <- ifelse(toyota$Fuel_Type=="Diesel",1,0)
#toyota$fuel1[toyota$Fuel_Type=='CNG'] <- '1'
#toyota$fuel1[toyota$Fuel_Type!='CNG'] <-'0'
#toyota$Fuel_Type <- as.factor(toyota$Fuel_Type)
#toyota$Fuel_Type <- as.numeric(toyota$Fuel_Type)
str(toyota)

#use dplyr lib to drop unwanted columns
library(dplyr)
#3,4,7,8,9,10
t10 <- select(toyota, -c(1:2,5,6,11,15:17,19:40))
str(t10)

library(caret)
#write function for converting to factor
to.factor <- function(df, variables){
  for(variable in variables){
    df[[variable]]<-as.factor(df[[variable]])
  }
  return(df)
}
#to numeric
to.num <- function(df, variables){
  for(variable in variables){
    df[[variable]]<-as.numeric(df[[variable]])
  }
  return(df)
}
#create vector for using factor transforming function
cat.var <- c('Price','Age_08_04',	'KM','Fuel_Type',	'HP',	'Met_Color',	'Automatic',	
             'CC',	'Doors',	'Weight')

t10.num<-to.num(df=t10, variables=cat.var)
str(t10.num)

################################## A
################################## A
################################## A
################################## A
#normalize and categorize variables & create data parition
normalize <- function(x){
  return((x-min(x))/(max(x)-min(x)))
}

t10.norm <- as.data.frame(lapply(t10.num, normalize))
summary(t10.norm$Price)
str(t10.num)
str(t10.norm)

#t10.norm is our 10 variables normalized, renaming to t for simplicity
t <-t10.norm
#partition 60:40
#partition data
#train
part<-createDataPartition(t$Price, p = 0.6, list = FALSE)
train<-t[part,]
test<-t[-part,]
str(train)
str(test)

###############
###############
######### using neuralnet 
##############
#############

#train multi-layer nn (neuralnet)
model <-neuralnet(Price~Age_08_04 + KM + Fuel_Type + HP + Met_Color + Automatic + CC +
                    Doors + Weight, data=train)

#plot network topology
plot(model)

#then evaluate model performance
model_results <- neuralnet::compute(model, test[2:10])
#summary(model_results)

pred_price <- model_results$net.result

#cannot use a confusion matrix to exam model accuracy
#so measure correlation between prediction and true value
cor(pred_price, test$Price)



################################## 

#second model with hidden nodes of 5, still using the neuralnet package
model2 <-neuralnet(Price~Age_08_04 + KM + Fuel_Type + HP + Met_Color + Automatic + CC +
                     Doors + Weight, data=train, hidden=5)

plot(model2)

model_results2 <- neuralnet::compute(model2, test[2:10])
summary(model_results2)

pred_price2 <- model_results2$net.result

cor(pred_price2, test$Price)
