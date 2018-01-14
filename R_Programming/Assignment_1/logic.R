pollutantmean <- function(directory, pollutant, id = 1:332){
  df <- data.frame()
  for (i in id){
    data <- read.csv(getFileName(directory, i), header = TRUE)
    df <- rbind(df, data)
  }
  removeNa <- complete.cases(df[,pollutant])
  mean(df[removeNa, pollutant])
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