## Getting and Cleaning Data Project

This document describes how to execute the **run_analysis.R** script.

* Ensure the script **run_analysis.R** is in the current working directory.

* Run command **source("run_analysis.R")** in RStudio.

* It downloads the data from <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip> and unzips the files to the folder **"./data/UCI HAR Dataset"**.
 
* It then generates 2 output files in the folder **"data"** in the current working directory:
      1.  merged_data.txt : Contains a data frame mergedData with dimension 10299 x 68.
      2.  tidy_data.txt : Contains a data frame tidyData with dimension 180 x 68.

* View the data frame **tidyData** for final results output.

* Do refer document **CodeBook.md** for detailed steps on how the **run_analysis.R** script works.
