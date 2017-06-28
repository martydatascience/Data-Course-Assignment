#Data Course Assignment (Week 4) 

##Readme markdown file

###Intro

The purpose of this file is to explain what I did for this assignment. It is important to read this file in conjunction with the codebook for the assignment, which explains the tidy data set I produced.

###Step 0: _Guide to the data_
This R code, and indeed the assignment, makes use of a dataset which I downloaded from the following site:
(https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

The various files within this .zip bear some explanation, and the explanation in the .zip itself is not great.

There are two folders: train and test. Each of these contains three files of relevance:
1. an X_ file, which contains all of the observations, along 561 variables
2. a Y_ file, which contains all of the activity codes associated with each observation
3. a subject_ file, which contains all of the subject identifiers associated with each observation

###Step 1: _Merges the training and the test sets to create one data set._



The task for the first part of the assignment is to join the test and training files. 