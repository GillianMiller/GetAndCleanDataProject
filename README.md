# GetAndCleanDataProject

Getting and Cleaning Data Project Files for Course Project

## Overview

This file is tidy data which has been read and cleansed on human activity data.
These data sets are from recordings of subjects performing daily activities while carrying
smartphones.

## Overview of processing steps

The steps that are performed in processing are :
1. Merge the training and the test sets to create one data set.
2. Extract the measurements on the mean and standard deviation 
3. Use descriptive activity names to name the activities in the data set
4. Appropriately label the data set with descriptive variable names. 
5. From the data set in step 4, create a  second, 
    independent tidy data set with the average of each 
    variable for each activity and each subject.

## Steps to work on this course project

1. Clone the github repository to directory ```myDir```. Set this as working directory in R.
2. Download the data source and add it to folder ```myDir```.  This will result in a ```myDir\UCI HAR Dataset``` folder.
3. Run ```source("run_analysis.R")``` to generate result ```tidy_data.txt``` in the working directory.

## Dependencies

```run_analysis.R``` requires ```reshape2``` and ```data.table```. 
