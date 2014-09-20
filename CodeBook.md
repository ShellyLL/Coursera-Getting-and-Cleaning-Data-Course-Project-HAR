This is part of Coursera Getting and Cleaning Data Course Week 3 Project.
This code book describes the variables, the data, and any transformations or work that was performed to getting and clean the data.
===================================================

Data Sourse: 

A full description is available at the site where the data was obtained: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The above dataset for the project includes the following files:
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
========================================================

In the R script called run_analysis.R, the followings were conducted to get and clean the data: 

1. Merge the training and the test sets to create one data set.
    Firstly, use "read.table" function to read the data files and store them in: features, activityLabel, subjectTrain, xTrain, yTrain, subjectTest, xTest and yTest. 
    Secondly, assign the colum names.
    Thirdly, merge the training and the test sets to create one data set called: MergeData.
    
2. Extract only the measurements on the mean and standard deviation for each measurement. 
    By using a colum name vector called colnames and logical vector, the measurements on the mean and standard deviation for each measurement were extracted in "ExtractData".
 
3. Use descriptive activity names to name the activities in the data set
    Merge the data obtained from step 2 with acivity label file to include the descriptive activity names.
    
4. Appropriately label the data set with descriptive variable names. 
    Use the gsub function to modify the variable names in the data set.

5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.
    Firstly, Use the aggregate function to export the statistics of the data set
    Secondly, Merge the statistics and activity label file to create tidy data.
    Thirdly, export the tidy data into txt format.
