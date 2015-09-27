---
title: "Getting and Cleaning Data Class Project"
#author: "Gail Gutowski"
#date: "September 27, 2015"
#output: html_document
---
 
Raw data
---

This project is based on a raw dataset of accelerometer measurements recorded from 30 volunteers performing 6 physical activities each. The data is randomly partititioned into a training dataset (70%) and a test dataset (30%). It can be downloaded from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. 

The zip file contains:  

1. Directory **train** which contains the following files used in this analysis:
- File X_train.txt  
- File subject_train.txt  
- File y_train.txt  

2. Directory **test**  
- Comparable files to those in **train** for the remaining 30% of the collected data.  

3. File activity_labels.txt which has the name of each physical activity.  

4. File features.txt which has a vector of the 561 features with time and frequency domain variables  

5. File features_info.txt which has more information about the features. 

6. File README.txt which has more detailed information about the contents of each file and the experiment.    


## Analysis
- This analysis performs the following:  

1. Merges the training and the test sets to create one data set.  
2. Extracts only the measurements on the mean and standard deviation for each measurement.   
3. Uses descriptive activity names to name the activities in the data set   
4. Appropriately labels the data set with descriptive variable names.   
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.  

- To repeat the analysis:  

1. Download the data from the link above.
2. Unzip the downloaded data.
3. Put the run_analysis.R script in the same directory as the data.
4. Execute the run_analysis.R script.


## Tidy Datasets

The first resulting tidy dataset is a merged file of the training and test datasets which includes only the mean and standard deviation of ecah measurement. Descriptive labels are correctly applied to the tidy data.
