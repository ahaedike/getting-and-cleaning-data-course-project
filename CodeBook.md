
# Codebook:  Getting and Cleaning Data Course Project
### Student:  Art Haedike
---

The source data was generated from experiments carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz was captured. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope.
- A 561-feature vector with time and frequency domain variables.
- Its activity label.
- An identifier of the subject who carried out the experiment.

The original dataset includes the following files:
=========================================

- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent.

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis.

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration.

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.

## Data Transformations Performed
---
1. Load raw data from working directory into a common data frame
  * For the **training** data, combine (column bind) data ("train/X_train.txt"), activity ("train/y_train.txt"), and subject ("train/subject_train.txt") into one data frame.
  * For the **test** data, combine (column bind) data ("train/X_test.txt"), activity ("train/y_test.txt"), and subject ("train/subject_test.txt") into one data frame.
  * Combine (row bind) the training and test data frames into one data frame.
2. Extract the 'mean' and 'standard deviation' columns using a **regex** match of all variable names containing **mean()** or **std()**
3. The same variable names were kept from the original data sets because they are already descriptive.  
  * The **codebook** of variable definitions can be found in the original data set file **features.txt** and **features_info.txt**.
  * For example: **'tBodyAcc-std()-X'** is the variable containing the standard deviation in the X axis for the accelerometer measurement.
  * For example: **'tBodyAcc-mean()-Z'** is the variable containing the mean in the Z axis for the accelerometer measurement.
  * This convention is consistent for all variables.
4. Use descriptive activity names to name the activities in the data set.  
  *  Replace the integer 'activity' values with textual descriptions from "activity_labels.txt" in the original data set.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  * **melt** and **dcast** were used to reshape the data
6.  Output the new tidy data set using 'write.table'

## Codebook of resulting columns
---
The resulting tidy data set contains four columns:
1.  "subject":  Test test subject performing the activity.
2.  "activity": Textual description of the activity performed at time of measurement.
3.  "variable":  The name of the original measurement
4.  "value":  The mean of the mean or standard deviation for the variable.
