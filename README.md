# CleaningDataCourseProject
This repo holds the files needed for the Coursera Course Project for Course 'Getting and Cleaning Data'

This script will create an 'average of averages' dataset for the data stored in the 'Human Activity Recognition' dataset.
The original data source can be found at the following URL: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
The data reference and original code book for the raw data can be found at: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

To Use:
1)	Download the data from the aforementioned data source and extract it. The script expects the data to be available in the ‘UCI HAR DATASET’ folder which is defaulted in the zip file.
2)	Download the script entitled ‘run_analysis.R’ The script contains all of the steps necessary to process the data; you do not need to run additional scripts.
3)	NOTE: Ensure that you have the correct packages installed. The needed packages are specified at the top of the script. The script will load the packages for you.
4)	Output from the script will be stored in variable ‘testSetAveragesTable’ and stored in table format in file ‘testSetAverages.txt’

