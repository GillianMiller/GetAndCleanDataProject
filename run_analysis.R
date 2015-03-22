# This R script reads and performs some cleaning on human activity data.
# The data sets are from recordings of subjects performing daily activities while carrying
# smartphones. The full description of the data sets are available at:
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
#
# The steps to be performed are :
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation 
# 3. Use descriptive activity names to name the activities in the data set
# 4. Appropriately label the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, 
#     independent tidy data set with the average of each 
#     variable for each activity and each subject.#

library("data.table")
library("reshape2")

# Read activity labels
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")[,2]

# Read column names from features
features <- read.table("./UCI HAR Dataset/features.txt")[,2]

# Get the features related to mean and standard deviation
# Look for match for mean() or std()
# There are fields meanFreq() which will not be retrieved
# Escape the brackets using double backslash
features_subset <- grepl ("mean\\(\\)|std\\(\\)", features)

# Read in the X_test data set and extract the mean/std features

X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
names(X_test) = features
X_test_subset = X_test[,features_subset]

# Read in the y_test data set and lookup the activity label
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
y_test[,2] = activity_labels[y_test[,1]]
names(y_test) = c("ActivityId", "ActivityLabel")

# Read in the subject test data
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
names(subject_test) = "SubjectId"

# Bind all of test data together
test_data <- cbind(as.data.table(subject_test), y_test, X_test_subset)

# Read in the X_train data set and extract the mean/std features
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
names(X_train) = features
X_train_subset = X_train[,features_subset]

# Read in the y_train data set and lookup the activity label
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
y_train[,2] = activity_labels[y_train[,1]]
names(y_train) = c("ActivityId", "ActivityLabel")

# Read in the subject train data
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
names(subject_train) = "SubjectId"


# Bind all of the training data together
train_data <- cbind(as.data.table(subject_train), y_train, X_train_subset)

# Merge test and training data
merge_data = rbind(test_data, train_data)

id_names <- c("SubjectId", "ActivityId", "ActivityLabel")
measure_names <- setdiff(colnames(merge_data), id_names)
melt_data  <- melt(merge_data, id=id_names, measure.vars=measure_names)

# Apply mean function to dataset using dcast function
tidy_data   = dcast(melt_data, SubjectId + ActivityLabel ~ variable, mean)

write.table(tidy_data, file = "./tidy_data.txt")


