# The following is a script for reading in test and training data sets for activity measurements
# For 30 subjects, 6 activities and 561 features measured for each activity and subject
# The script labels all activities, subjects and features.  The script merges the training and 
# test data sets.  The script subsets the merged data to include only those feature measures that
# are averages or standard deviations.  Finally, the script takes the average of each average or 
# standard deviation feature measure by subject and activity combination (i.e. it groups the data
# by subject and activity so that we see average measures for each subject and activity for the 
# subset of measurements (features) that are standard deviations or averages.
# There is an accompanying Readme file that describes the steps in detail, as well as a code book
# that translates names into logical meaning.

library(downloader) # Load the downloader library
library(car) # Load the car library so that we can later summarize the data
dir <- "C:/Users/rhuntsman/Desktop/Coursera/Getting and Cleaning Data/Final Project"
setwd(dir)

# Set location of activity data files and download data from web
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download(fileURL,dest="activity_data.zip")

# Unzip contents of activity data and extract to a data folder
unzip ("activity_data.zip", exdir = "./data")

# Create raw training and test data sets
train <- read.table("./data/UCI HAR Dataset/train/X_train.txt",sep="")
test <- read.table("./data/UCI HAR Dataset/test/X_test.txt",sep="")

# Add names to training and test feature columns
feature_labels <- t(read.table("./data/UCI HAR Dataset/features.txt"))[2,]
names(train) <- feature_labels
names(test) <- feature_labels

# Add subject and activity columns to train and test files
train_subjects <- read.table("./data/UCI HAR Dataset/train/subject_train.txt",sep="")
test_subjects <- read.table("./data/UCI HAR Dataset/test/subject_test.txt",sep="")
train_activity <- read.table("./data/UCI HAR Dataset/train/y_train.txt",sep="")
test_activity <- read.table("./data/UCI HAR Dataset/test/y_test.txt",sep="")
names(train_subjects) <- "subject" # Retrieve subject names/numbers for the training set 
names(test_subjects) <- "subject" # Retrieve subject names/numbers for the test set
names(train_activity) <- "activity" # Retrieve activity names/numbers for the training set
names(test_activity) <- "activity"  # Retrieve activity names/numbers for the test set
train <- cbind(train,train_subjects,train_activity) # Add the subject and activity names to the training data
test <- cbind(test,test_subjects,test_activity) # Add the subject and activity names to the test data

# Merge training and test data sets
merged <- rbind(train,test)

# Eliminate all of the feature/data columns except those with mean or std in name
reduced_df <- merged[,grep("Mean|MEAN|mean|std|STD|Std|subject|activity",names(merged))]

a <- reduced_df
# recode activity to translate each number into an actual name
a$activity <- recode(a$activity,"1='WALKING';2='WALKING_UPSTAIRS';3='WALKING_DOWNSTAIRS';4='SITTING';5='STANDING';6='LAYING'")

# Aggregate the data.  Take the average of each measurement (86 in all) for each Subject and Activity combination
aggregated_df <- aggregate(a[1:86],by=list(a$subject,a$activity),mean)

# Label the two groups by which we are averaging all of the measurements: Subject and Activity
names(aggregated_df)[1] = "Subject"
names(aggregated_df)[2] = "Activity"

# Finally, create an output file with the summarized data
write.table(aggregated_df,"SummaryActivityDataBySubject.txt", row.labels = FALSE)
