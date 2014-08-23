
# check if package is installed
if (!require("data.table")) {
  # if not, install it
  install.packages("data.table")
  # check again. if not installed now, abort
  if (!require("data.table")) {
    print( "package data.table does not exist, and cannot be installed. Check Internet connection. Program abort")
  }
}


# STEP 1
# check if zip file exists. if not, download it.
# then unzip.


if( !file.exists("gedata_projectfiles_UCI HAR Dataset-1.zip")) {
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")
}
unzip("gedata_projectfiles_UCI HAR Dataset-1.zip")

# the downloaded data are in a directory named
# "UCI HAR Datashet" inside the data directory

activities<-read.table("./UCI HAR Dataset/activity_labels.txt",col.names=c("id","label"), stringsAsFactors=FALSE)
features <- read.table("./UCI HAR Dataset/features.txt",stringsAsFactors=FALSE)

# now load all data to a dataframe 

data<-rbind( read.table("./UCI HAR Dataset/train/X_train.txt",header=FALSE),
             read.table("./UCI HAR Dataset/test/X_test.txt",header=FALSE))
data[,562]<-rbind( read.table("./UCI HAR Dataset/train/y_train.txt",header=FALSE),
                   read.table("./UCI HAR Dataset/test/y_test.txt",header=FALSE))
data[,563]<-rbind( read.table("./UCI HAR Dataset/train/subject_train.txt",header=FALSE),
                   read.table("./UCI HAR Dataset/test/subject_test.txt",header=FALSE))


# STEP 2
# Now we should extract the measurements on the mean and 
# standard deviation of each measurement. So we will check the labels
# and select only the columns which are giving mean and std
# this can be found from features data frame
# we specifically select -mean() or -std() strings

selected = grepl("-(mean|std)\\(\\)",features[,2])

# extract only the required data (columns)

data2<-data[,c(selected,562,563)]

# STEP 3 (see afterwards 4)


# STEP 4
# Now change the names in features to more readable ones.
# 1. remove leading f or t
# 2. Replace Acc with Acceleration
# 3. Replace Mag with Magnitude
# 4. Replace -mean() with Mean
# 5. Replace -std() with Std

features2<-features[selected,2]
features2<-gsub("^t|^f","",features2)
features2<-gsub("Acc","Acceleration",features2)
features2<-gsub("Mag","Magnitude",features2)
features2<-gsub("-mean\\(\\)","Mean",features2)
features2<-gsub("-std\\(\\)","Std",features2)
features2[67]<-"Activity"
features2[68]<-"Subject"

# Now extract the data wanted and label them

data2<-data[,c(selected,562,563)]
names(data2)<-features2

# STEP 3
# Now change in each occurence in data2, the activity code
# with its corresponing label
# We needit to do now, because first we had to name the columns (STEP4)

data2$Activity<-activities[ data2$Activity, 2]

# STEP 5
# Create a tidy data set and write it.
# here we will use the data.table package, it makes it easy

# First create a datatable from our reduced dataframe
dt<-data.table(data2)

# We want to summarize by Subject and by Activity. Thus make the keys

keys<-c("Subject","Activity")
setkeyv(dt,keys)

# in order to lapply the fuction mean on the groups of values made by key

sums <- dt[,lapply(.SD,mean),by=key(dt)]

# now we have the summarized data as requested, and it is the tidy data set.
# we can save these data.

write.table( sums, file="tidy_dataset.txt", row.name=FALSE)
