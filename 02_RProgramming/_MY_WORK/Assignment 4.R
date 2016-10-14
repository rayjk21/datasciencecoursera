install.packages("dplyr")
install.packages("tibble")

library(dplyr)

setwd("C:/Users/rkirk/Documents/GIT/Repos/datasciencecoursera")




expt <- function() {
    data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    head(data)
    
    ncol(data)
    colnames(data)
    
    str(data)
    
    fieldName <- "Hospital.30.Day.Readmission.Rates.from.Heart.Attack"
    
    data[fieldName]
    data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack
    
    
    
    # Convert to numeric
    data[, 11] <- as.numeric(data[, 11])
    
    hist(data[, 11])
}    









# Loads the data for the given outcome
getData <- function(fieldName) {
    data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    
    # Create lowercase version of field
    fieldName <- paste("Hospital.30.Day.Death..Mortality..Rates.from", fieldName)
    fieldName <- gsub(" ", ".", fieldName)
    fieldName <- tolower(fieldName)
    
    # Get everything in lowercase
    colnames(data) <- tolower(colnames(data))
    
    if (fieldName %in% colnames(data)){
        
        # Just keep the columns needed
        keepCols <- colnames(data) %in% c("state", "hospital.name", fieldName)
        data <- data[keepCols]
        
        # Convert field to numeric and remove NAs
        data[[fieldName]] <- as.numeric(data[[fieldName]])
        data <- data[complete.cases(data),]
        
        result = list(fieldName = fieldName, data=data)
        return(result)
    } else{
        stop("invalid outcome")
    }    
}






# Gets the data for the given outcome and state, sorted by outcome
topHospitals <- function(state, outcome) {
    
    #outcome <- "pneumonia"
    #state = "NY"
        
    #outcome <- "heart attack"
    #state = "SC"
    
    
    x <- getData(outcome)
    
    # Filter rows to just the state
    data <- x$data[x$data$state == state, ]
    
    if (nrow(data) == 0) {
        stop("invalid state")
    }
    

    # Sort by the field
    sortBy <- x$fieldName
    
    top <- data[order(data[[sortBy]],data[["hospital.name"]], decreasing=FALSE),]
    
    
    print(head(top))
    print(sortBy)
    
    # Return top hospitals
    return (top)
}





# Returns the top hospital
best <- function(state, outcome) {
    # Get full list
    topH <- topHospitals(state, outcome)

    # Return name of top hospital
    return (topH[1,1])
}



best("SC", "heart attack") # "MUSC MEDICAL CENTER"
best("NY", "pneumonia")   # "MAIMONIDES MEDICAL CENTER"
best("AK", "pneumonia")    # "YUKON KUSKOKWIM DELTA REG HOSPITAL"



best ("TX", "Heart Attack")
best ("TX", "Heart Failure")
best("MD", "heart attack")
best("MD", "pneumonia")
best("BB", "heart attack")
best("NY", "hert attack")





# Returns hospital with the given position
rankhospital <- function(state, outcome, position="best") {

    #outcome <- "heart attack"
    #state = "MD"
    #position <- "best"
        
    # Get full list
    topH <- topHospitals(state, outcome)

    if (position == "best") {         
        n <- 1
    } else if (position == "worst") {
        n <- nrow(topH)
    } else {
        n <- as.numeric(position)
    }
    
    #print(head(topH))

    # Return name of hospital in requested position
    return (topH[n,1])
}



rankhospital("TX", "heart failure", 4)      # "DETAR HOSPITAL NAVARRO"
rankhospital("MD", "heart attack", "worst") # "HARFORD MEMORIAL HOSPITAL"
rankhospital("MN", "heart attack", 5000)

rankhospital("NC", "heart attack", "worst")
rankhospital("WA", "heart attack", 7)
rankhospital("TX", "pneumonia", 10)
rankhospital("NY", "heart attack", 7)



rankhospital("HI", "heart attack", 4)
rankhospital("NJ", "pneumonia", "worst")
rankhospital("NV", "heart failure", 10) 

    

rankall <- function(outcome, position) {
    
    #outcome <- "Heart Attack"
    #state = "MD"
    
    x <- getData("Heart Attack")
    x$data
    
    
    #ave(x$data, x$data[[x$fieldName]], x$data["state"], rank)
    ave(x$data, x$data[["state"]],x$data[[x$fieldName]], FUN=rank)
    
}






