Getting and Cleaning Data Course Project
========================================
By Savvas Pavlidis, 2014

Introduction
------------
The project assignment for the Coursera course "Getting and Cleaning Data" 

Description of Analysis
-----------------------

The script is divided in parts according to function. 

1. Check if needed packages (data.table) are available, 
and load them. If not, try to install the needed packages, and check again. If again the needed packages are not available, 
there is a problem, and surely no need to proceed. Program stops.

2. Check if the directory of the unzipped file exists in the current working directory as given by the user (assuming if the directory exists, then
the files also exists). If the directory of the files does not exist, check the existence of the zip file of the assignment. If it does not
exist, download it. Then Unzip.

3. (STEP 1 of assignment) Load from files in data frames. We have the activities data file, which is the code (label) and its correspoding description for each 
type of activity, and the features file, which is again a lookup table of the different types of measurements (variables), a total of 561 of them.
Load also the data of the observations, and append (cbind) to the observations the id of the subject for each measurement and the activity id.

4. (STEP 2 of assignment) According to assignment, we should extract only the observations with variables (features) which are mean and std (standard deviation). 
Thus grep from the descriptions of features only those with mean or std. Because mean is also used and in other places (like meanFreq), grenmp
specifically the "-mean()" or "-std()", and create a logical table of the columns that we will keep. Then create a new dataframe by subsetting the 
data, only the columns selected via the grep, and ofcourse the last two columns which are the id of the activity and the id of the subject.

5. In step 3 of assignment is required to change the id's of activities whith its descriptive name. This is postponed because we didn't label the
columns added (the activities id and the subject id) but most of all for performance reasons, we should push the computer to do as little as possible, 
and it will do less work in the subsetted dataframe. 

6. (STEP 4 of assignment). We need to change the names to more humanly readable. The obvious one is to remove leading 't' or 'f' for all names.
Then to change -mean() or -std() to Mean or Std respectively. Also found that Acc means acceleration and Mag is Magnitude, so change it accordingly.
Last but not least name the extra two last columns, to Activity and Subject. Make a subset of the data, and name them with the new names.

7. (STEP 3 of assignment). We need to label with descriptive names the activity. So we replace  to this column of the dataframe, the label from the
activities, according to activity id already there.

8. (STEP 5 of assignment). We need to create a tidy data set. Here we will use the data.table package because it makes it easier. We create a data table
with the subsetted and newly named dataframe. We create a compound key, by Subject and Activity, so we can group observations by these group and summarize
them. We make the summarization by the key, with the function sum. Finally write the data table to a file for submitting work.