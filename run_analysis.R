#=======================================================================================================================
# FUNCTION: This script will create an 'average of averages' dataset for the data stored in the 'Human Activity Recognition' dataset.
#       Data source can be found at the following URL: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
#       Data reference can be found at: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
# REQUIREMENTS
#     1) Ensure the extracted 'human activity' data is extracted from the ZIP file and stored in folder "UCI HAR DATASET" as specified in the zip file.
#     2) This script makes use of the following libraries. Ensure the packages are available prior to running this script.
#         - data.table
#         - dplyr
#         - plyr
# OUTPUT
#     1) The resulting table can be found in table variable 'testSetAveragesTable'.
#     ) The resulting table will be written to a text file and stored in the same folder as the 'UCI HAR DATASET' folder. 
#        File name will be testSetAverages.txt 
#=======================================================================================================================

library(data.table)
library(plyr)
library(dplyr)

currentWD <- getwd()
setwd("UCI HAR DATASET")
#=======================================================================================================================
# Retrieve the data sets. 
#=======================================================================================================================
print("Retrieving Initial Feature and Activity Data Sets...")
featuresNames <- read.table("features.txt")
activityNameTable <- read.table("activity_labels.txt")

print("Retrieving Train Data Sets...")
TrainSubjectTable <- read.table("train/subject_train.txt")
xTrainVariablesData <- read.table("train/X_train.txt")
yTrainActivityIDData <- read.table("train/y_train.txt")

print("Retrieving Test Data Sets...")
TestSubjectTable <- read.table("test/subject_test.txt")
xTestVariablesData <- read.table("test/X_test.txt")
yTestActivityIDData <- read.table("test/y_test.txt")

#=======================================================================================================================
# Build a vector that holds the proper column labels. The test variables are held in the 'featuresnames' dataset
#=======================================================================================================================
tNames <- featuresNames$V2
frameColLabels <- c("ActivityID", "StudentID", as.vector(tNames))

print("Consolidating Test and Training Data Sets...")

#=======================================================================================================================
# Combine the disjointed data into one dataset. 
#=======================================================================================================================
#Now Get the training data in the proper column order
trainFrame <- cbind(yTrainActivityIDData, TrainSubjectTable, xTrainVariablesData)

#Now Get the testing data in the proper column order
testFrame <- cbind(yTestActivityIDData, TestSubjectTable, xTestVariablesData)

#Combine the two datasets
fullTestFrame <- rbind(trainFrame, testFrame)

#=======================================================================================================================
# Add column labels to the consolidated dataset and append the activity name to the dataset
#=======================================================================================================================
print("Adding Labels and Activity Information to the Consolidated Data Set...")
#Assign the frameColLabels to the dataset as row names.
tempFrame <- setNames(fullTestFrame, frameColLabels)

#Apply labels to the 'Activity' dataset so that we can get the actual activity names and append them to the testset table.
labeledActivityNameTable <- setnames(activityNameTable,c("ActivityID", "ActivityName"))

#Use inner_join to add the activity name to each row in the test set table
fullTestSetTable <- inner_join(tempFrame, labeledActivityNameTable, by = c("ActivityID" = "ActivityID"))

#Remove duplicated columns. This step is necessary because the 'select' command detects that some columns may have duplicate names.
tempFrame <- fullTestSetTable[,!duplicated(colnames(fullTestSetTable))]

#=======================================================================================================================
# Extract the averages (the 'mean()') and standard deviation (the 'std()) variables into a separate dataset. 
# Use this information to create the summarized table
#=======================================================================================================================
print("Extracting test mean and standard deviation data...")
#Select only means and standard deviation rows
testSetMeansAndStandardsTable <- select(tempFrame,
                      ActivityName,
                      StudentID,
                      `tBodyAccMag-mean()`,
                      `tBodyAccMag-std()`,
                      
                      `tGravityAccMag-mean()`,
                      `tGravityAccMag-std()`,
                      
                      `tBodyAccJerkMag-mean()`,
                      `tBodyAccJerkMag-std()`,
                      
                      `tBodyGyroMag-mean()`,
                      `tBodyGyroMag-std()`,
                      
                      `tBodyGyroJerkMag-mean()`,
                      `tBodyGyroJerkMag-std()`,
                      
                      `fBodyAccMag-mean()`,
                      `fBodyAccMag-std()`,
                      
                      `fBodyBodyAccJerkMag-mean()`,
                      `fBodyBodyAccJerkMag-std()`,
                      
                      `fBodyBodyGyroMag-mean()`,
                      `fBodyBodyGyroMag-std()`,
                      
                      `fBodyBodyGyroJerkMag-mean()`,
                      `fBodyBodyGyroJerkMag-std()`)

#=======================================================================================================================
# Summarize the average of each variable, group by the student Id and activity name
#=======================================================================================================================
print("Determining Averages Per Student and Activity...")
#Now create a table that performs the desired averages, grouped be sutdent ID and activity
testSetAveragesTable <- ddply(testSetMeansAndStandardsTable,.(StudentID, ActivityName), summarize, 
                  Average.tBodyAccMagMean = mean(`tBodyAccMag-mean()`),
                  Average.tBodyAccMagStd = mean(`tBodyAccMag-std()`), 
                  
                  Average.tGravityAccMagMean = mean(`tGravityAccMag-mean()`), 
                  Average.tGravityAccMagStd = mean(`tGravityAccMag-std()`), 
                  
                  Average.tAccJerkMagMean = mean(`tBodyAccJerkMag-mean()`), 
                  Average.tAccJerkMagStd = mean(`tBodyAccJerkMag-std()`), 
                  
                  Average.tBodyGyroMagMean = mean(`tBodyGyroMag-mean()`), 
                  Average.tBodyGyroMagStd = mean(`tBodyGyroMag-std()`), 
                  
                  Average.tBodyGyroJerkMagMean = mean(`tBodyGyroJerkMag-mean()`), 
                  Average.tBodyGyroJerkMagStd = mean(`tBodyGyroJerkMag-std()`),  
                  
                  Average.fBodyAccMagMean = mean(`fBodyAccMag-mean()`), 
                  Average.fBodyAccMagStd = mean(`fBodyAccMag-std()`), 
                  
                  Average.fBodyAccJerkMagMean = mean(`fBodyBodyAccJerkMag-mean()`), 
                  Average.fBodyAccJerkMagStd = mean(`fBodyBodyAccJerkMag-std()`), 
                  
                  Average.fBodyGyroMagMean = mean(`fBodyBodyGyroMag-mean()`), 
                  Average.fBodyGyroMagStd = mean(`fBodyBodyGyroMag-std()`), 
                  
                  Average.fBodyGyroJerkMagMean = mean(`fBodyBodyGyroJerkMag-mean()`), 
                  Average.fBodyGyroJerkMagStd = mean(`fBodyBodyGyroJerkMag-std()`))

#=======================================================================================================================
# Save the 'average' data set to file and clean up.
#=======================================================================================================================
print("Finished Calculation. Writing Data to File.")
#Save the 'averages' data to a file
write.table(testSetAveragesTable, file = "../testSetAverages.txt", row.names = FALSE)

#Reset the working directory
setwd(currentWD)
print("Process Complete. Student/Activity Average DataSet Can Be Found in testSetAverages.txt")