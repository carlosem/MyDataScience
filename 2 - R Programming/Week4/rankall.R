
rankall <- function(outcome, num = "best") {
  
  ## Read outcome data
  data <- read.csv("outcome-of-care-measures.csv")
  
  ## Check that state and outcome are valid
  temp <- as.character(data[, 7]) ## collum of state = 7
  
  ## get rid of NA values
  bad <- is.na(temp)
  state <- unique(temp[!bad])
  
  ## take the indice of the outcome and see if 
  ## there is such an outcome
  ind <- numeric()
  if (outcome == "heart attack")
    ind <- 11
  else if (outcome == "heart failure")
    ind <- 17
  else if (outcome == "pneumonia")
    ind <- 23
  else
    stop("invalid outcome")
  
  ## For each state, find the hospital of the given rank
  
  result <- data.frame()
  for (k in 1:length(state)){
    
    estado <- as.character(data[,7])
    problema <- as.numeric(as.character(data[,ind]))
    hosp <- as.character(data[,2])
    
    hospital <- vector("character")
    valor <- vector("numeric")
    j <- 0
    
    ## This loop puts the name of each hospital of the given state in the vector hospital[]
    ## and in the vector valor[] is put the rate of the outcome for the corresponding hospital 
    ## in the vector hospital[]
    for (i in 1:nrow(data)){
      if (state[k] == estado[i])
        if (!(is.na(problema[i])))
          if (!(hosp[i] %in% hospital)){
            j <- j + 1
            hospital[j] <- hosp[i]
            valor[j] <- problema[i]
          }
      else {
        xx <- hosp[i]
        w <- which(hospital == xx)
        valor[w] <- valor[w] + problema[i]
      }
    }
   
    m <- data.frame(valor, hospital)
    
    ord2 <- order(m[,2])
    m1 <- m[ord2,]
    ord <- order(m1[,1])
    m2 <- m1[ord,]
    
    result[k,1] <- state
    result[k,2] <- as.character(m2[num,2])
     
    
  }
  
  ## Return a data frame with the hospital names and the
  ## (abbreviated) state name
  result
}
