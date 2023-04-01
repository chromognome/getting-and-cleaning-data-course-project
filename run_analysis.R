library(dplyr)
library(data.table)

## This script reads the 'Human Activity Recognition Using Smartphones Data Set' and manipulates the files,
## cleans them, and creates two tidy data sets. The second data set is a summarised version of the first,
## containing variable means grouped by the volunteer and activity. This table is written to a file. 

## Refer to CodeBook.md for explanation of the files and their contents. 


## Download zip file and unpack it

unzipPath <- "data/"
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
f <- paste0(unzipPath, "uci-har-dataset.zip")
download.file(fileUrl, destfile = f, method = "curl")
unzip(f, exdir = unzipPath)


## Clean up unneeded objects

remove(f, fileUrl, unzipPath)


## Define path to unzipped folder and read required text files

filePath <- "data/UCI HAR Dataset/"
feature_names <- read.table(paste0(filePath, "features.txt"), header = FALSE)
activity_labels <- read.table(paste0(filePath, "activity_labels.txt"), header = FALSE, col.names = c("class", "activity"))
subject_test <- read.table(paste0(filePath, "test/", "subject_test.txt"), header = FALSE, col.names = c("subject"))
x_test <- read.table(paste0(filePath, "test/", "X_test.txt"), header = FALSE)
y_test <- read.table(paste0(filePath, "test/", "y_test.txt"), header = FALSE, col.names = c("activity"))
subject_train <- read.table(paste0(filePath, "train/", "subject_train.txt"), header = FALSE, col.names = c("subject"))
x_train <- read.table(paste0(filePath, "train/", "X_train.txt"), header = FALSE)
y_train <- read.table(paste0(filePath, "train/", "y_train.txt"), header = FALSE, col.names = c("activity"))


## Merge the tables containing the activity identifier and apply factor using levels and labels found in activity_labels.txt

y_data <- bind_rows(y_test, y_train)
y_data[["activity"]] <- factor(y_data[["activity"]], levels = activity_labels[["class"]], labels = activity_labels[["activity"]])


## Merge the tables containing the volunteer identifier

subject_id <- bind_rows(subject_test, subject_train)


## Add a column to x_test and x_train identifying the data set, then merge them
x_test <- x_test |> mutate(dataset = "TEST") |> relocate(dataset, 1)
x_train <- x_train |> mutate(dataset = "TRAIN") |> relocate(dataset, 1)
x_data <- bind_rows(x_test, x_train)


## Create vector of column names and rename x_data
x_columns <- c("dataset", feature_names[[2]])
x_data <- x_data |> setNames(x_columns)


## Use regular expression to select columns and gsub to clean column names
## The literals used are 'mean()' or 'std()' and they exclude the angular measurements
## Existing column names are stripped of hyphens, parentheses, and repeated words 
## The 't' and 'f' prefixes are expanded to 'time' and 'freq'
## Column names are converted to lowercase

x_clean <- x_data |> select(grep("dataset|mean\\(\\)|std\\(\\)", x_columns)) |> rename_with(~ gsub("\\(\\)|*\\-","", .x))
x_clean <- x_clean |> rename_with(~ gsub("^f", "freq", .x)) |> rename_with(~ gsub("^t", "time", .x))
x_clean <- x_clean |> rename_with(~ gsub("BodyBody", "Body", .x)) |> rename_with(~ tolower(.x))


## Combine the subject, activity and variable tables into tidy data set and define groups

tidy_data <- data.table(subject_id, y_data, x_clean) |> group_by(subject, activity, dataset) 


## Clean up unneeded objects

remove(filePath, feature_names, activity_labels, subject_test, x_test, y_test, subject_train)
remove(x_train, y_train, y_data, subject_id, x_columns, x_data, x_clean) 

## Create the summarised table, calculating the mean of the variables over the groups

tidy_data_summary <- tidy_data |> summarise_all(mean) |> arrange(subject, activity)


## Write summarised tidy data to text file

write.table(tidy_data_summary,"data/tidy_data_summary.txt",row.name=FALSE)
