# CodeBook
This is a code book that describes the variables, the data, and any transformations or work that I performed to clean up the data.

1. Downloading the dataset and assigning data to the relevant variables
  * The dataset was downloaded as a zip file and extracted under the folder titled "UCI HAR Dataset".
  * Following which, I assigned the datas to their relevant variables.
  
2. Merges the training and the test sets to create one data set.
  * x was created via rbind() function of x_test and x_train
  * y was created via rbind() function of y_test and y_train
  * subject was created via rbind() function of subject_test and subject_train
  * merged_data was created via cbind() function of x,y and subject
  
3. Extracts only the measurements on the mean and standard deviation for each measurement.
  * extract_data was created by subsetting merged_data, using select() function and selecting columns subject, code and the measurements on the mean and standard deviation (std) for each measurement
  
4. Uses descriptive activity names to name the activities in the data set
  *nspecified numbers were entered in code column of the extract_data, replacing names with corresponding activity taken from second column of the activities variable
  
5. Appropriately labels the data set with descriptive variable names.
  * Labeled the dataset with appropriate descriptive variable names for easier identification

6. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  * Created second_data that contains the average of each variable for each activity and subject.
