rankHospital <- function(state, outcome, num = "best"){
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  if (!state %in% unique(data[,7])) stop("invalid state")
  state <- data[data$State == state,]
  outcomeNum <- 0
  if (outcome == "heart attack"){
    outcomeNum <- 11
  }else if (outcome == "heart failure"){
    outcomeNum <- 17
  }else if (outcome == "pneumonia"){
    outcomeNum <- 23
  }else(
    stop("invalid outcome")
  )
  state[,outcomeNum] <- suppressWarnings(sapply(state[,outcomeNum], as.numeric))
  state <- na.omit(state[order(state[,outcomeNum],state[,2]),])
  sorted <- cbind(state[,2], state[,outcomeNum])
  if (num == "best"){
    sorted[1]
  }else if (num == "worst"){
     sorted[length(sorted[,1])]
  }else if (num < length(sorted[,1])){
    num <- as.numeric(num)
     sorted[num]
  }else{
    return(NA)
  }
}