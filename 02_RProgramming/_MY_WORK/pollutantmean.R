
pollutantmean <- function(directory = "specdata", pollutant, id=1:332) {

# directory <- "specdata"
# id <- 1:10
# pollutant <- "sulfate"
  
  setwd("~/datasciencecoursera")
  setwd(directory)
  
  
  # Set vector of files to read
  fileNames <- list.files(pattern="*.csv")
  
  # Concatenate tables 
  # data <- rbind(useFiles) # Doesn't work
  data <- NULL
  for (i in id) {
    # Use [[]] to index so returns a file, not a list
    file <- read.csv(fileNames[[i]])
    data <- rbind(data,files[[i]])
  }
  
  mean(data[[pollutant]], na.rm = TRUE)

}


# pollutantmean("specdata", "sulfate", 1:10)   # 4.064
# pollutantmean("specdata", "nitrate", 70:72)  # 1.706

