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

#Read in training dataset and rename
X_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")

subject_train <- read.table("train/subject_train.txt")


#Read in test dataset
X_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")

subject_test <- read.table("test/subject_test.txt")


# Read in activity labels
labels <- read.table("activity_labels.txt")

# Read in feature data and rename
features <- read.table("features.txt")
names(X_train) <- features$V2
names(X_test) <- features$V2



# Merge training and test sets 
train <-cbind(subject_train,y_train,X_train)
test <- cbind(subject_test,y_test,X_test)
merged_traintest = rbind(train, test)
colnames(merged_traintest)[1] <- "Subject"
colnames(merged_traintest)[2] <- "Activity"

###
# 2. Extract only the measurements on the mean and standard deviation for each measurement
###

# Pick out mean and std columns
meanstdcols <- grepl("mean\\(\\)", names(merged_traintest)) | grepl("std\\(\\)", names(merged_traintest))

# Only keep cols of mean and std
meanstdcols[1:2] <- TRUE
merged_traintest<- merged_traintest[, meanstdcols]


###
# 3. & 4. Label the data with descriptive activities.
###

merged_traintest$Activity <- factor(merged_traintest$Activity, labels=c("Walking","Walking Upstairs","Walking Downstairs","Sitting","Standing", "Laying"))

###
# 5. Create a tidy txt file
###

melted <- melt(merged_traintest, id=c("Subject","Activity"))
tidy <- dcast(melted, Subject+Activity ~ variable, mean)

write.table(tidy, "tidy.txt", sep="\t")
