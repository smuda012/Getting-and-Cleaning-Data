###NOTE:
##In order to run the script, all datasets must be in your working directory
##Please see the readme file for additional information
############################################################################

#read in test data
xtest<- read.table("X_test.txt")
ytest<- read.table("y_test.txt")
subjecttest<- read.table("subject_test.txt")

#read in train data
xtrain<- read.table("X_train.txt")
ytrain<- read.table("y_train.txt")
subject<- read.table("subject_train.txt")

#combine individual data sets
Subject <- rbind(subject, subjecttest)
Activity<- rbind(ytrain, ytest)
Features<- rbind(xtrain, xtest)

#Create descriptive names
names(Subject)<-c("subject")
names(Activity)<- c("activity")
FeaturesNames <- read.table(("features.txt"),head=FALSE)
names(Features)<- FeaturesNames$V2

#Combine individual data sets to master data set
combine <- cbind(Subject, Activity)
data <- cbind(combine, Features)

#Extract feature names that are calculating either the mean or standard deviation
#subset the data set based on the extracted names
onlyFeaturesNames<-FeaturesNames$V2[grep("-(mean|std)\\(\\)", FeaturesNames$V2)]
selectedNames<-c( "subject", "activity",as.character(onlyFeaturesNames))
library(dplyr)
data<-subset(data,select=selectedNames)

#Read in Activity labels and replace the original activity column with the descriptive names
Labels <- read.table("activity_labels.txt",header = FALSE)
Labels1<- inner_join(data, Labels, by = c("activity" = "V1"))[,68:69]
data<-mutate(data, activity = Labels1$V2)

#calculate the mean of each variable grouped by the activity and subject
m<-aggregate( data[,3:68], data[,1:2], FUN = mean )

#write text file with final tidy dataset
write.table(m, "tidy_data.txt", row.name=FALSE)
