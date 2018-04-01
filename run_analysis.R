
# FILE: run_analysis.R // Output 2 files: tidy_data_all.txt & tidy_data_grouped.txt

# PREP STEP:

# -- load requirements --
  library(dplyr)

# -- get data --
  datafileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  datafile <- "getdata%2Fprojectfiles%2FUCI HAR Dataset.zip"
  
  if (!file.exists(datafile)) {
    download.file(datafileurl, datafile, mode = "wb")
  }
  
  datafolder <- "UCI HAR Dataset"
  if (!file.exists(datafolder)) {
    unzip(datafile)
  }

  # clear unused objects
  rm(datafile, datafileurl)
  
# -- read data --
  # train
  subject_train <- read.table(file.path(datafolder, "train", "subject_train.txt"))
  X_train <- read.table(file.path(datafolder, "train", "X_train.txt"))
  y_train <- read.table(file.path(datafolder, "train", "y_train.txt"))
  
  #test
  subject_test <- read.table(file.path(datafolder, "test", "subject_test.txt"))
  X_test <- read.table(file.path(datafolder, "test", "X_test.txt"))
  y_test <- read.table(file.path(datafolder, "test", "y_test.txt"))

  # activities 
  activities <- read.table(file.path(datafolder, "activity_labels.txt"))
  colnames(activities) <- c("id", "activity")
  
  # features
  features <- read.table(file.path(datafolder, "features.txt"), as.is = TRUE)
  colnames(features) <- c("id", "feature")
  
# STEP 1: Merges the training and the test sets to create one data set.
  dts_UCIHAR <- rbind( 
    cbind(subject_train, X_train, y_train),
    cbind(subject_test, X_test, y_test)
  )
  
  colnames(dts_UCIHAR) <- c("subject", features[, 2], "activity")
  
  # clear unused objects
  rm(datafolder, subject_train, X_train, y_train, subject_test, X_test, y_test)
  

# STEP 2: Extracts only the measurements on the mean and standard deviation for each measurement.
  # extract by regular expression
  tmp_UCIHAR <- grepl("subject|activity|mean|std", colnames(dts_UCIHAR))
  dts_UCIHAR <- dts_UCIHAR[, tmp_UCIHAR]
  
  # clear unused objects
  rm(tmp_UCIHAR)
  

# STEP 3: Uses descriptive activity names to name the activities in the data set
  dts_UCIHAR$activity <- factor(dts_UCIHAR$activity, levels = activities[, 1], labels = activities[, 2])
  
  
# STEP 4: Appropriately labels the data set with descriptive variable names.
  cols_UCIHAR <- colnames(dts_UCIHAR)
  cols_UCIHAR <- gsub("[\\(\\)]", "", cols_UCIHAR)
  cols_UCIHAR <- gsub("BodyBody", "Body", cols_UCIHAR)
  cols_UCIHAR <- gsub("^f", "frequency", cols_UCIHAR)
  cols_UCIHAR <- gsub("^t", "time", cols_UCIHAR)
  cols_UCIHAR <- gsub("mean", "Mean", cols_UCIHAR)
  cols_UCIHAR <- gsub("std", "Std", cols_UCIHAR)
  
  colnames(dts_UCIHAR) <- cols_UCIHAR
  
  # clear unused objects
  rm(cols_UCIHAR)
  
# STEP 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

  grouped_UCIHAR <- dts_UCIHAR %>% 
    group_by(subject, activity) %>%
    summarise_all(funs(mean))
  

# OUTPUT:
  write.table(dts_UCIHAR, "tidy_data_all.txt", row.names = FALSE, quote = FALSE)
  write.table(grouped_UCIHAR, "tidy_data_grouped.txt", row.names = FALSE, quote = FALSE)  
  
