run_analysis <-function(){
  ##read column and row names
  features = read.table("features.txt",colClasses = "character")[2][[1]]
  activities = read.table("activity_labels.txt", colClasses = "character")[[2]]
  
  ##read and filter test data 
  testSubjects = read.table("test/subject_test.txt",colClasses = "numeric")[[1]]
  testTable = read.table("test/X_test.txt",colClasses = "numeric")
  testLabels = read.table("test/y_test.txt",colClasses = "numeric")[[1]]
  colnames(testTable) = features
  testTable = testTable[grep("std|mean",features,ignore.case = TRUE)]
  testTable["activity"] = activities[testLabels]
  testTable["subject"] = testSubjects
  
  ##read and filter train data
  trainSubjects = read.table("train/subject_train.txt",colClasses = "numeric")[[1]]
  trainTable = read.table("train/X_train.txt",colClasses = "numeric")
  trainLabels = read.table("train/y_train.txt",colClasses = "numeric")[[1]]
  colnames(trainTable) = features
  trainTable = trainTable[grep("std|mean",features,ignore.case = TRUE)]
  trainTable["activity"] = activities[trainLabels]
  trainTable["subject"] = trainSubjects
  
  ##combined data set
  combinedTable = rbind(testTable,trainTable)
  
  notActivityNorSubject = !(names(combinedTable) %in% c("activity", "subject")) 
  
  ##split data for each activity and then take averages for each subject
  temp <- split(combinedTable,combinedTable$activity)
  temp <- lapply(temp,
                  function(a){atemp<-apply(a[,notActivityNorSubject],2,
                    function(b){ 
                      btemp <- tapply(b,a$subject,mean)
                      names(btemp)<-paste0(a$activity[1],":",1:30)
                      return(btemp)
                    })
                    return(atemp)
                  })
  ##recombine data
  do.call("rbind",temp)
  
}