
Source of the original data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Original description: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

1. Basic Assumption:
The R code in run_analysis.R proceeds under the assumption that the zip file available at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip is downloaded and extracted in the R Home Directory. 

1a: Since the home directory is different from the director this project is set to, instead of doing a setwd(), I used "./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset" as a prefix to all the files.

2. Libraries Used:
The libraries used in this operation are data.table and dplyr. We prefer data.table as it is efficient in handling large data as tables. dplyr is used to aggregate variables to create the tidy data.

3.Read Supporting Metadata
The supporting metadata in this data are the name of the features and the name of the activities. They are loaded into variables featureNames and activityLabels.

4.Format training and test data sets
Both training and test data sets are split up into subject, activity and features. They are present in three different files.

5. Read training data: variables used: SubjectTrain, activytrain, featurestrain
6. Read test data: subjecttext, activitytext, featurestext

7. Part 1 - Merge the training and the test sets to create one data set
We can use combine the respective data in training and test data sets corresponding to subject, activity and features. The results are stored in subject, activity and features.

8.Naming the columns
The columns in the features data set can be named from the metadata in featureNames

9.Merge the data
The data in features,activity and subject are merged and the complete data is now stored in allMyData.

10.Part 2 - Extracts only the measurements on the mean and standard deviation for each measurement
 * Extract the column indices that have either mean or std in them.
 * Add activity and subject columns to the list and look at the dimension of allMyData
 * We create extractedData with the selected columns in requiredColumns. And again, we look at the dimension of requiredColumns.
 * validate

11.Part 3 - Uses descriptive activity names to name the activities in the data set
  * The activity field in extractedData is originally of numeric type. 
  * We need to change its type to character so that it can accept activity names. 
  * The activity names are taken from metadata activityLabels.
  * factor the activity variable, once the activity names are updated.
  * 
12.Part 4 - Appropriately labels the data set with descriptive variable names
  * Here are the names of the variables in extractedData
  * names(extractedData)
  * change/replace with appropriate names
  * names(extractedData) will validate the results.
13 Part 5 - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
  * Firstly, let us set Subject as a factor variable. 
  * create tidyData as a data set with average for each activity and subject. 
  * Now order the enties in tidyData and write it into data file Tidy.txt that contains the processed data.
  * 
  Ta da.....
  
