## 1. Merge the training and the test sets to create one data set.

# Read the data
features <- read.table('~/UCI HAR Dataset/features.txt')
activityLabel <- read.table('~/UCI HAR Dataset/activity_labels.txt')

subjectTrain <- read.table('~/UCI HAR Dataset/train/subject_train.txt')
xTrain <- read.table('~/UCI HAR Dataset/train/x_train.txt')
yTrain <- read.table('~/UCI HAR Dataset/train/y_train.txt')

subjectTest <- read.table('~/UCI HAR Dataset/test/subject_test.txt')
xTest <- read.table('~/UCI HAR Dataset/test/x_test.txt')
yTest <- read.table('~/UCI HAR Dataset/test/y_test.txt')

# Name the columes
colnames(activityLabel) <- c('activityId','activity')
colnames(subjectTrain) <- "subjectId"
colnames(xTrain) <- features[,2]
colnames(yTrain) <- "activityId"
colnames(subjectTest) <- "subjectId"
colnames(xTest) <- features[,2]
colnames(yTest) <- "activityId"

# Merge the training sets
trainData <- cbind(yTrain,subjectTrain,xTrain)

# Merge the test sets
testData <- cbind(yTest,subjectTest,xTest)

# Merge the training and the test sets to create one data set.
MergeData <- rbind(trainData,testData)

## 2. Extract only the measurements on the mean and standard deviation for each measurement. 

colNames  <- colnames(MergeData)
logicalVector <- (grepl("activity..",colNames) | grepl("subject..",colNames) | 
                      grepl("-mean..",colNames) & !grepl("-meanFreq..",colNames) & 
                      !grepl("mean..-",colNames) | grepl("-std..",colNames) & 
                      !grepl("-std()..-",colNames))
ExtractData <- MergeData[logicalVector==TRUE]

## 3. Use descriptive activity names to name the activities in the data set

ExtractData <- merge(ExtractData,activityLabel)

## 4. Appropriately label the data set with descriptive activity names. 

colNames <- colnames(ExtractData)

for (i in 1:length(colNames)) 
{
    colNames[i] <- gsub("\\()","",colNames[i])
    colNames[i] <- gsub("-std$","StDv",colNames[i])
    colNames[i] <- gsub("-mean","Mean",colNames[i])
    colNames[i] <- gsub("^(t)","Time",colNames[i])
    colNames[i] <- gsub("^(f)","Frequency",colNames[i])
    colNames[i] <- gsub("([Gg]ravity)","Gravity",colNames[i])
    colNames[i] <- gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colNames[i])
    colNames[i] <- gsub("[Gg]yro","Gyro",colNames[i])
    colNames[i] <- gsub("AccMag","AccelerationMagnitude",colNames[i])
    colNames[i] <- gsub("([Bb]odyaccjerkmag)","BodyAccelerationJerkMagnitude",colNames[i])
    colNames[i] <- gsub("JerkMag","JerkMagnitude",colNames[i])
    colNames[i] <- gsub("GyroMag","GyroMagnitude",colNames[i])
}

colnames(ExtractData) <- colNames

## 5. Create a second, independent tidy data set with the average of each variable 
## for each activity and each subject. 

MData  <- ExtractData[,names(ExtractData) != 'activity']
Data5 <- aggregate(MData[,names(MData) != c('activityId','subjectId')],
                        by=list(activityId=MData$activityId,subjectId=MData$subjectId),FUN = mean)
tidyData <- merge(Data5,activityLabel)
write.table(tidyData, './tidyData.txt',row.names=FALSE,sep='\t')