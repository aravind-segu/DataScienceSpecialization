corr <- function(directory, threshold = 0){
  result <- vector("numeric", 0)
  allComplete <- complete(directory)
  correct <- allComplete[allComplete['nobs'] > threshold,]
  for (i in 1:nrow(correct)){
    data <- read.csv(getFileName(directory, correct[i, "id"]), header = TRUE)
    correlation <- cor(data[,"sulfate"], data[,"nitrate"], use = "complete.obs")
    result <- append(result, correlation)
  }
  result
}
complete <- function(directory, id = 1:332){
  result <- data.frame()
  for (i in id){
    data <- read.csv(getFileName(directory, i), header = TRUE)
    goodSulfate <- complete.cases(data[,"sulfate"])
    goodNitrate <- complete.cases(data[,"nitrate"])
    count <- 0
    for (j in seq_along(goodSulfate)){
      if (goodSulfate[j] & goodNitrate[j]){
        count <- count + 1
      }
    }
    id <- union(id, c(i))
    nobs <- union(nobs, c(count))
    df <- data.frame("id" = i, "nobs" = count)
    result <- rbind(result, df)
  }
  result
}
getFileName <- function(directory , i){
  if (i >= 100){
    return(paste(directory,"/",i,".csv", sep = ""))
  }else if (i >= 10){
    return(paste(directory,"/0",i,".csv", sep = ""))
  }else{
    return(paste(directory,"/00",i,".csv", sep = ""))
  }
}