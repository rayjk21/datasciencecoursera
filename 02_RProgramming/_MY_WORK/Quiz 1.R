
# Test
x <- list (2, "a", "b", TRUE)
x[[1]]

x <- c(1,2,3)
y <- 5
x+y


x <- c(3, 5, 1, 10, 12, 6)
x[x<6] <- 0
x



dir()
quiz1 <- read.csv("hw1_data.csv")
#11
str(quiz1)
#12
help(read.csv)
read.csv("hw1_data.csv", nrows=2)
#13
nrow(quiz1)
#14
quiz1[152:153, ]

#15
quiz1[47,"Ozone"]

#16
bad <- is.na (quiz1[,"Ozone"])
sum(bad)

#17
mean (quiz1[!bad, "Ozone"])

#18
notNa <- complete.cases(quiz1)
wanted <- (quiz1$Ozone>31) &  (quiz1$Temp>90)

select <- wanted & notNa
values <- quiz1[select,"Solar.R"]
mean (values)

#19
mean (quiz1[quiz1$Month == 6,  "Temp"])

#20
Oz <- (quiz1[quiz1$Month == 5,  "Ozone"])
bad <- is.na(Oz)
max(Oz[!bad])

