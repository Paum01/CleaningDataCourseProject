<h1>Data Source</h1>
The input data represents testing performed by Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto and Xavier Parra. The intent of this script is to summarize that team’s research data and extract the averages for each test’s mean and standard deviation on a per student, per activity basis. 

The raw data source (Data used to create the output file) can be found at the following URL: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Detailed information about the raw data can be found at: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

<h1>Output</h1>
The program creates a data table that holds the following variables. The data will also be stored in file named ‘testSetAverages.txt’, stored in the same folder as holds the original raw data’s storage folder.
The output file contains summary data for the following fields:

<b>Student ID</b>: Student ID of the student who conducted the test. Initial data found in subject_train and subject_test data sets and linked to the test sets by ordinal position within the data sets.

<b>Activity Name</b>: Actual name of the activity. Derived from the Activity_Labels.txt dataset, matched to the ‘activity_ID’ field in the y_test and y_train datasets (these datasets specified the activity ID that was performed during the tests).

<b>Summary Fields</b>: The following variables are averages of their root variables that are similar by the suffix of these field names. The averages are calculated on a per-student, per activity basis:
<ul>
<li>Average.tBodyAccMagMean
<li>Average.tBodyAccMagStd
<li>Average.tGravityAccMagMean
<li>Average.tGravityAccMagStd
<li>Average.tAccJerkMagMean
<li>Average.tAccJerkMagStd
<li>Average.tBodyGyroMagMean
<li>Average.tBodyGyroMagStd
<li>Average.tBodyGyroJerkMagMean
<li>Average.tBodyGyroJerkMagStd
<li>Average.fBodyAccMagMean
<li>Average.fBodyAccMagStd
<li>Average.fBodyAccJerkMagMean
<li>Average.fBodyAccJerkMagStd
<li>Average.fBodyGyroMagMean
</ul>
