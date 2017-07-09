library(data.table)
library(reshap2)
library(dplyr)

#download the dataset and unzip
destfile <- "getdata_projectfiles.zip"
if(!file.exists(destfile)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, destfile, method = "curl")
}
if(!file.exists("UCI HAR Dataset")){unzip(destfile)}

#load features and activity labels
features <- read.table("UCI HAR Dataset/features.txt")
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")

#Read training data
subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt")
featuresTrain <- read.table("UCI HAR Dataset/train/X_train.txt")
activityTrain <- read.table("UCI HAR Dataset/train/Y_train.txt")

#Read Test data
subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt", header=FALSE)
featuresTest <- read.table("UCI HAR Dataset/test/X_test.txt", header=FALSE)
activityTest <- read.table("UCI HAR Dataset/test/Y_test.txt", header=FALSE)

#merge the data tables by rows
subjectData <- rbind(subjectTrain, subjectTest)
featuresData <- rbind(featuresTrain, featuresTest)
activityData <- rbind(activityTrain, activityTest)

#Name the columns
names(subjectData) <- c("Subject")
names(activityData) <- c("Activity")
names(featuresData) <- features$V2

#Merge columns to get complete data
mergeData <- cbind(featuresData, activityData, subjectData)

#Extract columns that have mean or std in them
meanStdColumns <- grep(".*Mean.*|.*Std.*", features$V2, ignore.case = TRUE)
reqColumns <- c(meanStdColumns, 562, 563)
finalData <- mergeData[,reqColumns]

#use activity names from activity_labels.txt
finalData$Activity <- factor(finalData$Activity, labels=activityLabels[,2])

#Label the dataset with descriptive variable names
names(finalData) <- gsub("^t", "time", names(finalData))
names(finalData) <- gsub("^f", "frequency", names(finalData))
names(finalData) <- gsub("BodyBody", "Body", names(finalData))
names(finalData) <- gsub("Acc", "Accelorometer", names(finalData))
names(finalData) <- gsub("Gyro", "Gyroscope", names(finalData))
names(finalData) <- gsub("Mag", "Magnitude", names(finalData))

names(finalData) #print the names to check

#Create an independent tidy data set
tidyData <- aggregate(. ~Subject + Activity, finalData, mean)
tidyData <- tidyData[order(tidyData$Subject, tidyData$Activity),]
write.table(tidyData, "TidyData.txt", row.names = FALSE)
