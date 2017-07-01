setwd("C:/coursera/data course")
##first lets get our files loaded into the workspace
#files should be stored in folders as per the original download archive
#so this means retain the 'train' and 'test' folders
#lets make a variable for each filepath we want
test_filepath <- paste(getwd(),"/test/X_test.txt", sep = "")
test_activity_filepath <- paste(getwd(),"/test/y_test.txt", sep = "")
train_filepath <- paste(getwd(),"/train/X_train.txt", sep = "")
train_activity_filepath <- paste(getwd(),"/train/y_train.txt", sep = "")
labels_filepath <- paste(getwd(),"/features.txt", sep = "")
test_subjects_filepath <- paste(getwd(),"/test/subject_test.txt", sep = "")
train_subjects_filepath <- paste(getwd(),"/train/subject_train.txt", sep = "")

#data files we'll use
test_file <- read.table(test_filepath)
train_file <- read.table(train_filepath)
file_labels <- read.table(labels_filepath)
test_activity <- read.table(test_activity_filepath)
train_activity <- read.table(train_activity_filepath)
test_subjects <- read.table(test_subjects_filepath)
train_subjects <- read.table(train_subjects_filepath)



###Step 1 - join the test and training files
combined_file <- rbind(test_file,train_file)
combined_subjects <- rbind(test_subjects,train_subjects)
combined_activities <- rbind(test_activity,train_activity)
#add labels so we know wtf we're looking at
names(combined_file) <- file_labels[[2]]

##Step 2 - trim the data set to get only means and stds, then 
#add subject and activity
trimmed_file <- combined_file[,grep("[Mm][e][a][n]|std",names(combined_file))]
ready_data <- cbind(trimmed_file,combined_activities,combined_subjects)
colref <- ncol(ready_data)
names(ready_data)[(colref -1):colref]<- 
  c("Activity Code","Subject Number")
rm(list = c("test_file","train_file","combined_file"))  #tidy up a bit

##Step 3 - add a useful name to the activity, rather than a code
#one way to do this is with gsub, per the lectures. I could have done that 6 times, but wanted a better way
#this uses the plyr package. and finding a good solution took WAY longer than just gsubbing 6 times :-/ 
library(plyr)
ready_data$`Activity Code` <- revalue(as.factor(ready_data$`Activity Code`), c("1"="walking","2"="walking upstairs",
                                         "3"="walking downstairs","4"="sitting","5"="standing","6"="laying"))
rm(list = c("indices","descriptions")) #tidy up a bit

##Step 4 - re-label the data with clearer descriptions
#this step I found to be very artificial. Insane to use lots of gsubs or replaces to adjust each variable
#name in R. Much easier to use excel to replace and customise, then put through as one line, using a table
#I hate this wall of text, and in practice I'd have a separate .csv file. But that may not be allowed for 
#the assignment. 

names(ready_data) <- c("body accelerometer x-axis reading mean (time)",
                       "body accelerometer y-axis reading mean (time)",
                       "body accelerometer z-axis reading mean (time)",
                       "body accelerometer x-axis reading standard deviation (time)",
                       "body accelerometer y-axis reading standard deviation (time)",
                       "body accelerometer z-axis reading standard deviation (time)",
                       "gravity accelerometer x-axis reading mean (time)",
                       "gravity accelerometer y-axis reading mean (time)",
                       "gravity accelerometer z-axis reading mean (time)",
                       "gravity accelerometer x-axis reading standard deviation (time)",
                       "gravity accelerometer y-axis reading standard deviation (time)",
                       "gravity accelerometer z-axis reading standard deviation (time)",
                       "body accelerometer jerk x-axis reading mean (time)",
                       "body accelerometer jerk y-axis reading mean (time)",
                       "body accelerometer jerk z-axis reading mean (time)",
                       "body accelerometer jerk x-axis reading standard deviation (time)",
                       "body accelerometer jerk y-axis reading standard deviation (time)",
                       "body accelerometer jerk z-axis reading standard deviation (time)",
                       "body gyroscope x-axis reading mean (time)",
                       "body gyroscope y-axis reading mean (time)",
                       "body gyroscope z-axis reading mean (time)",
                       "body gyroscope x-axis reading standard deviation (time)",
                       "body gyroscope y-axis reading standard deviation (time)",
                       "body gyroscope z-axis reading standard deviation (time)",
                       "body gyroscope jerk x-axis reading mean (time)",
                       "body gyroscope jerk y-axis reading mean (time)",
                       "body gyroscope jerk z-axis reading mean (time)",
                       "body gyroscope jerk x-axis reading standard deviation (time)",
                       "body gyroscope jerk y-axis reading standard deviation (time)",
                       "body gyroscope jerk z-axis reading standard deviation (time)",
                       "body accelerometer magnitude mean (time)",
                       "body accelerometer magnitude standard deviation (time)",
                       "gravity accelerometer magnitude mean (time)",
                       "gravity accelerometer magnitude standard deviation (time)",
                       "body accelerometer jerk magnitude mean (time)",
                       "body accelerometer jerk magnitude standard deviation (time)",
                       "body gyroscope magnitude mean (time)",
                       "body gyroscope magnitude standard deviation (time)",
                       "body gyroscope jerk magnitude mean (time)",
                       "body gyroscope jerk magnitude standard deviation (time)",
                       "body accelerometer x-axis reading mean (frequency)",
                       "body accelerometer y-axis reading mean (frequency)",
                       "body accelerometer z-axis reading mean (frequency)",
                       "body accelerometer x-axis reading standard deviation (frequency)",
                       "body accelerometer y-axis reading standard deviation (frequency)",
                       "body accelerometer z-axis reading standard deviation (frequency)",
                       "body accelerometer mean frequency X (frequency)",
                       "body accelerometer mean frequency Y (frequency)",
                       "body accelerometer mean frequency Z (frequency)",
                       "body accelerometer jerk x-axis reading mean (frequency)",
                       "body accelerometer jerk y-axis reading mean (frequency)",
                       "body accelerometer jerk z-axis reading mean (frequency)",
                       "body accelerometer jerk x-axis reading standard deviation (frequency)",
                       "body accelerometer jerk y-axis reading standard deviation (frequency)",
                       "body accelerometer jerk z-axis reading standard deviation (frequency)",
                       "body accelerometer jerk mean frequency X (frequency)",
                       "body accelerometer jerk mean frequency Y (frequency)",
                       "body accelerometer jerk mean frequency Z (frequency)",
                       "body gyroscope x-axis reading mean (frequency)",
                       "body gyroscope y-axis reading mean (frequency)",
                       "body gyroscope z-axis reading mean (frequency)",
                       "body gyroscope x-axis reading standard deviation (frequency)",
                       "body gyroscope y-axis reading standard deviation (frequency)",
                       "body gyroscope z-axis reading standard deviation (frequency)",
                       "body gyroscope x-axis mean frequency (frequency)",
                       "body gyroscope y-axis mean frequency (frequency)",
                       "body gyroscope z-axis mean frequency (frequency)",
                       "body accelerometer magnitude mean (frequency)",
                       "body accelerometer magnitude standard deviation (frequency)",
                       "body accelerometer magnitude mean frequency (frequency)",
                       "total body accelerometer jerk reading mean",
                       "total body accelerometer jerk reading standard deviation",
                       "total body accelerometer jerk reading mean frequency",
                       "total body gyroscope reading mean",
                       "total body gyroscope reading standard deviation",
                       "total body gyroscope reading mean frequency",
                       "total body gyroscope jerk reading mean",
                       "total body gyroscope jerk reading standard deviation",
                       "total body gyroscope jerk reading mean frequency",
                       "angular velocity based on mean body accelerometer and gravity reading",
                       "angular velocity based on mean body accelerometer jerk and average gravity reading",
                       "angular velocity based on mean gyroscope and average gravity reading",
                       "angular velocity based on mean gyroscope jerk and average gravity reading",
                       "averge angular velocity x-axis",
                       "averge angular velocity y-axis",
                       "averge angular velocity z-axis",
                       "activity",
                       "subject")
##Step 5 -  create a "second, independent tidy data set with the average of each variable for each 
#activity and each subject".
#I have assumed this includes taking means of standard deviations!
library(reshape2)
tempmelt <- melt(ready_data, id = c("subject","activity"), measures = names(ready_data[,1])) 
tidymeans <- dcast(tempmelt, subject + activity ~ variable, mean)
rm(list = c("ready_data","tempmelt")) #tidy up a bit
tidymeans
write.csv(tidymeans,"tidy data set of means.csv")




