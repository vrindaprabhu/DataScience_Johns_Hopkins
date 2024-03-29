---
title: "Project_Getting and Cleaning Data"
author: "Vrinda Prabhu"
date: "Friday 25 December 2015"
output: html_document
---



#### _Including the required library_


```r
library(plyr)
```

## Requirement 1: 
Merge the training and the test sets to create one data set.

Reading all the data separately into respective variables:

Train data :

```r
x_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")
subject_train <- read.table("train/subject_train.txt")
```

Test data :

```r
x_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")
subject_test <- read.table("test/subject_test.txt")
```


Combining the test and train_data sets separately for x,y and subject.
The *UCI_HAR_data* is the merged data set required.


```r
features_names <- read.table("features.txt")
X_data <- rbind(x_test,x_train)
colnames(X_data) <- features_names[,2]

Y_data <- rbind(y_test,y_train)
colnames(Y_data) <- "Activity_ID"

Subject_data <- rbind(subject_test,subject_train)
colnames(Subject_data) <- "Subject_ID"

UCI_HAR_data <- cbind(X_data, Y_data, Subject_data) 
```


## Requirement 2: 
Extracts only the measurements on the mean and standard deviation for each measurement. 

Here the meanFreq is not included in the subsetting of dataset.

```r
mean_and_standard_deviation <- grepl("-mean|-std",colnames(X_data)) & !grepl("-meanFreq",colnames(X_data))
X_data_mean_std <- X_data[,mean_and_standard_deviation]

UCI_HAR_data <- cbind(X_data_mean_std, Y_data, Subject_data) 
```


## Requirement 3:
Uses descriptive activity names to name the activities in the data set

The required coloumn is converted to factors and levels are renamed.

```r
UCI_HAR_data[,"Activity_ID"] <- factor(UCI_HAR_data[,"Activity_ID"])
activity_names <- read.table('activity_labels.txt')
levels(UCI_HAR_data[,"Activity_ID"]) <- activity_names[,2]
#colnames(Y_activities) <- "Activity_ID"
```


## Requirement 4: 
Appropriate labels are provided for the data set with descriptive variable names. 

The column names are checked against series of regexes to make the names of dataset more understandable.

```r
change_colNames <- colnames(UCI_HAR_data)
colnames(UCI_HAR_data) <- sapply(change_colNames, 
function(x){
  x <- gsub("\\()","",x)
  x <- gsub("^(t)","Time",x)
  x <- gsub("^(f)","Freq",x)
  x <- gsub("-mean","Mean",x)
  x <- gsub("-std$","StdDev",x)
  x <- gsub("([Gg]ravity)","Gravity",x)
  x <- gsub("[Gg]yro","Gyro",x)
  x <- gsub("AccMag","AccMagnitude",x)
  x <- gsub("JerkMag","JerkMagnitude",x)
  x <- gsub("GyroMag","GyroMagnitude",x)
  x <- gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",x)
  x <- gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",x)
})
```


## Requirement 5: 
From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

ddply of plyr package is used to melt and cast the data set according to the requirement.

```r
UCI_HAR_data_avg <- ddply(UCI_HAR_data, .(Activity_ID,Subject_ID), function(x) colMeans(x[, 1:66]))
write.table(UCI_HAR_data_avg, "UCI_HAR_data_Avg.txt", row.names = FALSE, quote = FALSE)
```



