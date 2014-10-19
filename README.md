To begin, the function 'runanalysis' runs given that the data from the two data sets are in the current working directory

We start by saving the initial working directory to the variable 'ogwd' as a reference for changing into and out of folders
to grab the sets that we want.

From there we first dive into the 'train' folder to read the 'subject_train.txt' file into the variable
'subtrain', 'y_train.txt' file into the variable 'ytrain', and 'x_train.txt' file into the variable 'mydf1'

Then we do the same within the 'test' folder to read the 'subject_test.txt' file into the variable 'subtest',
'y_test.txt' file into the variable 'ytest', and 'X_test.txt' file into the variable 'mydf2'.

To merge them we first took in the first line from 'mydf1', converted it to a character string, split it, and saved it 
as a vector 'newrow'. We then save it to the data frame 'mydf' as the first row. From there we then followed the same procedure
to loop over all of the lines in 'mydf1' and 'mydf2' to column bind it with 'mydf' to merge the two data frames.

We then proceed to add the 'Subject' and 'Activity' columns to the data frame. We merged the subjects from 'subtrain' and 
'subtest' into a vector 'subject', and merged the activities from 'ytrain', and 'ytest' into a vector 'y'. Then we used cbind
to add the subjects and activities as columnns to 'mydf'. To finish, we took the column names from 'features' and concatenated
them as a vector with 'Subject' and 'Activity' to the variable 'feat' and added 'feat' to 'mydf' as the column names.

After looking through the text files and readme file, we decided on which columns to pick from 'mydf' and created a subindex 
vector 'subindex' of the column numbers that had variables of the means and standard deviations from the study. Using 'subindex',
we subsetted the columns from 'mydf' using 'subindex' to the data frame 'subdf'.

To add descriptive names for the activities, we looped over the column 'Activity' to replace the numbers with their respective
activities: Walking, Walking Upstairs, Walking Downstairs, Sitting, Standing, Laying in a vector 'activities' and replaced the
'Activity' column in 'subdf' with the vector 'activities'. To add descriptive column names we manually made a vector 'names' and
input 'names' as the column names for 'subdf' to finalize the first tidy data set, 'subdf'.

To initialize the 2nd tidy data set with the same column names we set the 2nd tidy data set 'avgdf' as the first row of
'subdf'.

For the purposes of looping through the column in 'Activity', we made the index 'actindex' of the activities.

To get the averages of the means and standard deviations of each activity and subject combination, we used an sapply
to loop the mean function within 2 for loops to rbind to the data frame, 'avgdf'. To replace the first line of 'avgdf'
there was an if else clause to have the very first iteration replace the first row of 'avgdf' instead of rbind to it.

Lastly we wrote the 2nd tidy data set 'avgdf' to a text file 'tidydata2'.







