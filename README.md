# datasciencecoursera
#This will be github area, where I will keep working code and examples.
Unzip the source (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) into a folder on your local drive, say C:\Users\yourname\Documents\R\

Put run_analysis.R into C:\Users\yourname\Documents\R\UCI HAR Dataset\

In RStudio: I did not change the working director but instead prefixed the files with the following ./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset directory as unzipping created this structure and i did not want to change my wd.

Use data <- read.table("data_set_with_the_averages.txt") to read the data. It is 180x68 because there are 30 subjects and 6 activities, thus "for each activity and each subject" means 30 * 6 = 180 rows. Note that the provided R script has no assumptions on numbers of records, only on locations of files.
