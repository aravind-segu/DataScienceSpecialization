rankAll <- function (outcome, num = "best"){
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
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
  data[,outcomeNum] <- suppressWarnings(sapply(data[,outcomeNum], as.numeric))
  states <- factor(data[,7])
  result <- tapply(data[,outcomeNum], states, rankHospital, num,simplify = TRUE)
  hospitals <- vector()
  i <- 1
  for(state in levels(states)){
    hospital <- data[data$State == state & data[,outcomeNum] == result[i],2]
    hospital <- sort(hospital)[1]
    hospitals <- c(hospitals, hospital)
    i <- i + 1
  }
  cbind(hospitals, levels(states))
}
rankHospital <- function(input,num){
  input <- na.omit(sort(input))
  if (num == "best"){
    input[1]
  }else if (num == "worst"){
    input[length(input)]
  }else if (num < length(input)){
    num <- as.numeric(num)
    input[num]
  }else{
    return(NA)
  }
}
