CODEBOOK
========

Raw Data
--------

The measurements involve the use of smartphones to gather several measurements like acceleration and magnitude 
during activities of several subjects. The files given in a large zip file have one lookup datafile with
each king of activity and its corresponding id, the types of measurements and their corresponding id,
and finally test and train data, with measurements for the subjects and the activities (subjects and activities
in different file).

The zip file can be found here: [source](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) 

All the kinds of measurements are 561 and too much to include them here. They are available in the file
**features.txt** which is included in the above zip file. 

Preparation on Data
-------------------

* We load all the activity and features lookup tables. We load all the test and train data. Also we load the subject id's and activity id's
so we can have a large dataframe with every observation with all variables and for which activity and for which subject.

* We select (subset) by taking the observations only with the variables (features) that have a -mean measurement or a -std (standard deviation)
measurement 

* We change the column names used in the data, to be more readable.  The obvious one is to remove leading 't' or 'f' for all names.
Then to change -mean() or -std() to Mean or Std respectively. Also found that Acc means Acceleration and Mag is Magnitude, so change it accordingly.
Last but not least name the extra two last columns, to Activity and Subject. 

* We replace the activity id in taken data with its corresponding label (name).

* We create a new tidy data set with the mean for every variable of the observations, groupwise, grouping by activity and subject.