# Getting and Cleaning Data Course Projet
One of the most exciting areas in all of data science right now is wearable computing - see for example [this article](http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/) . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. 

** A full description is available at the site where the data was obtained:**
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

** Here are the data for the project:**
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


## This repository contains the following files: ##

- `README.md` (this file): Overview of the data set and how it was created.
- `tidy_data_all.txt`: Complete tidy data set (all collumns).
- `tidy_data_grouped.txt`: Grouped tidy data set.
- `CODEBOOK.md`: Describes the contents of the data sets (indicate all the variables and summaries calculated, along with units, and any other relevant information).
- `run_analysis.R`: R script that was used to create the data set. 

## R script called run_analysis.R that does the following:

* Donwload and extract data
* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement.
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names.
* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
* Export 2 tiny data files called *tidy_data_all.txt* and *tidy_data_grouped.txt*.

## System Info
* Windows 10 Enterprise x64
* R Studio Version 1.1.383
* Library dplyr_0.7.4
