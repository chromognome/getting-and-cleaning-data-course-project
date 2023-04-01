## **Getting and cleaning data course project code book**

### **Collect source data for the project**  

#### **Description**  

Zip file: [Human Activity Recognition Using Smartphones Data Set](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

Website: [Human Activity Recognition Using Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

A group of 30 volunteers performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) while wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity was captured at a constant rate of 50Hz. The obtained dataset was randomly partitioned into two sets, 70% of the volunteers were selected for generating the training data and 30% the test data.  

Check the README.txt and features_info.txt files for further details about this data set.  

#### **Zip file folder structure**  

Location of the text files in the folder structure:  

```
├── UCI HAR Dataset
    ├── test
    │   ├── Inertial Signals
    │   ├── subject_test.txt
    │   ├── X_test.txt
    │   └── y_test.txt
    ├── train
    │   ├── Inertial Signals
    │   ├── subject_train.txt
    │   ├── X_train.txt
    │   └── y_train.txt        
    ├── activity_labels.txt   
    ├── features.txt 
    ├── features_info.txt     
    └── README.txt   
```  
#### **File and attribute information**  

- `activity_labels.txt` -- Ordered list of the six activities
- `features.txt` -- List of the 561 variables
- `features_info.txt` -- Information about the variables and how they were obtained
- `README.txt` -- Read this file first
- `subject_test.txt` -- Identifies the volunteer who performed the testing record. Contains 2947 rows
- `X_test.txt` -- 561-feature vector with time and frequency domain variables with 2947 rows 
- `y_test.txt` -- Identifies the activity performed using integers. Contains 2947 rows
- `subject_train.txt` -- Identifies the volunteer who performed the training record. Contains 7352 rows
- `X_train.txt` -- 561-feature vector with time and frequency domain variables with 7352 rows 
- `y_train.txt` -- Identifies the activity performed using integers. Contains 7352 rows

#### **Activities**  

The activities performed by the volunteers have these values and descriptions:  

1. `WALKING`
2. `WALKING_UPSTAIRS`
3. `WALKING_DOWNSTAIRS`
4. `SITTING`
5. `STANDING`
6. `LAYING`  

#### **Reference**

Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012  

***  

### **Work with and clean the data**  

#### **Code**  

The steps taken to combine and clean this data are recorded in this script:  

> `run_analysis.R`

Refer to the comments in the script for explanation of the code used to perform these steps:

1. Merges the training and the test sets to create one data set
    - The rows from `X_test.txt` and `X_train.txt` are merged into one table
    - Volunteers perform activities in either the testing or the training data set
    - The column `dataset` records which data set each record is taken from
2. Uses descriptive activity names to name the activities in the data set
    - A factor vector is created on `y_test.txt` and `y_train.txt` using the levels and labels found in `activity_labels.txt` 
3. Extracts only the measurements on the mean and standard deviation for each measurement
    - Regular expressions are used with `grep` to select the required columns
    - The literals used are 'mean()' or 'std()' and they exclude the angular measurements
4. Appropriately labels the data set with descriptive variable names
    - Existing column names are stripped of hyphens, parentheses, and repeated words 
    - The 't' and 'f' prefixes are expanded to 'time' and 'freq'
    - Column names are converted to lowercase
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
    - The mean of each variable -- grouped by volunteer and activity performed -- is calculated
    - This results in a table with 180 rows and 69 columns

***  

### **The tidy data** 

#### **Columns** 

The first three columns identify the volunteer carrying out the experiment (`subject`), the activity performed (`activity`), and which data set the summarised records came from (`dataset`). The remaining columns contain the means of each variable grouped by `subject` and `activity`.  


- `subject`
- `activity`
- `dataset`
- `timebodyaccmeanx`
- `timebodyaccmeany`
- `timebodyaccmeanz`
- `timebodyaccstdx`
- `timebodyaccstdy`
- `timebodyaccstdz`
- `timegravityaccmeanx`
- `timegravityaccmeany`
- `timegravityaccmeanz`
- `timegravityaccstdx`
- `timegravityaccstdy`
- `timegravityaccstdz`
- `timebodyaccjerkmeanx`
- `timebodyaccjerkmeany`
- `timebodyaccjerkmeanz`
- `timebodyaccjerkstdx`
- `timebodyaccjerkstdy`
- `timebodyaccjerkstdz`
- `timebodygyromeanx`
- `timebodygyromeany`
- `timebodygyromeanz`
- `timebodygyrostdx`
- `timebodygyrostdy`
- `timebodygyrostdz`
- `timebodygyrojerkmeanx`
- `timebodygyrojerkmeany`
- `timebodygyrojerkmeanz`
- `timebodygyrojerkstdx`
- `timebodygyrojerkstdy`
- `timebodygyrojerkstdz`
- `timebodyaccmagmean`
- `timebodyaccmagstd`
- `timegravityaccmagmean`
- `timegravityaccmagstd`
- `timebodyaccjerkmagmean`
- `timebodyaccjerkmagstd`
- `timebodygyromagmean`
- `timebodygyromagstd`
- `timebodygyrojerkmagmean`
- `timebodygyrojerkmagstd`
- `freqbodyaccmeanx`
- `freqbodyaccmeany`
- `freqbodyaccmeanz`
- `freqbodyaccstdx`
- `freqbodyaccstdy`
- `freqbodyaccstdz`
- `freqbodyaccjerkmeanx`
- `freqbodyaccjerkmeany`
- `freqbodyaccjerkmeanz`
- `freqbodyaccjerkstdx`
- `freqbodyaccjerkstdy`
- `freqbodyaccjerkstdz`
- `freqbodygyromeanx`
- `freqbodygyromeany`
- `freqbodygyromeanz`
- `freqbodygyrostdx`
- `freqbodygyrostdy`
- `freqbodygyrostdz`
- `freqbodyaccmagmean`
- `freqbodyaccmagstd`
- `freqbodyaccjerkmagmean`
- `freqbodyaccjerkmagstd`
- `freqbodygyromagmean`
- `freqbodygyromagstd`
- `freqbodygyrojerkmagmean`
- `freqbodygyrojerkmagstd`
