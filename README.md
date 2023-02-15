# coursera-wearables
For the Coursera R Course. This contains the necessary items to complete the assignment.

<b>NOTE: THE ORIGINAL LINK PROVIDED BY THE ASSIGNMENT POINTED TO FILES THAT WERE CORRUPTED. HOWEVER, THAT SITE POINTED TO A NEW LOCATION FOR THE UPDATED DATASET FOUND HERE: http://archive.ics.uci.edu/ml/datasets/Smartphone-Based+Recognition+of+Human+Activities+and+Postural+Transitions  
THAT IS THE DATASET I USED.</b>

## Prerequisites
The R file assumes that you have downloaded the datasets, have unzipped them, and that your working directory has the following structure:  
1. Three (3) folders: "RawData", "Test", and "Train"
2. Four (4) txt files: "activity_labels.txt", "features.txt", "features_info.txt", and "README.txt"

Additionally, this uses three (3) libraries:
1. dplyr
2. lubridate
3. stringr

## Overview
The R file contains steps to:
1. Set the file paths based on the current working directory
2. Read the files for the feature labels, activity labels, train data sets, and test data sets
3. Split the train and test datasets in data frames
4. Append the appropriate column names based on the feature labels file
5. Append columns for the subject and activity
6. Merge the train and test data sets into one (1) dataframe
7. Select only the requested variables: mean and standard deviation
8. Create a tidy dataset that has the averages for each of the requested variables grouped by subject and activity
9. Write tiday dataset to a file called "tidydataset.txt"

## The Sections of run_analysis.R
Section 1: Set the file paths  
Section 2: Read the features.txt file and trim any whitespace from the labels  
Section 3:  
1. Read the train datasets: features, subjects, and activities  
2. The dataset will be read as a list of one long vector, so you must split each of the values up by using the sep = " "  
3. Next, add the dataset into a dataframe and set the column names to the values read in from Section 2  
4. Append the columns for subjects and activities  
5. Add a column with the static value of "train"  

Section 4:  
1. Read the test datasets: features, subjects, and activities  
2. The dataset will be read as a list of one long vector, so you must split each of the values up by using the sep = " "  
3. Next, add the dataset into a dataframe and set the column names to the values read in from Section 2  
4. Append the columns for subjects and activities  
5. Add a column with the static value of "test"  

Section 5: Merge the train and test datasets into one (1) dataframe called "maindf"  
Section 6: Select only the columns that are the mean and standard deviation measurements and convert them to numeric  
Section 7: Read the activity labels file and append the labels to "maindf"; these are the friendly labels  
Section 8: Create a tidy dataset called "averagesdf" that has one (1) record per subject and activity showing the average value for each column  
Sections 9: Write "averagesdf" to a file called "tidydataset.txt"  
