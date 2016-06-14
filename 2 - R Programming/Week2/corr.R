corr <- function(directory, threshold = 0){
  
  correlations <- vector()
  
  ## loop for reading each Data Set
  for (i in 1:332){
    
    ## convert the number into character and put zero's before it if nescessary
    if (i >= 1 && i <= 9){
      j <- as.character(i)
      j <- paste("00", j, ".csv", sep = "")
    }
    else if (i >= 10 && i <= 99){
      j <- as.character(i)
      j <- paste("0", j, ".csv", sep = "")
    }
    else{
      j <- as.character(i)
      j <- paste(j, ".csv", sep = "")
    }
    
    ## create the path to read the DataSet
    bar <- "/"
    path <- paste(directory, bar, j, sep = "")
    
    ## read DataSet an sum all elements from the appropriate collum
    data <- read.table(path, sep = ",", header = TRUE)
    rows <- nrow(data)
    
    sulfate <- vector()
    nitrate <- vector()
    count <- 0
    for (j in 1:rows){
      if (!is.na(data[j,"sulfate"]))
        if (!is.na(data[j,"nitrate"])){
          sulfate[length(sulfate) + 1] <- data[j,"sulfate"]
          nitrate[length(nitrate) + 1] <- data[j,"nitrate"]
          count <- count + 1
        }
    }
    
    if (count >= threshold){
      correlations[length(correlations) + 1] <- cor(sulfate,nitrate)
    }
    
    }
    
  correlations
}