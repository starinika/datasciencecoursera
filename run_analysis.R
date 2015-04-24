##First thing .. read the data
## training and test data sets are split up into subject, activity and features. 
##They are present in three different files.

##a. Metadata loading/reading
featureNames <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/features.txt")
activityLabels <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt", header = FALSE)

##b. read training data
subjectTrain <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt", header = FALSE)
activityTrain <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt", header = FALSE)
featuresTrain <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt", header = FALSE)

##c. Read test data
subjectTest <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt", header = FALSE)
activityTest <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt", header = FALSE)
featuresTest <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt", header = FALSE)

##Now that training and testt data have been read, try and merge them.. reality!!!!
## Part 1
##1.Merges the training and the test sets to create one data set.  typo error.. should be merge 
subject <- rbind(subjectTrain, subjectTest)
activity <- rbind(activityTrain, activityTest)
features <- rbind(featuresTrain, featuresTest)


###The columns in the features data set can be named from the metadata in featureNames
colnames(features) <- t(featureNames[2])

##The data in features,activity and subject are merged and the complete data is now stored in allMyData
colnames(activity) <- "Activity"
colnames(subject) <- "Subject"
allMyData <- cbind(features,activity,subject)

##end of Part 1

##Part 2: the script Extracts only the measurements on the mean and standard deviation for each measurement. 
##2a. extract the column indices that have either mean or standard deviation in them.
columnsWithMeanSTD <- grep(".*Mean.*|.*Std.*", names(allMyData), ignore.case=TRUE)

##2b:add activity and subject columns to the list and look at the dimension of allMyData
requiredColumns <- c(columnsWithMeanSTD, 562, 563)
dim(allMyData)

##2c: lets create extractedData with the selected columns from above  and then look at the dimensions
extractedData <- allMyData[,requiredColumns]
dim(extractedData)

## [1] 10299    88..values look ok..and match from the previous one..
## good sign.. we are in business.

###end of Part 2
##begining the 3rd part
##Uses descriptive activity names to name the activities in the data set

##Activity field in extractedData is of numeric type. 
##lets change its type to character so that it can accept activity names. 
##P.S: Activity names are taken from metadata activityLabels.

extractedData$Activity <- as.character(extractedData$Activity)
for (i in 1:6){
  extractedData$Activity[extractedData$Activity == i] <- as.character(activityLabels[i,2])
}
##Now let me factor the activity variable, now that the activity names are updated.

extractedData$Activity <- as.factor(extractedData$Activity)

####ha ha ha .. end of 3rd part

##Part 4; Appropriately labels the data set with descriptive variable names. 
##have no clue what this means..hmm let me examine the variables

names(extractedData)

##adding the results (only a few shown here .. the list is too damn long.. donot want to increase the size of the file)
##  [1] "tBodyAcc-mean()-X"                   
##  [2] "tBodyAcc-mean()-Y"                   
##  [3] "tBodyAcc-mean()-Z"
##  [8] "tGravityAcc-mean()-Y"                
##  [9] "tGravityAcc-mean()-Z"                
## [10] "tGravityAcc-std()-X"  etc etc blah blah
## now simply replace the names with accurate names...

names(extractedData)<-gsub("Acc", "Accelerometer", names(extractedData))
names(extractedData)<-gsub("Gyro", "Gyroscope", names(extractedData))
names(extractedData)<-gsub("BodyBody", "Body", names(extractedData))
names(extractedData)<-gsub("Mag", "Magnitude", names(extractedData))
names(extractedData)<-gsub("^t", "Time", names(extractedData))
names(extractedData)<-gsub("^f", "Frequency", names(extractedData))
names(extractedData)<-gsub("tBody", "TimeBody", names(extractedData))
names(extractedData)<-gsub("-mean()", "Mean", names(extractedData), ignore.case = TRUE)
names(extractedData)<-gsub("-std()", "STD", names(extractedData), ignore.case = TRUE)
names(extractedData)<-gsub("-freq()", "Frequency", names(extractedData), ignore.case = TRUE)
names(extractedData)<-gsub("angle", "Angle", names(extractedData))
names(extractedData)<-gsub("gravity", "Gravity", names(extractedData))

###now check results again..
names(extractedData)
###looks good..
##set Subject as a factor variable.

extractedData$Subject <- as.factor(extractedData$Subject)
extractedData <- data.table(extractedData)
##create tidyData as a data set with average for each activity and subject. Then, we order the enties in tidyData and write it into data file Tidy.txt that contains the processed data.

tidyData <- aggregate(. ~Subject + Activity, extractedData, mean)
tidyData <- tidyData[order(tidyData$Subject,tidyData$Activity),]
write.table(tidyData, file = "Tidy.txt", row.names = FALSE)

