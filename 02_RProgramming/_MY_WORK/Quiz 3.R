library(datasets)
data(iris)

?iris
str(iris)

# Split into multiple dataframes
s <- split(iris,iris$Species)
# Try mean of just one
s1 <- s[[1]]
mean(s1[,"Sepal.Length"])
# apply to all dataframes
sapply(s, function(x) mean(x[, "Sepal.Length"]))




#2 Keep columns 1 to 4, and calculate mean preserving columns
apply(iris[,1:4],2,mean)




#3
library(datasets)
data(mtcars)

str(mtcars)

tapply(mtcars$mpg, mtcars$cyl, mean)
sapply(split(mtcars$mpg, mtcars$cyl), mean)
with(mtcars, tapply(mpg, cyl, mean))



#4
c4 <- mtcars[mtcars$cyl==4,"hp"]
c8 <- mtcars[mtcars$cyl==8,"hp"]
mean(c4) - mean(c8)
