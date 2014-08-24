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

3. Load from files in data frames. We have the activities data file, which is the code (label) and its correspoding description for each 
type of activity, and the features file, which is again a lookup table of the different types of measurements (variables), a total of 561 of them.
Load also the data of the observations, and append (cbind) to the observations the id of the subject for each measurement and the activity id.

