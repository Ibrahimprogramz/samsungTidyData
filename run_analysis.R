cleanData<-function()
{
  library(plyr)
  library(dplyr)
  library(utils)
  wd<-getwd()
  if(!file.exists("./GetCleanDataProject"))
    {dir.create(paste(wd,"GetCleanDataProject", sep= "/"), recursive = F)}
  setwd("./GetCleanDataProject")
  url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(url, "dataset.zip")
  unzip("./dataset.zip",overwrite = T) 
  testData<-read.table("./UCI HAR Dataset/test/X_test.txt")
  #(1) Merges the training and the test sets to create one data set.
  testFeatures<-read.table("./UCI HAR Dataset/features.txt")
  #()4 Appropriately labels the data set with descriptive variable names.<-most of the data modifications on the names of the variables are conducted to provide accurate and appropriate naming for variables
  names(testData)<-testFeatures$V2 #the column names are matched with data early in the script to guarantee accuracy of names Vs test data placement before data is manipulated
  meanStdColnum<-grep("mean()|std()", names(testData)) #select only col numbers that corresponds to the mean() and std() from the test data
  testDataMeanStd<-subset(testData,select=meanStdColnum) #creating a subset with only columns that have "mean()" or "std()" using the vector meanStdColnum
  #now bind the subjects and the activities into the dataset testDataMeanStd
  subjectsData<-read.table("./UCI HAR Dataset/test/subject_test.txt")
  activitiesData<-read.table("./UCI HAR Dataset/test/y_test.txt")
  names(subjectsData)="subject" #the names for the subject & activity columns are updated to match the rules of tidy data
  names(activitiesData)="activity"
  testDataMeanStd<-cbind(subject=subjectsData,activity=activitiesData,testDataMeanStd) #binding the columns
  
  
  #apply the same on training data. 
  #it should be noted that the test and train data changes and operations were done separately to assure that activates and subjects are accurately matched with each row/observation. After that both data will be merged using merge() function
  trainData<-read.table("./UCI HAR Dataset/train/X_train.txt")
  trainFeatures<-read.table("./UCI HAR Dataset/features.txt")
  #(4) Appropriately labels the data set with descriptive variable names.<-most of the data modifications on the names of the variables are conducted to provide accurate and appropriate naming for variables
  names(trainData)<-trainFeatures$V2 #the column names are matched with data early in the script to guarantee accuracy of names Vs test data placement before data is manipulated
  meanStdColnum<-grep("mean()|std()", names(trainData)) #select only col numbers that corresponds to the mean() and std() from the test data
  trainDataMeanStd<-subset(trainData,select=meanStdColnum) #creating a subset with only columns that have "mean()" or "std()" using the vector meanStdColnum
  #now bind the subjects and the activities into the dataset testDataMeanStd
  subjectsData<-read.table("./UCI HAR Dataset/train/subject_train.txt")
  activitiesData<-read.table("./UCI HAR Dataset/train/y_train.txt")
  names(subjectsData)="subject" #the names for the subject & activity columns are updated to match the rules of tidy data
  names(activitiesData)="activity"
  trainDataMeanStd<-cbind(subject=subjectsData,activity=activitiesData,trainDataMeanStd) #binding the columns
  
  
  #merging the modified test and training datasets into mergedData data frame
  mergedData<-rbind(testDataMeanStd, trainDataMeanStd)
  
  
  #(3) Uses descriptive activity names to name the activities in the data set
  mergedData$activity=mapvalues(mergedData$activity, from = c(1,2,3,4,5,6), to=c("Walking", "Walking Upstairs", "Walking Downstairs","Sitting","Standing", "Laying")) 
  #(4) Appropriately labels the data set with descriptive variable names.<-mergedData is created with the suitable variable names
  names(mergedData)<-gsub("-"," ",names(mergedData)) #satisfying the conditions for tidy variable naming by removing the "-" however, capital letters here were not reduced to small to keep the scientefic naming of the original dataset
  write.csv(mergedData, "mergedDataset.csv") #creating the merged and dataset
  
  #(5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  tidyDataGrouped<-group_by(mergedData, subject,activity) #grouping the new independent tidyDataGrouped by subject and activity 
  tidyData<-summarize_all(tidyDataGrouped,mean) #the final dataset is summarized into the average of each variable
  write.csv(tidyData, "tidyData.csv") #creating the tidy dataset
}
