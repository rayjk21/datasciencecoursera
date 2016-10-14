myFunction <- function() { 
  x <- rnorm(100)
  mean (x)
}


# Vectors
x1 <- c(0.5, 0.6)
x2 <- vector("numeric", length=10)
x3 <- 1:10

# Lists
y1 <- list(1, FALSE)
as.character(y1)



#Matrices
m1 <- matrix(nrow=2, ncol=3)
print(m1)
attributes(m1)
# Create from a single vector
m2 <- matrix(1:6, nrow=2, ncol=3)
# Create from binding vectors
x1 <- c(1:3)
x2 <- c(4:6)
m3 <- cbind(x1, x2)
print(m3)
m4 <- rbind(x1, x2)
print(m4)


# Factors
x <- factor(c("Yes", "No", "No"))
print(x)
# Freq counts
table(x)
# Show levels
unclass(x)
# Define levels attribute
x <- factor(c("Yes", "No", "No"), levels = c("Yes", "No"))



# Data Frames
x <- data.frame(x1 = 1:4, x2=c(T,F,F,T), x3=c("a","a","b","b"))
# Rownames default to integers
x
nrow(x)
ncol(x)
summary(x)
attributes(x)
# Show information about dataframe
str(x)
# apply class function to each column in the list to show its type
lapply(x, class)
# Same as lapply but returns a vector
sapply(x, class)

# Just subset columns 2 and 3 (returns another list which is therefore a dataframe)
xx <- x[2:3]
# Do freq on just these columns
table(xx)

# Filter rows.  Must use , ___ to indicate all columns for these rows
x[x$x3=="a",]




#Names
x <- (1:3)  # Sequence
names(x)    # No names yet
# Give name to each value in vector x (not the same as a factor)
names(x) <- c("A", "B", "C")
# Create list, where each item (1,2,3) has a name (a,b,c)
x<- list(a=1, b=2, c=3)
names(x)
# Matrices can be created with dimnames
m <- matrix(1:6, nrow=2, ncol=3, dimnames = list(c("a","b"), c("x", "y", "z")))
m
# Or assign dimnames attribute afterwards.
dimnames(m) <- list(c("a","b"), c("x", "y", "z"))






# Read lines from web connection
con <- url("http://www.apteco.com", "r")
# Store in text vector
apteco <- readLines(con,n=10)
# Show start of vector
head(apteco)




# Subsetting
x <- c("a", "b", "c")
x[2:3]
# By condition
x[x>"b"]
# Create and use logical vector to subset
u <- x > "b"
x[u]




# Functions
add2 <- function(x,y) {
  x + y
}

above10 <- function (x) {
  # Create logical vector of Trun and False
  use <- x>10
  x[use]
}

# Specify default value of n
above <- function(x,n=10) {
  use <- x>n
  x[]
}


columnMean <- function(x, removeNA = TRUE) {
  nc <- ncol(x)
  # Initialise vector
  means <- numeric(nc)
  # Assign each based on column i
  for(i in 1:nc){
    means[i] <- mean(x[,i], na.rm = removeNA)
  }
  means
}
columnMean(airquality)
# List the arguments
formals(columnMean)




#Scoping 1
y<-10
f <- function(x) {
  y ** x
}
f(2)
print(y) 
# Uses value of y in defining environment
# => 100, 10


# Scoping 2
y<-10
f <- function(x) {
  y<-5
  y ** x
}
f(2)
print(y)
# y not a free variable, so assigns locally
# => 25, 10



#Scoping 3
y<-10
f <- function(x) {
  y <- 2 # Assign locally
  y ** x + g(x)
}
g <- function(x) {
  x * y # y is free, so get value from defining environment (not calling, where y=2)
}
f(2)
# => 24 (2^2 + 10*2)
ls(environment(f))
get("y", environment(f))



#lapply = map fn over list
x <- list(1:5, rnorm(10,mean=5))
# Apply mean to each list in the list
lapply(x, mean)

# Apply runif (Random UNIForm distribution)
x <- 1:4
?runif
#runif(n, min = 0, max = 1)
# Generate rand numbers using runif.  Use default args in runif
lapply(x, runif)
# Send other args to runif
lapply(x, runif, min=0, max=10)



x <- list(a = matrix(1:4,2,2), b=matrix(1:6,3,2))
# Extract first column using ANONYMOUS FUNCTION
lapply(x, function(m) m[,1] )


# Create matrix with 20 rows, 10 columns
x <- matrix(rnorm(200), 20,10)
# Dimension 1 is rows, 2 is columns
# Apply to 1 means preserve the rows
apply(x, 1, sum)
# Apply to 2 means preserve the columns
apply(x, 2, mean)

# Need to pass arguments to quantile function via the "..." argument of apply
apply(x,1, quantile, probs=c(0.25, 0.75))

# Create array which is basically 10 2by2 matrices
a <- array(rnorm(40), c(2,2,10))
# Preserve dimension1 1 & 2 (i.e. return a 2x2 matrix of means)
apply(a, c(1,2), mean)
?rnorm

# Apply to multiple arguments
mapply(rep, 1:4, 4:1)
#cf to rep
rep(1,4)

# Use mapply to "vectorise a function"
noise <- function(n, mean, sd) {
  rnorm(n, mean, sd)
}
# sd is always 2, vary n and mean
mapply(noise, 1:5, 1:5, 2)


# Create vector with 10 values from 3 different distributions
x <- c(rnorm(10), runif(10), rnorm(10,1))
# Create factor variables
f <- gl(3,10)
# Calc mean for the 3 differnt groups - simplify by default
tapply(x,f,mean)
#tapply(x,f,mean, simplify=FALSE)
# Return 3 results, each is a list of 2 values
tapply(x,f,range)

# Just split x, without applying any function yet
split(x,f)
# In the following, could just have done tapply
lapply(split(x,f), mean)


library(datasets)
head(airquality)
# Split dataframe into monthly pieces
s <- split(airquality, airquality$Month)
# Use colMeans to collapse rows for given columns
# Anonymous function will be applied to each monthly group created by split
lapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R", "Wind")]))

# Using sapply will simplify result into a matrix
# Also remove NAs
sapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R", "Wind")], na.rm=TRUE))


x <- rnorm(10)
f1 <- gl(2,5)       # First factor has 2 levels
f2 <- gl(5,2)       # Second factor has 5 levels
interaction(f1,f2)  # Shows the interactions that exist when overlay both vectors, and the possible interactions
# Split based on the 2 factors (i.e interactions that exist)
split(x, list(f1,f2))
# Use drop=TRUE to remove empty levels
sapply(split(x, list(f1,f2), drop=TRUE), mean)




# Error debugging
mean(duh)
traceback()  # Error occurs at top level.

lm(y~x)
traceback()  # Error occurs 7 levels deep.


debug(lm)


options(error=recover)

