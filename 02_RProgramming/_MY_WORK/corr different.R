

source("~/datasciencecoursera/complete.R")
source("~/datasciencecoursera/pollutantmean.R")

# This function calculates a single correlation figure based on the mean of each statistic from the set of monitors

corr <- function(directory = "specdata", threshold=0) {

# directory <- "specdata"
# threshold <- 1000
# i <- 2

  setwd("~/datasciencecoursera")
  setwd(directory)
  
  # Count complete cases in each file
  cases <- complete(directory)
  # Get cases where above threshold
  use <- cases[cases$nobs > threshold,]
  
  # Get means across all the ids
  #sulfates <- pollutantmean(directory, "sulfate", use$id)
  #nitrates <- pollutantmean(directory, "nitrate", use$id)
  
  results <- NULL
  for (i in use$id) {
    # Mean for individual id
    sulfateI <- pollutantmean(directory, "sulfate", i)
    nitrateI <- pollutantmean(directory, "nitrate", i)
    # Get nobs for this id 
    nI <- use[use$id==i, "nobs"]
    obs <- data.frame(id=1, nobs=nI, sulfate=sulfateI, nitrate=nitrateI)
    results <- rbind(results,obs)
  }
  print(results)
  
  cor(results$sulfate,results$nitrate)
}


corr(threshold=1000)

