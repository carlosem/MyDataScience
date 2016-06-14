

#### IMPORTANT !!!! ####
## I performed the analysis following a different order from the one on the instructions
## of the exercise because I think it has a better flow for the programming and it is more intuitive

# Reading the Features and finding out which collums has measurements
# only for mean and standart deviation.

features <- read.table(file = "UCI HAR Dataset/features.txt", header = FALSE)

is_mean_std <- grepl("(.*)mean[(](.*)|(.*)std[(](.*)", features[,2])
features_mean_std <- features[is_mean_std,]
id_mean_std <- features_mean_std[,1]
names_mean_std <- as.character(features_mean_std[,2])

# Reading test sets

person_test <- read.table(file = "UCI HAR Dataset/test/subject_test.txt", header = FALSE)
activity_test <- read.table(file = "UCI HAR Dataset/test/y_test.txt", header = FALSE)
measures_test <- read.table(file = "UCI HAR Dataset/test/X_test.txt", header = FALSE)
measures_test <- measures_test[,id_mean_std] # Choose only the id's of the measures I want                                  

test <- cbind(person_test, activity_test, measures_test)
colnames(test) <- c("person", "activity", names_mean_std)

# Reading the training set

person_training <- read.table(file = "UCI HAR Dataset/train/subject_train.txt", header = FALSE)
activity_training <- read.table(file = "UCI HAR Dataset/train/y_train.txt", header = FALSE)
measures_training <- read.table(file = "UCI HAR Dataset/train/X_train.txt", header = FALSE)
measures_training <- measures_training[,id_mean_std]

training <- cbind(person_training, activity_training, measures_training)
colnames(training) <- c("person", "activity", names_mean_std)

# Using descriptive names for the activities in the data set

test$activity <- as.character(test$activity)
test$activity[test$activity == "1"] <- "WALKING"
test$activity[test$activity == "2"] <- "WALKING_UPSTAIRS"
test$activity[test$activity == "3"] <- "WALKING_DOWNSTAIRS"
test$activity[test$activity == "4"] <- "SITTING"
test$activity[test$activity == "5"] <- "STANDING"
test$activity[test$activity == "6"] <- "LAYING"

training$activity <- as.character(training$activity)
training$activity[training$activity == "1"] <- "WALKING"
training$activity[training$activity == "2"] <- "WALKING_UPSTAIRS"
training$activity[training$activity == "3"] <- "WALKING_DOWNSTAIRS"
training$activity[training$activity == "4"] <- "SITTING"
training$activity[training$activity == "5"] <- "STANDING"
training$activity[training$activity == "6"] <- "LAYING"

## Merging the datas

# if we merge the two data sets using merge() function as shown below, 
# we would have more than one observational unit in the same data set.
# That is why we are goint to merge using rbind().
#
# test_training <- merge(x = training, y = test, by.x = c("person", "activity"), by.y = c("person", "activity"), all.x = TRUE)

training_test <- rbind(training, test)

# Creating a new tidy data set

install.packages("dplyr")
library(dplyr)
tidy_data <- summarise_each(group_by(training_test, person, activity), funs(mean))
write.table(tidy_data, file = "tidy_data.txt", row.names = FALSE)






