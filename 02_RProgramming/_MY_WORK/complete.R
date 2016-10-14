
complete <- function(directory = "specdata", id=1:332) {

# directory <- "specdata"
# id <- 1:10

  setwd("~/datasciencecoursera")
  setwd(directory)
  
  
  # Set vector of files to read
  fileNames <- list.files(pattern="*.csv")
  
  results <- NULL
  # Loop through each file wanted
  for (i in id) {
    # Use [[]] to index so returns a filename, not a list
    file <- read.csv (fileNames[[i]] )
    count <- sum(complete.cases(file))
    newRow <- data.frame(id=i, nobs=count)
    results <- rbind(results,newRow)
  }
  results
}


complete("specdata", 1)
complete("specdata", c(2,4,8,10,12))
complete("specdata", 30:25)
complete("specdata", 3)   

