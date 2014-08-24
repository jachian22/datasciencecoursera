#NOTE: This function runs assuming the needed data is in the current working directory

runanalysis <- function() {
  
  #STEP 1: Merge training and test sets to create one data set: mydf
  #=====================================================================================================
  
  ogwd <- getwd()
  
  #saves the column names for later use
  features <- read.table('features.txt')
  
  #grab the data from the 'train' folder
  
  setwd(ogwd)
  currentwd <- paste(ogwd, '/train', sep = '')
  setwd(currentwd)
  subtrain <- read.table('subject_train.txt')
  ytrain <- read.table('y_train.txt')
  mydf1 <- read.table('X_train.txt', sep='\t', fill=FALSE)
  
  #grab the data from the 'test' folder
  currentwd <- paste(ogwd, '/test', sep = '')
  setwd(currentwd)
  subtest <- read.table('subject_test.txt')
  ytest <- read.table('y_test.txt')
  mydf2 <- read.table('X_test.txt', sep='\t', fill=FALSE)
  
  #initialize the combined df with the first row of
  #the df
  
  templine <- strsplit(as.character(mydf1[1,]), ' ')
  newrow <- vector()
  for (i in 1:length(templine[[1]])) {
    if (templine[[1]][i] != '')
      newrow <- c(newrow, as.numeric(templine[[1]][i]))
  }
  mydf <- as.data.frame(t(newrow))
  
  #fill in the df with the rest of the X_test set
  
  for (i in 2:nrow(mydf1)) {
    templine <- strsplit(as.character(mydf1[i,]), ' ')
    newrow <- vector()
    for (i in 1:length(templine[[1]])) {
      if (templine[[1]][i] != '')
        newrow <- c(newrow, as.numeric(templine[[1]][i]))
    }
    mydf <- rbind(mydf, newrow)
  }
  
  #add the X_test set to the df in mydf
  
  for (i in 1:nrow(mydf2)) {
    templine <- strsplit(as.character(mydf2[i,]), ' ')
    newrow <- vector()
    for (i in 1:length(templine[[1]])) {
      if (templine[[1]][i] != '')
        newrow <- c(newrow, as.numeric(templine[[1]][i]))
    }
    mydf <- rbind(mydf, newrow)
  }
  
  subject <- c(subtrain$V1,subtest$V1)
  y <- c(ytrain$V1,ytest$V1)
  mydf <- cbind(mydf, subject, y)
  feat <- c(as.character(features$V2),'Subject','Activity')
  colnames(mydf) <- feat
  
  #STEP 2: Extract only the measurements on the mean and standard deviation for each measurement
  #mydf -> subdf
  #=====================================================================================================

  #subset the columns of all the mean and std parameters
  
  subindex <- c(1,2,3,4,5,6,41,42,43,44,45,46,81,82,
                83,84,85,86,121,122,123,124,125,126,
                161,162,163,164,165,166,201,202,214,
                215,227,228,240,241,253,254,266,267,
                268,269,270,271,294,295,296,345,346,
                347,348,349,350,373,374,375,424,425,
                426,427,428,429,452,453,454,503,504,
                513,516,517,526,529,530,539,542,552,
                562,563)
  
  subdf <- mydf[,subindex]
  
  #STEP 3: Use descriptive activity names to name the activities in the data set
  #=====================================================================================================
  
  #adding the descriptive activities
  
  activities <- vector()
  for (i in 1:nrow(subdf)) {
    if (subdf$Activity[i] == 1) {activities[i] <- 'Walking'}
    else if (subdf$Activity[i] == 2) {activities[i] <- 'Walking Upstairs'}
    else if (subdf$Activity[i] == 3) {activities[i] <- 'Walking Downstairs'}
    else if (subdf$Activity[i] == 4) {activities[i] <- 'Sitting'}
    else if (subdf$Activity[i] == 5) {activities[i] <- 'Standing'}
    else if (subdf$Activity[i] == 6) {activities[i] <- 'Laying'}
  }
  subdf[,80] <- activities
  
  #STEP 4: Use descriptive variable names to label the columns of the data set
  #=====================================================================================================
  
  #adding the descriptive column names
  
  names <- c('Average Linear Acceleration Time-X','Average Linear Acceleration Time-Y',
             'Average Linear Acceleration Time-Z','Standard Deviation of Linear Acceleration Time-X',
             'Standard Deviation of Linear Acceleration Time-Y','Standard Deviation of Linear Acceleration Time-Z',
             'Average Gravity Time Reading-X','Average Gravity Time Reading-Y',
             'Average Gravity Time Reading-Z','Standard Deviation of Gravity Time Reading-X',
             'Standard Deviation of Gravity Time Reading-Y','Standard Deviation of Gravity Time Reading-Z',
             'Average Linear Jerk Time-X','Average Linear Jerk Time-Y','Average Linear Jerk Time-Z',
             'Standard Deviation of Jerk Time-X','Standard Deviation of Jerk Time-Y',
             'Standard Deviation of Jerk Time-Z','Average Angular Acceleration Time-X',
             'Average Angular Acceleration Time-Y','Average Angular Acceleration Time-Z',
             'Standard Deviation of Angular Accleration Time-X','Standard Deviation of Angular Accleration Time-Y',
             'Standard Deviation of Angular Accleration Time-Z','Average Angular Jerk Time Signal-X','Average Angular Jerk Time Signal-Y',
             'Average Angular Jerk Time Signal-Z','Standard Deviation of Angular Jerk Time Signal-X','Standard Deviation of Angular Jerk Time Signal-Y',
             'Standard Deviation of Angular Jerk Time Signal-Z','Average Magnitude of Linear Accleration Time',
             'Standard Deviation of Linear Acceleration Magnitude by Time','Average Gravitational Magnitude by Time',
             'Standard Deviation of Gravitational Magnitude by Time','Average Linear Jerk Magnitude by Time',
             'Standard Deviation of Linear Jerk Magnitude by Time','Average Angular Acceleration Time',
             'Standard Deviation of Angular Acceleration Time','Average Angular Jerk Magnitude by Time',
             'Standard Deviation of Angular Jerk Magnitude by Time','Average Linear Acceleration Frequency-X',
             'Average Linear Acceleration Frequency-Y','Average Linear Acceleration Frequency-Z',
             'Standard Deviation of Linear Acceleration Frequency-X','Standard Deviation of Linear Acceleration Frequency-Y',
             'Standard Deviation of Linear Acceleration Frequency-Z','Average Frequency of Linear Acceleration-X',
             'Average Frequency of Linear Acceleration-Y','Average Frequency of Linear Acceleration-Z',
             'Average Linear Jerk Frequency-X','Average Linear Jerk Frequency-Y','Average Linear Jerk Frequency-Z',
             'Standard Deviation of Linear Jerk Frequency-X','Standard Deviation of Linear Jerk Frequency-Y',
             'Standard Deviation of Linear Jerk Frequency-Z','Average Frequency of Linear Jerk-X',
             'Average Frequency of Linear Jerk-Y','Average Frequency of Linear Jerk-Z',
             'Average Angular Acceleration Frequency-X','Average Angular Acceleration Frequency-Y',
             'Average Angular Acceleration Frequency-Z','Standard Deviation of Angular Acceleration Frequency-X',
             'Standard Deviation of Angular Acceleration Frequency-Y','Standard Deviation of Angular Acceleration Frequency-Z',
             'Average Frequency of Angular Acceleration-X','Average Frequency of Angular Acceleration-Y',
             'Average Frequency of Angular Acceleration-Z','Average Linear Acceleration Magnitude Frequency',
             'Standard Deviation of Linear Acceleration Magnitude by Frequency','Average Frequency of Linear Acceleration Magnitude',
             'Average Angular Acceleration Jerk Magnitude by Frequency','Standard Deviation of Angular Acceleration Jerk Magnitude by Frequency',
             'Average Frequency of Angular Acceleration Jerk Magnitude','Average Angular Acceleration Magnitude by Frequency',
             'Standard Deviation Angular Acceleration Magnitude by Frequency','Average Frequency of Angular Acceleration Magnitude by Frequency',
             'Average Angular Acceleration Magnitude by Frequency','Average Frequency of Angular Acceleration Jerk Magnitude',
             'Subject','Activity')
  
  colnames(subdf) <- names
  
  #STEP 5: Create a second, independent tidy data set with the average of each variable for each
  #        activity and each subject
  #=====================================================================================================
  
  #creating tidy data set 2
  
  avgdf <- subdf[1,]
  
  #actindex is an index of the activities to loop over in the following code
  
  actindex <- c('Walking','Walking Upstairs','Walking Downstairs','Sitting','Standing','Laying')
  
  for (i in 1:30) {
    temp1 <- subdf[subdf$Subject == i,]
    
    for (n in actindex) {
      temp2 <- temp1[temp1$Activity == n,]
      
      avgline <- sapply(temp2[,1:78],mean)
      avgline <- c(avgline,i,n)
      
      if (i == 1 & n == 'Walking') { avgdf[1,] <- avgline }
      else { avgdf <- rbind(avgdf, avgline) }
    }
  }
  
  #Write the 2nd tidy data set to a txt file
  #=====================================================================================================
  
  #write avgdf to a table using write.table and export it to a txt file
  
  setwd(ogwd)
  write.table(file='tidydata2',avgdf,row.name=FALSE)
}
