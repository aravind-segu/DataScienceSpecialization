zipUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipFile <- "UCI HAR Dataset.zip"

if(!file.exists(zipFile)){
  print("Downloading...")
  download.file(zipUrl, zipFile, mode = "wb")
}

dataPath <- "UCI HAR DataSet"
if(!file.exists(dataPath)){
  print("Unzipping...")
  unzip(zipFile)
}

trainingSubjects <- read.table(file.path(dataPath, "train", "subject_train.txt"))
trainingSet <- read.table(file.path(dataPath, "train", "X_train.txt"))
trainingLabels <- read.table(file.path(dataPath, "train", "y_train.txt"))

testSubjects <- read.table(file.path(dataPath, "test", "subject_test.txt"))
testSet <- read.table(file.path(dataPath, "test", "X_test.txt"))
testLabels <- read.table(file.path(dataPath, "test", "y_test.txt"))


testSet <- cbind(y_test = testLabels, testSet)
testSet <- cbind(subject = testSubjects, testSet)

trainingSet <- cbind(y_test = trainingLabels, trainingSet)
trainingSet <- cbind(subject = trainingSubjects, trainingSet)

combinedDataSets <- rbind(testSet, trainingSet)

colNames <- read.table(file.path(dataPath, "features.txt"), as.is = TRUE)
colnames(combinedDataSets) <- c("subject", "activity", colNames[, 2])
boolVector = c(TRUE, TRUE, grepl("mean|std", colNames[,2]))
combinedDataSets <- combinedDataSets[,boolVector]

activityLabels <- read.table(file.path(dataPath, "activity_labels.txt"))
combinedDataSets$activity <- activityLabels[,2][combinedDataSets$activity]

colnames(combinedDataSets) <- sub('^t', 'time', colnames(combinedDataSets))
colnames(combinedDataSets) <- sub('^f', 'freq', colnames(combinedDataSets))
colnames(combinedDataSets) <- sub('\\(', '', colnames(combinedDataSets))
colnames(combinedDataSets) <- sub('\\)', '', colnames(combinedDataSets))
colnames(combinedDataSets) <- sub('-', '.', colnames(combinedDataSets))

combinedDataSets <- ddply(combinedDataSets, .(subject, activity), function(x) colMeans(x[, 3:81]))

write.table(combinedDataSets, "tidy_data.txt", row.name=FALSE)
