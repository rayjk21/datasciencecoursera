set.seed(1)
rpois(5, 2)


x1<-rnorm(100000,0,1)
x2<-rnorm(100000,0,1)
y <- x1 + x2


Rprof("My RProfile.txt")
fit <- lm(y ~ x1 + x2)
Rprof(NULL)


summaryRprof("My RProfile.txt")


getwd()

