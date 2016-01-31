## Load libraries used by thr R code
        print("Loading library data.table...")
                library(data.table)
        print("Loading library dplyr...")
                library(dplyr)
        print("Loading library plyr...")
                library(plyr)

## User needs to do the following:
##      1. Download source file
##      2. Unzip the downloaded file. It will unzip and create a folder: UCI HAR Dataset. 
##              It will have files with data that will be used by the script.
##      3. Set working directory to the location the folder: UCI HAR Dataset is located.

## Loading data
##      Read Metadata files
        print("Reading Feature file...")
                features <- read.table("features.txt")
        print("Reading Activity Labels file...")
                activityLabels <- read.table("activity_labels.txt")
                
##      Read Training Data files
        print("Reading Training Dataset file...")
                trainingData <- read.table("train/X_train.txt")
        print("Reading Training Data labels file...")
                trainingDataLabels <- read.table("train/y_train.txt")
        print("Reading Training subjects Data file...")
                trainingSubjectsData <- read.table("train/subject_train.txt")
                
##      Read Test Data files
        print("Reading Test Data files...")
                testData <- read.table("test/X_test.txt")     
        print("Reading Test Data Labels file...")
                testDataLabels <- read.table("test/y_test.txt")
        print("Reading Test subjects Data file...")
                testSubjectsData <- read.table("test/subject_test.txt")
                
## Steps to clean the data
        
## 1. Merges the training and the test sets to create one data set.
        print("Merging Training and Test Data...")
                trainingAndTestData <- rbind(trainingData, testData)
        print("Merging Training and Test Data Labels...")
                trainingAndTestDataLabels <- rbind(trainingDataLabels, testDataLabels)
        print("Merging Training and Test Subjects Data...")
                trainingAndTestSubjectsData <- rbind(trainingSubjectsData, testSubjectsData)
                
        print("Adding column names for data file")
                names(trainingAndTestData) <- features$V2
        print("Adding column name for Data Labels file")
                names(trainingAndTestDataLabels) <- "activity"
        print("Adding column name for subject file...")
                names(trainingAndTestSubjectsData) <- "subject"
        
        print("Merge files into one dataset by column")
                combinedData <- cbind(trainingAndTestData, trainingAndTestDataLabels, trainingAndTestSubjectsData)
        
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
##    Use Metadata Feature
        print("Extract Mean and Standard Deviation columns from Metadata Features...")
                meanAndStdDevColumns <- grep(".*Mean.*|.*Std.*", names(combinedData), ignore.case=TRUE)
        print("Select mean, standard deviation, subject and activity columns...")
                selectRequiredColumns <- c(meanAndStdDevColumns, 562, 563)
        print("Keep only mean, standard deviation, subject and activity columns from combined data...")
                combinedData <- combinedData[, selectRequiredColumns]
                
## 3. Uses descriptive activity names to name the activities in the data set.
##    Use Activity Names 
        print("Set correct activity names...") 
        combinedData$activity <- factor(combinedData$activity, 
                                    labels=c("WALKING", "WALKING UPSTAIRS", "WALKING DOWNSTAIRS", 
                                             "SITTING", "STANDING", "LAYING"))
                
## 4. Appropriately labels the data set with descriptive variable names.
##    Use Subject Training and Subject Test data
        print("Set meaningful variable names...")
        names(combinedData)<-gsub("Acc", "Accelerometer", names(combinedData))
        names(combinedData)<-gsub("Gyro", "Gyroscope", names(combinedData))
        names(combinedData)<-gsub("BodyBody", "Body", names(combinedData))
        names(combinedData)<-gsub("Mag", "Magnitude", names(combinedData))
        names(combinedData)<-gsub("^t", "Time", names(combinedData))
        names(combinedData)<-gsub("^f", "Frequency", names(combinedData))
        names(combinedData)<-gsub("tBody", "TimeBody", names(combinedData))
        names(combinedData)<-gsub("angle", "Angle", names(combinedData))
        
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
        print("Getting average of each variable for each activity and each subject...")
                averageByActivityAndSubject <- ddply(combinedData, c("subject","activity"), numcolwise(mean))
        print("Write Data to tidy_data.txt...")
                write.table(averageByActivityAndSubject, "tidy_data.txt", row.name=FALSE)