library(MVA)

#import data
data("USairpollution", package = "HSAUR2")
summary(USairpollution)
#exctrat variables and create independent vectors
mydata1 <- USairpollution[, c("temp", "wind")]
mydata2 <- USairpollution[, c("temp", "precip")]


#plot the data
bvbox(mydata1, xlab = "Temperature (in Fahrenheit)", ylab = "Wind Speed (in MPH)")
#add text to identify outliers
text(USairpollution$temp, USairpollution$wind, cex = 0.6,      
     labels=abbreviate(row.names(USairpollution))) 
#plot the data
#add text to identify outliers
bvbox(mydata2, xlab = "Temperature (in Fahrenheit)", ylab = "Precipitation") 
text(USairpollution$temp, USairpollution$precip, cex = 0.6,      
     labels=abbreviate(row.names(USairpollution))) 

#Identify outliers
#create outlier vectors
#for temp and wind
outliers_wind <- c("Phoenix", "Miami")
#for temp and precip
outliers_precip <- c("Albuquerque", "Denver","Phoenix", "Miami")