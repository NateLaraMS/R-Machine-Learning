library(arules)
library(arulesViz)


data(Groceries)
summary(Groceries)
#this dataset is not in matrix form
#previous datasets used had row indicating example instances
#and columns indicating feature

itemFrequency(Groceries[,1:4])

itemFrequencyPlot(Groceries, support=0.1)

itemFrequencyPlot(Groceries, topN=20)

apriori(Groceries)

#widen search by setting parameters


#setting rules too high might not bring any results
#setting them too low might bring so many that it is unmanageable

#minimal rule setting
myRules <- apriori(Groceries, parameter = list(support=0.006, confidence=0.25,
                                               minlen=2))

myRules2 <- apriori(Groceries, parameter = list(support=0.001, confidence=0.9,
                                                maxlen=4))

#evaluate model performance
summary(myRules)

#lift - measure how much more likely an item is purchased, relative to its
#       physical rate of purchase, given that another item or item set has been 
#       purchased
# lift of over 1, implies that 2 items are together more than by chance
# A LARGE LIFT VALUE IS A STRONG INDICATOR THAT A RULE IS IMPORTANT
# AND IT REFLECTS A TRUE CONNECTION BETWEEN THE ITEMS
#
#
#mining info - shows how rules were chosen

#inspect function
inspect(myRules[1:3])

#GOAL OF Market Basket Analysis is to find "actionable rules"
# provides clear insight

# Some rules are clear, some are useful
# Buying a washer and dryer example
# Random rules 

inspect(sort(myRules, by="lift")[1:5])

#find rules that include berries example
berryRules <- subset(myRules, items%in% "berries")
inspect(berryRules)


#fruit rules
fruitRules <- subset(myRules, items %pin% "fruit")
inspect(fruitRules)



myRules3=sort(myRules2, by="lift", decreasing=TRUE)
inspect(myRules3[1:5])

#beer rules example
beerRules <- apriori(Groceries, parameter = list(support=0.0015, 
                                                 confidence=0.3), 
                     appearance=list(default="lhs",
                                     rhs="bottled beer"))
inspect(beerRules)

#investigate relationship between botteled beer and red wine
table <- arules::crossTable(Groceries)
table["bottled beer", "red/blush wine" ] 
table["red/blush wine", "red/blush wine"]

#plot relationship
plot(beerRules, method="graph", measure="lift", shading="confidence")


