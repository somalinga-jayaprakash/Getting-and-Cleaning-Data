# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

library(plyr)

message("Step 1: Merge the training and the test sets to create one data set")

message("Download data...")

if(file.exists("./data")) {
  setwd("./data")
} else {
  dir.create("./data")
  setwd("./data")
}

fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "Dataset.zip")
unzip("Dataset.zip")


message("Merge training and test datasets...")

train_S<-read.table("./UCI HAR Dataset/train/subject_train.txt")
train_Y<-read.table("./UCI HAR Dataset/train/y_train.txt")
train_X<-read.table("./UCI HAR Dataset/train/X_train.txt")

test_S<-read.table("./UCI HAR Dataset/test/subject_test.txt")
test_Y<-read.table("./UCI HAR Dataset/test/y_test.txt")
test_X<-read.table("./UCI HAR Dataset/test/X_test.txt")


message("Join train and test files...")
join_S <-rbind(train_S,test_S)
join_Y<-rbind(train_Y,test_Y) # Activities
join_X<-rbind(train_X,test_X)

message("Step 2: Extract only the measurements on the mean and 
        standard deviation for each measurement") 

features<-read.table("./UCI HAR Dataset/features.txt")
meanStdIdx <- grep("mean\\(\\)|std\\(\\)", features[, 2])
join_X <- join_X[, meanStdIdx]
names(join_X) <- gsub("\\(\\)", "", features[meanStdIdx, 2]) # remove "()"
names(join_X) <- gsub("mean", "Mean", names(join_X)) # capitalize M
names(join_X) <- gsub("std", "Std", names(join_X)) # capitalize S
names(join_X) <- gsub("-", "", names(join_X)) # remove "-" in column names


message("Step 3: Uses descriptive activity names to name the activities in
        the data set")

activity <- read.table("./UCI HAR Dataset/activity_labels.txt")
activity[, 2] <- tolower(gsub("_", "", activity[, 2]))
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8))
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8))
activityLabel <- activity[join_Y[, 1], 2]
join_Y[, 1] <- activityLabel
names(join_Y) <- "activity"


message("Step 4: Appropriately labels the data set with 
        descriptive variable names") 

names(join_S) <- "subject"
mergedData <- cbind(join_S, join_Y, join_X)
write.table(mergedData, "merged_data.txt") # 1st dataset

message("Step 5: From the data set in step 4, creates a second, 
    independent tidy data set with the average of each variable 
    for each activity and each subject")

subjectLen <- length(table(join_S))
activityLen <- dim(activity)[1] 
columnLen <- dim(mergedData)[2]
tidyData <- matrix(NA, nrow=subjectLen*activityLen, ncol=columnLen)
tidyData <- as.data.frame(tidyData)
colnames(tidyData) <- colnames(mergedData)
row <- 1
for(i in 1:subjectLen) {
  for(j in 1:activityLen) {
    tidyData[row, 1] <- sort(unique(join_S)[, 1])[i]
    tidyData[row, 2] <- activity[j, 2]
    bool1 <- i == mergedData$subject
    bool2 <- activity[j, 2] == mergedData$activity
    tidyData[row, 3:columnLen] <- colMeans(mergedData[bool1&bool2, 3:columnLen])
    row <- row + 1
  }
}

View(tidyData)
write.table(tidyData, "tidy_data.txt") #  2nd dataset

