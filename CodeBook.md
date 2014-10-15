## Getting and Cleaning Data: Project - CodeBook
### Introduction

This document describes the data, script, variables and steps performed to get, clean & merge the data. 

### Data Source  
<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>

### Dataset 

#### Human Activity Recognition Using Smartphones

<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

The original data set is split into training and test sets where each partition is further split into three files that contain:

* Measurements from the accelerometer and gyroscope
*	Activity label
*	Subject identifier

### Script 

R script **run_analysis.R** performs the following steps to  get, clean & merge the data:   

  1.  Create folder named **"data"** if it does not exist in the current working directory. 
  2.  Download the data files from the UCI Machine Learning Repository to the folder **"./data/UCI HAR Dataset"**.  
  3.  Read files X_train.txt, y_train.txt and subject_train.txt from the folder "./UCI HAR Dataset/train" and store them in data frames train_X, train_Y and train_S   respectively.
  4.  Read files X_test.txt, y_test.txt and subject_test.txt from the folder "./UCI HAR Dataset/test" and store them in data frames test_X, test_Y and test_S respectively.
  5.  Concatenate test_X to train_X to generate a data frame join_X; Concatenate test_Y to train_Y to generate a data frame join_Y;     Concatenate test_S to train_S to generate a data frame join_S.
  6.  Read the features.txt file from the "./UCI HAR Dataset" folder and store the data in a variable called features.Extract the measurements on the mean and standard deviation. This results in a 66 indices list(named meanStdIdx). Get a subset of join_X with the 66 corresponding columns.
  7.  Clean the column names of the subset by removing "()" and "-" symbols in the names and capitalize the first letter of "mean" and "std".
  8.  Read the activity_labels.txt file from the "./UCI HAR Dataset" folder and store the data in a variable called activity.
  9.  Clean the activity names in the second column of activity. Make all names to lower cases, remove the underscore - if any -and capitalize the letter immediately after the underscore.
  10. Transform the values of join_Y according to the activity data frame.
  11. Combine the join_S, join_Y and join_X by column to get a new cleanedup data frame mergedData of dimension 10299x68. Properly name the first two columns, "subject" and "activity". The "subject" column contains integers that range from 1 to 30 inclusive; the "activity" column contains 6 kinds of activity names; the last 66 columns contain measurements.
  12. Write the mergedData to **merged_data.txt** file in the current working directory.
  13. Finally, generate a second independent tidy data set with the average of each measurement for each activity and each subject. There are 30 unique subjects and 6 unique activities, which results in a 180 combinations of these two variables. Then, for each combination, calculate the mean of each measurement with the corresponding combination. After initializing the tidyData data frame and performing the 2 for-loops, we get a 180x68 data frame.
  14. Write the tidyData to **tidy_data.txt** file in the current working directory.