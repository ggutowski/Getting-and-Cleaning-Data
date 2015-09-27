## Create one R script called run_analysis.R that does the following:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive activity names.
## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

setwd("~/Documents/Courses/NONUT/DataSci/Getting_Cleaning_data/CourseProject/UCI\ HAR\ Dataset")

###
# 1. Merge training and test sets to create one data set
###

#Read in training dataset
train <- read.table("train/X_train.txt")
train[,length(train)+1] <- read.table("train/y_train.txt")
train[,length(train)+1] <- read.table("train/subject_train.txt")

#Read in test dataset
test <- read.table("test/X_test.txt")
test[,length(test)+1] <- read.table("test/y_test.txt")
test[,length(test)+1] <- read.table("test/subject_test.txt")

# Read in activity labels
labels <- read.table("activity_labels.txt")

# Read in feature data and relabel
features <- read.table("features.txt")[,2]
features[,2] = gsub('-mean', 'Mean', features[,2])
features[,2] = gsub('-std', 'Std', features[,2])
features[,2] = gsub('[-()]', '', features[,2])

# Merge training and test sets 
merged_traintest = rbind(train, test)


###
# 2. Extract only the measurements on the mean and standard deviation for each measurement
###
# Pick out mean and std columns
meanstdcols <- grep(".*Mean.*|.*Std.*", features[,2])
features <- features[meanstdcols,]
# Append subject and activity in the last columns
meanstdcols <- c(meanstdcols, 562, 563)
# Take only the mean and std cols from the merged data
merged_traintest <- merged_traintest[,meanstdcols]
# Add feature labels
colnames(merged_traintest) <- c(features$V2, "Activity", "Subject")
colnames(merged_traintest) <- tolower(colnames(merged_traintest))

###
# 3. & 4. Label the data with descriptive activities.
###

action = 1
for (eachlabel in labels$V2) {
  merged_traintest$activity <- gsub(action, eachlabel, merged_traintest$activity)
  action <- action + 1
}

merged_traintest$activity <- as.factor(merged_traintest$activity)
merged_traintest$subject <- as.factor(merged_traintest$subject)


###
# 5. Create a tidy data file
###
tidy = aggregate(merged_traintest, by=list(activity = merged_traintest$activity, subject=merged_traintest$subject), mean)
# Remove the subject and activity column, since a mean of those has no use
tidy[,90] = NULL
tidy[,89] = NULL
write.table(tidy, "tidy.txt", sep="\t")