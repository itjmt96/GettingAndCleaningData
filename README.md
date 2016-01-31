# Project

Getting and Cleaning Data.

### Purpose

To show one of many ways to collect, work with and clean a data set.

### Goal

Prepare a tidy data set that can be used for future analysis.

### Type of Data

Data collected from the accelerometers from the Samsung Galaxy S smartphone.

### Data Source

A full description of the data is available at the site below where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

### Data Location
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

### Information related to the data and data cleaning

File CodeBook.md has the variables, the data, and any transformations or work that you performed to clean the data.

### Prerequisites

1. Download the data from Data Source location above.
2. Unzip the data. It will extract a folder: UCI HAR Dataset containing files used by the run_analysis.R.
3. Set working directory to folder: UCI HAR Dataset.

## Steps taken to generate tidy data for future use

####R script called run_analysis.R is created that does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set.
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

### How to run the R Script: run_analysis.R

1. Place the R script in the working directory (where the source data is downloaded and unzipped).
2. Run the R script: source(run_analysis.R)
3. File tidy_data.txt will be generated. It will have the data generated for future use.



