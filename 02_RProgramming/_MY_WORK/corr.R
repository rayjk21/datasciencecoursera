

source("~/datasciencecoursera/complete.R")
source("~/datasciencecoursera/pollutantmean.R")


corr <- function(directory = "specdata", threshold=0) {

# directory <- "specdata"
# threshold <- 1000
# i <- 2

  setwd("~/datasciencecoursera")
  setwd(directory)
  
  
  # Set vector of files to read
  fileNames <- list.files(pattern="*.csv")
  
  # Count complete cases in each file
  cases <- complete(directory)
  # Get cases where above threshold
  use <- cases[cases$nobs > threshold,]
  
  # Get means across all the ids
  #sulfates <- pollutantmean(directory, "sulfate", use$id)
  #nitrates <- pollutantmean(directory, "nitrate", use$id)
  
  results <- NULL
  for (i in use$id) {
    # Whole file for this id
    data <- read.csv(fileNames[[i]])
    # Correlation value for this id
    cI <- cor(x=data$sulfate, y=data$nitrate, use="complete")
    # Get nobs for this id 
    nI <- use[use$id==i, "nobs"]
    
    # Create result observation for this id
    obs <- data.frame(id=i, nobs=nI, corr=cI)
    # Append to all results
    results <- rbind(results,obs)
  }
  
  print(results)
  # Just return vector of correlations
  results$corr
}


cr <- corr(threshold=150)
head(cr)
summary(cr)

