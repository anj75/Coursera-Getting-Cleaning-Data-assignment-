# Coursera-Getting-Cleaning-Data-assignment- Assignment - week 4

The data set was obtained from the following link:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
The R code to download and clean the data is in run_analysis.r. The script performs the following steps

•	Check if zip file has already been downloaded in the working directory and whether it has been u zipped. Download the file if not there and unzip it

•	Load the required libraries

•	Read the names of the activities and features from activity_label.txt and features.txt respectively

•	Read training and test data which is divided into subject, activity and features 

•	Merge the training and test data by rows to create one dataset for subject, one for activity and one for features

•	Name the columns for the 3 data sets. The columns in features data set can be named from features table that was created from features.txt

•	Combine the 3 data sets by column to create one data set

•	Extract the columns which have measurements on mean and standard deviation

•	Create a ‘Final’ data set which has values that have either mean or std measurements as extracted above

•	Use activity names from activityLabel table created earlier to give descriptive names to the activities in the final data set. Factorize the activity variable using descriptive activity names

•	Label the Final data set with descriptive variable names

•	From the Final data set create a new, independent tidy data set that contains average of each variable for each activity and each subject

•	Write the output to tidyData.txt
