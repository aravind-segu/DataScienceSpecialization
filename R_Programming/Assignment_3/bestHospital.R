best <- function(state, outcome){
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
  minIndex <- min(state[,outcomeNum], na.rm = TRUE)
  allHospitals <- state[(state[,outcomeNum] == minIndex),]
  print(sort(allHospitals[,2])[1])
}