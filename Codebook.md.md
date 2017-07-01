# Data Course Assignment (Week 4) 

## Codebook

### Intro

The purpose of this file is to explain the variables in the tidy dataset produced by my code, run_analysis.R. It is important to read this file in conjunction with the readme for the assignment, which explains how I produced the tidy dataset.

### Guide to starting raw data
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

### Codebook

The run_analysis.R script I created for this project strips out a large number of the variables that are included in the original data. In particular, I only have retained the means and standard deviations calculated by the original researchers.
This leaves a total of 86 variables, from an original set of 561. 

_Variables_
The variables that I have retained have all been renamed to be clearer - to the point where their names should be largely self-explanatory. But for some extra clarification:

* all of the readings are from a smartphone's measuring system for the user's movement in 3-d space - i.e., along the X, Y, and Z axis
* there are readings relative to the body as well as readings of gravity
* there are also readings from both the phone's accelerometer and also the phone's gyroscope
* in addition, there are readings of a derived measurement, called 'jerk'
* some readings are measured over time and others are measured in frequency
* the angular velocity was also measured 

So each variable that I retained represents a combination of these different measurement types. And just to reiterate, I have only retained the mean and standard deviation measurements from the original data set. So for example:
body gyroscope x-axis mean frequency (frequency) is: the mean (calculated by the original researchers) observed x-axes frequency from the body gyroscope

Whereas (for another example)
body accelerometer jerk magnitude stanard deviation (time) is: the derived jerk standard deviation, measured by the original researchers, off the body accelerometer. 

There are many such observations for each varaible for each person and each activity they did. 

_Tidy data set_

As noted, there were many observations for each person and each activity they did. Even for these mean and standard deviation variables, which one might expect to only have one value!
Per the assignment instructions, I have taken these (trimmed) mean and standard deviation values and derived their average values. Yes, this means I have taken averages of standard deviations - I'm not sure that this is a thing...

So in the tidy set, the many rows have been condensed. There are 180 rows, each corresponding to a unique combination of subject and activity. For each unique combination, I have calculated the average of each of the 86 columns that were stripped out of the original data set of 561. 
There are multiple rows for each subject, because each subject participated in all six activities. 

I argue that this is tidy data. True, I could have split() the data to give separate tables for each subject, or each activity. But I actually find this presentation to be intuitive. Each row still represents a unique observation. This sort of data is common in studies where subjects participate in multiple experimental conditions. 
