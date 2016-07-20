

## 1. Load raw data from working directory into a common data table

tbl_features <- read.table("features.txt", sep = "",header = FALSE)
## Load training data
tbl_train_data <- read.table("train/X_train.txt", sep = "",header = FALSE, col.names = tbl_features$V2, check.names = FALSE)
tbl_train_activity <- read.table("train/y_train.txt", sep = "",header = FALSE, col.names = c("activity"))
tbl_train_subject <- read.table("train/subject_train.txt", sep = "",header = FALSE, col.names = c("subject"))
tbl_train <- cbind(tbl_train_subject,tbl_train_activity,tbl_train_data)
## Load test data
tbl_test_data <- read.table("test/X_test.txt", sep = "",header = FALSE, col.names = tbl_features$V2, check.names = FALSE)
tbl_test_activity <- read.table("test/y_test.txt", sep = "",header = FALSE, col.names = c("activity"))
tbl_test_subject <- read.table("test/subject_test.txt", sep = "",header = FALSE, col.names = c("subject"))
tbl_test <- cbind(tbl_test_subject,tbl_test_activity,tbl_test_data)
# Combine the training and test data
tbl_both <- rbind(tbl_train, tbl_test)

## 2. Extract the 'mean' and 'standard deviation' of each meansurement

columns_of_interest <- c(grep("mean\\(\\)|std\\(\\)", tbl_features$V2, value = TRUE), "subject", "activity")
tbl_mean_std <- tbl_both[,columns_of_interest]

## 3. Use descriptive activity names to name the activities in the data set
##    load lookup table from activity_labels.txt to remap the 'activity' label column
tbl_activity_lookup <- read.table("activity_labels.txt", sep = "",header = FALSE)
tbl_mean_std$activity <- tbl_activity_lookup$V2[tbl_mean_std$activity]

## 4. Appropriately labels the data set with descriptive variable names.
##    This was done when reading in the raw data

## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
library(reshape2)
tbl_melted <- melt(tbl_mean_std, id = c("subject","activity"))
tbl_out <- dcast(tbl_melted, subject + activity ~ variable, mean)
write.table(tbl_melted, file = "reshaped_data_project_output.txt", row.names =  FALSE)
