# Code Book

This code book summarizes the resulting data fields in UCI_HAR_data_Avg(.txt) file.

## Identifiers

* Subject_ID  - The ID of the test subject
* Activity_ID - The type of activity performed when the corresponding measurements were taken


## Measurements

* TimeBodyAccMean-X
* TimeBodyAccMean-Y
* TimeBodyAccMean-Z
* TimeBodyAcc-std-X
* TimeBodyAcc-std-Y
* TimeBodyAcc-std-Z
* TimeGravityAccMean-X
* TimeGravityAccMean-Y
* TimeGravityAccMean-Z
* TimeGravityAcc-std-X
* TimeGravityAcc-std-Y
* TimeGravityAcc-std-Z
* TimeBodyAccJerkMean-X
* TimeBodyAccJerkMean-Y
* TimeBodyAccJerkMean-Z
* TimeBodyAccJerk-std-X
* TimeBodyAccJerk-std-Y
* TimeBodyAccJerk-std-Z
* TimeBodyGyroMean-X
* TimeBodyGyroMean-Y
* TimeBodyGyroMean-Z
* TimeBodyGyro-std-X
* TimeBodyGyro-std-Y
* TimeBodyGyro-std-Z
* TimeBodyGyroJerkMean-X
* TimeBodyGyroJerkMean-Y
* TimeBodyGyroJerkMean-Z
* TimeBodyGyroJerk-std-X
* TimeBodyGyroJerk-std-Y
* TimeBodyGyroJerk-std-Z
* TimeBodyAccMagnitudeMean
* TimeBodyAccMagnitudeStdDev
* TimeGravityAccMagnitudeMean
* TimeGravityAccMagnitudeStdDev
* TimeBodyAccJerkMagnitudeMean
* TimeBodyAccJerkMagnitudeStdDev
* TimeBodyGyroMagnitudeMean
* TimeBodyGyroMagnitudeStdDev
* TimeBodyGyroJerkMagnitudeMean
* TimeBodyGyroJerkMagnitudeStdDev
* FreqBodyAccMean-X
* FreqBodyAccMean-Y
* FreqBodyAccMean-Z
* FreqBodyAcc-std-X
* FreqBodyAcc-std-Y
* FreqBodyAcc-std-Z
* FreqBodyAccJerkMean-X
* FreqBodyAccJerkMean-Y
* FreqBodyAccJerkMean-Z
* FreqBodyAccJerk-std-X
* FreqBodyAccJerk-std-Y
* FreqBodyAccJerk-std-Z
* FreqBodyGyroMean-X
* FreqBodyGyroMean-Y
* FreqBodyGyroMean-Z
* FreqBodyGyro-std-X
* FreqBodyGyro-std-Y
* FreqBodyGyro-std-Z
* FreqBodyAccMagnitudeMean
* FreqBodyAccMagnitudeStdDev
* FreqBodyAccJerkMagnitudeMean
* FreqBodyAccJerkMagnitudeStdDev
* FreqBodyGyroMagnitudeMean
* FreqBodyGyroMagnitudeStdDev
* FreqBodyGyroJerkMagnitudeMean
* FreqBodyGyroJerkMagnitudeStdDev

## Transformations used to arrive at the dataset *UCI_HAR_data_Avg*

* x_train, y_train, subject_train contain the data from the */train folder* in UCI HAR Dataset folder.
* x_test, y_test, subject_test contain the data from the */test folder* in UCI HAR Dataset folder.
* X_data, Y_data and Subject_data are those data sets obtained by row wise merging the test and train sets of each x, y and subject sets.
  These data sets are the combined on column wise to get UCI_HAR_data [Requirement 1].
* The columns are renamed by taking help of *features.txt* file.
* Columns having only mean and standard deviations are then subsetted from the X to yield X_data_mean_std which is then merged with Subject ID 	 and Activity_ID data frame.This data set over-writes the old UCI_HAR_data.[Requirement 2]
* Activity type i.e the Y_data is then converted into factor type and levels are renamed using *activity_labels.txt*.
  This conversion is done  in-place i.e change is reflected in UCI_HAR_data[,'Activity_ID'].[Requirement 3]
* The column names are checked against series of regexes and converted to make the names of dataset more understandable.[Requirement 4]
* Finally, UCI_HAR_data_avg contains the relevant averages which will be later stored in a *UCI_HAR_data_Avg.txt* file as instructed (tab separated text file).ddply() from the plyr package is used to apply colMeans() for easy calculation.

### Additional Information
* [The source data for this project can be found here.](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
* [A full description of the data used in this project can be found at The UCI Machine Learning Repository.](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
* README.md file provides details on how all of the scripts work and how they are connected. 





