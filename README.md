Robert Huntsman, CFA, FRM
Final Project for Getting and Cleaning Data, Courera.org
==================================================================

The R script "run_analysis.R" submitted for this project performs a series of steps to process and analyze the raw data output from experiments conducted on human activity.

The experiments measured 561 unique features for 30 subjects (21 in a Training data set and 9 in a Test data set) for six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)

Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, the experiment captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. 

The experiments were video-recorded to label the data manually. The obtained dataset was randomly partitioned into two sets, where 70% of the volunteers were selected for generating the training data and 30% the test data. 

The run_analysis.R script performs the following steps:

1. It reads in two files, X_train.txt and X_test.txt.  Each of these data sets includes 561 feature measurements for each subject and activity combination.  
   The X_train.txt file includes 7,352 rows, each one a set of 561 observations for a combination of activity and subject for the Training subjects (21 in all).
   The X_test.txt file includes 2,947 rows, each one a set of 561 observations for a combination of activiity and subject for the Test subjects (9 in all).
2. The script creates a train data set and a test data set consisting of the data read in from Step 1 above.  
3. The script then reads in the subject and activity labels for each row of each data set.  For example, a given row will include one column for the subject and one column for the 
   activity for each set of measurements (561 measurements).  The subject will be a number from 1-30 and the activity a number from 1-6 corresponding to "WALKING, WALKING_UPSTAIRS", etc.
   The labels for the subjects are included in two separate files: "subject_train.txt" and "subject_test.txt".  
   The labels for the activities are included in two separate files: "y_train.txt" and "y_test.txt".
4. After reading in the subject and activity data sets for the train and test data sets, the R script then appends the subject and activity data for each set to each raw data file.  
   The result of the above action is a set of two data sets that includes (1) 7,352 rows and (2) 2,947 rows.  Each row includes 561 measurements as well as the subject number and activity number
   to which the measurements apply.
5. Next, the R script reads in the names of the 561 feature measurements from the file "features".  
   The R script then applies feature labels to each of the 561 measurements so that we know what each measurement represents.
6. Next, the R script merges the train and test data sets to create one master data set "merged" that includes 10,299 rows and 563 columns.  Each row represents a subject, activity and set of 561
   measurements captured by the experiment.  Each measurement is labeled (see CodeBook for feature labels).
7. Next, the R script subsets the merged data set to exclude any measurement that is not a standard deviation or mean. The combined data set includes 10,299 rows and 88 columns and is labeled
   "reduced_df".  2 of the 88 columns include Subject and Activity.  The remaining 86 columns are feature measurements that include a variation of standard deviation or average (avg) in its name.
8. Finally, the R script calculates the average of each feature in the "reduced_df" data set for each subject and activity.  In essence, the R script summarizes the reduced_df by subject and
   activity so that we have a final data set with 188 rows and 88 columns.  86 of the columns are averages of the features that are either standard deviations or averages of the feature measurements.
   The final output is a file called "SummaryActivityBySubjectAndActivity.txt".

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The dataset includes the following files:
=========================================

- 'SummaryActivityDataBySubject.txt'

- 'README_FinalProjectSubmission.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features in the SummaryActivityBySubjectAndActivity.txt file.




Notes: 
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.


Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
