values <- 1:10

values

add_one <- function(x){
  x + 1
}

add_one(values[1])

# For loop example
for (i in values){
  print(add_one(i))
}

################ USING APPLY ###################
# Has 3 arguments: x, MARGIN (rows or columns), FUN (actual function that will be applied over MARGIN)
#
## apply(matrix, 1, function)
#
#
#
#
#
#
df <- mtcars[1:4, 1:4]
df

apply(df, 1, min)
apply(df, 2, min)

add_one <- function(x){
  x + 1
}

apply(df, 2, add_one)

## For Loop vs Vectorize
#
#
#Vectorize - batch function call over entire object





######## Anonymous Functions ######## 
# Function with no name
# must be consumed immediately
# example of anonymous function:
function(x) x + 1
# put parenthesis around function to use it (here the function will be applied to the number 3)
(function(x) x+1)(3)
# 
# 
# 

#### Using Anonymous Functions in APPLY ####
apply(df, 2, add_one)
#anonymous function
apply(df, 2, function(x) x+1)
#################################









