# Getting and Cleaning Data Course Project

##Overview
The analysis is based on experiments that have been carried out with a group of 30 volunteers. Each volunteer performed six activities while wearing a smartphone on their waist. Using its embedded accelerometer and gyroscope, the experiment captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.  
  
A full description of the study can be found here:
<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>
##Objective
From the course assignment page:  
<https://class.coursera.org/getdata-015/human_grading/view/courses/973502/assessments/3/submissions>

You should create one R script called run_analysis.R that does the following:  
* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement. 
* Uses descriptive activity names to name the activities in the data set.
* Appropriately labels the data set with descriptive variable names. 
* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##Data Sources 
The data for this project is here:  
<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>  
The following files in the zip folder were used in the project and must be stored in your working directory for the run_analsis.R script to execute:  
* 'features.txt': List of all features.
* 'activity_labels.txt': Links the class labels with their activity name.
* 'train/X_train.txt': Training set.
* 'train/y_train.txt': Training labels.
* 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
* 'test/X_test.txt': Test set.
* 'test/y_test.txt': Test labels.
* 'train/subject_test.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.





##Process
1. Read in test data
2. Read in training data
3. Combine individual data sets
4. Create descriptive names
5. Combine individual data sets to master data set
6. Extract feature names that are calculating either the mean or standard deviation
7. Subset the data set based on the extracted names
8. Read in Activity labels and replace the original activity data with the descriptive activity names
9. Calculate the mean of each variable grouped by the activity and subject
10. Write text file with final tidy dataset


###Read in test data:
```
xtest<- read.table("X_test.txt")
ytest<- read.table("y_test.txt")
subjecttest<- read.table("subject_test.txt")
```
###Read in training data:
```
xtrain<- read.table("X_train.txt")
ytrain<- read.table("y_train.txt")
subject<- read.table("subject_train.txt")
```
###Combine test and training data for Subject, Activity and Features:
```
Subject <- rbind(subject, subjecttest)
Activity<- rbind(ytrain, ytest)
Features<- rbind(xtrain, xtest)
```
###Create descriptive names:
```
names(Subject)<-c("subject")
names(Activity)<- c("activity")
FeaturesNames <- read.table(("features.txt"),head=FALSE)
names(Features)<- FeaturesNames$V2
```
###Combine individual data sets to create a master data set:
```
combine <- cbind(Subject, Activity)
data <- cbind(combine, Features)
```
###Extract feature names that are calculating either the mean or standard deviation:
```
onlyFeaturesNames<-FeaturesNames$V2[grep("-(mean|std)\\(\\)", FeaturesNames$V2)]
selectedNames<-c( "subject", "activity",as.character(onlyFeaturesNames))
```
###Subset the data set based on the extracted names:
```
library(dplyr)
data<-subset(data,select=selectedNames)
```
###Read in Activity labels and replace the original activity data with the descriptive activity names:
```
Labels <- read.table("activity_labels.txt",header = FALSE)
Labels1<- inner_join(data, Labels, by = c("activity" = "V1"))[,68:69]
data<-mutate(data, activity = Labels1$V2)
```
###Calculate the mean of each variable grouped by the activity and subject:
```
tidy_data<-aggregate( data[,3:68], data[,1:2], FUN = mean)
```
###Write text file to working directory with final tidy dataset:
```
write.table(tidy_data, "tidy_data.txt", sep = ",", row.name=FALSE)
```
##Output
The final output is a tidy dataset that is stored as a .txt file in your working directory. Each measured variable is in one column and each different observation of that variable is in a different row.
