library(dplyr)

#Downloading the dataset
dataset <- download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = "~/Desktop/dataset")
unzip("dataset")

#Setting up dataframes
features <- read.table("~/Desktop/UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("~/Desktop/UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("~/Desktop/UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("~/Desktop/UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("~/Desktop/UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("~/Desktop/UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("~/Desktop/UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("~/Desktop/UCI HAR Dataset/train/y_train.txt", col.names = "code")

#Step 1: Merges the training and the test sets to create one data set.
x <- rbind(x_train,x_test)
y <- rbind(y_train,y_test)
subject <- rbind(subject_train,subject_test)
merged_data <- cbind(subject,x,y)

#Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.
extract_data <- merged_data %>% select(subject,code, contains("mean"),contains("std"))

#Step 3: Uses descriptive activity names to name the activities in the data set
extract_data$code <- activities[extract_data$code, 2]

#Step 4: Appropriately labels the data set with descriptive variable names.
names(extract_data)[2] = "activity"
names(extract_data)<-gsub("Acc", "Accelerometer", names(extract_data))
names(extract_data)<-gsub("Gyro", "Gyroscope", names(extract_data))
names(extract_data)<-gsub("BodyBody", "Body", names(extract_data))
names(extract_data)<-gsub("Mag", "Magnitude", names(extract_data))
names(extract_data)<-gsub("^t", "Time", names(extract_data))
names(extract_data)<-gsub("^f", "Frequency", names(extract_data))
names(extract_data)<-gsub("tBody", "TimeBody", names(extract_data))
names(extract_data)<-gsub("-mean()", "Mean", names(extract_data), ignore.case = TRUE)
names(extract_data)<-gsub("-std()", "STD", names(extract_data), ignore.case = TRUE)
names(extract_data)<-gsub("-freq()", "Frequency", names(extract_data), ignore.case = TRUE)
names(extract_data)<-gsub("angle", "Angle", names(extract_data))
names(extract_data)<-gsub("gravity", "Gravity", names(extract_data))

#Step 5:From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
second_data <- extract_data %>% group_by(activity,subject) %>% summarise_all(funs(mean))
write.table(second_data, "second_data.txt", row.names = FALSE)
str(second_data)
