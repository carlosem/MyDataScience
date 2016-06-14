
rankhospital <- function(state, outcome, num = "best") {
  ## Read outcome data
  data <- read.csv("outcome-of-care-measures.csv")
  
  ## Check that state and outcome are valid
  
  temp <- as.character(data[, 7]) ## collum of state = 7
  
  ## get rid of NA values
  bad <- is.na(temp)
  s <- unique(temp[!bad])
  
  ## see if there is such a state
  if (!state %in% s)
    stop("invalid state")
  
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
  
  ## Return hospital name in that state with the given rank
  ## 30-day death rate
  
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
    if (state == estado[i])
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
  
  if (is.numeric(num)){ 
    if (num > length(hospital)) return("NA")
  }
    
  if (num == "best"){
    menor <- which(valor == min(valor))
    
    temp2 <- vector()
    for (i in 1:length(menor)){
      temp2[i] <- hospital[menor]
    }
    
    temp2 <- sort(temp2, decreasing = FALSE)
    return(temp2[1])
  }
  else if (num == "worst"){
    menor <- which(valor == max(valor))
    
    temp2 <- vector()
    for (i in 1:length(menor)){
      temp2[i] <- hospital[menor]
    }
    
    temp2 <- sort(temp2, decreasing = TRUE)
    return(temp2[1])
  }
  else{
    
    m <- data.frame(valor, hospital)
    
    ord2 <- order(m[,2])
    m1 <- m[ord2,]
    ord <- order(m1[,1])
    m2 <- m1[ord,]
    
    r <- as.character(m2[num,2])
    r
    
  }
  
}