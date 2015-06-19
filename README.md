# Getting and Cleaning Data Course Project

###Overview
From the course assignment page:  
<https://class.coursera.org/getdata-015/human_grading/view/courses/973502/assessments/3/submissions>
  

You should create one R script called run_analysis.R that does the following:  
* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement. 
* Uses descriptive activity names to name the activities in the data set.
* Appropriately labels the data set with descriptive variable names. 
* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

###Data Sources 
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


###Understanding the Data
The data is based on exeriments that have been carried out with a group of 30 volunteers. Each volunteer performed six activities while wearing a smartphone on their waist

###Output

