# cleaningdata
run_analysis.R contains the function run_analysis()
which reads and filters the data which can be downloaded from "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
to use it set the working directory or copy the data into the working directory so that it contains the "features.txt","activitylabels.txt", and the "train" and "test" folders then run the run_analysis()
e.g. result <- run_analysis()
it returns a data frame containg the averages of each variable for each activity and subject 
