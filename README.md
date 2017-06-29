# Data Course Assignment (Week 4) 

## Readme markdown file

### Intro

The purpose of this file is to explain what I did for this assignment. It is important to read this file in conjunction with the codebook for the assignment, which explains the tidy data set I produced.

_additional comment and explanation is also available in the code itself_

### Step 0: _Guide to the data_
This R code, and indeed the assignment, makes use of a dataset which I downloaded from the following site:
(https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

The various files within this .zip bear some explanation, and the explanation in the .zip itself is not great.

There are two folders: train and test. Each of these contains three files of relevance:
1. an X_ file, which contains all of the observations, along 561 variables
2. a Y_ file, which contains all of the activity codes associated with each observation
3. a subject_ file, which contains all of the subject identifiers associated with each observation

In addition, there are several other essential files:
* activity_labels, which tells us what the activity codes in the Y_file mean
* features, which identifies the 561 columns in the X_files (omg x-files!)


For step 0 in my code, I basically just did a bunch of read.csv commands to get all the data I need.

### Step 1: _Merges the training and the test sets to create one data set_

This step is fairly simple. All my code does is take the X_ file from the training and test folders, and merge them using rbind.
I do this separately for the subjects, activities, and x_ files
Then I read in the labels so we know what the 561 columns represent.

### Step 2: _Extracts only the measurements on the mean and standard deviation for each measurement_

In this step I take my combined data file and use grep() to reduce it down to a trimmed file that only includes variables that contain mean or standard deviation in their names
And I add on the subject and activity codes, from the Y_ and subject_ files using cbind
And I add names to the activity and subject variables to be clear

### Step 3: _Uses descriptive activity names to name the activities in the data set_
For this step I used the revalue() function from the plyr package to map each item in the activity codes to an actual task, e.g., walking, etc.
I could have done gsub() but I preferred the solution of doing it all in one line. Would have been much faster not to research this!

### Step 4: _Appropriately labels the data set with descriptive variable names_

In this step I replace all of the variable names with something that is a bit more like English. 
Personally, I found this step a bit artificial. Yes, I could have run a lot of gsub() commands. But better to just write new names and read in from a separate table, surely? Definitely a job for excel and find/replace! But that didn't seem like it would be allowed.

### Step 5: _From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject_

I use the reshape2 package to melt and then dcast the data.
The first step is to melt ALL of the mean and standard deviation variables in step 4 into a single, SUPERLONG temporary variable called 'variable'
Then I use dcast to take the molten long data and calculate a mean for each of the many bits of the temporary 'variable' sorted by subject and activity.
I found this the most intuitive way to do this, having struck out with split-sapply, or gather-spread. 

### Are the data tidy?

Well, I think they are. Certainly the columns are fine - it's debatable whether there should be multiple rows for a single subject. Arguably, I could split() the data by subject to have a separate 6-row frame for each subject, or split() by activity, and have a 30-row frame for each activity. But I'm okay with it as it is. Each row represents a unique observation - a single subject doing a single activity, and then being measured on variables. It is ready to analyse, and users could easily split() if they wanted. 

