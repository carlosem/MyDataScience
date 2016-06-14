complete <- function(directory, id = 1:332){
  
  result <- data.frame("id" = integer(), "nobs" = integer(), stringsAsFactors=FALSE)
  
  ## loop for reading each Data Set
  for (i in id){
    
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
    
    count <- 0
    for (j in 1:rows){
      if (!is.na(data[j,"sulfate"]))
          if (!is.na(data[j,"nitrate"])){
            count <- count + 1
          }
    }
    
      result[nrow(result) + 1, ] = c(i,count) 

          
    }
  result
  
}