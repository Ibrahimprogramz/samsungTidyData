---
title: "README"
author: "Ibrahimprogramz"
date: "August 19, 2016"
output: html_document
---
##**Samsung Data Getting and Cleaning Project**

This code conducts multiple operations on the downloaded "Human Activity Recognition Using Smartphones Data Set". The purpose is to have a tidy dataset. 

### Running the code

1. The R script **"run_analysis.R"** should be saved in the working directory which could be detected using the command getwd() in the R console. 

2. The script should be sourced using the R console.

3. Run the **cleanData()** function. The function will firstly download the data from HCI Machine Learning Repository and conduct the required operations in the Getting and Cleaning Data Course Project 1,2,3,4 and 5.

4. The folder **"GetCleanDataProject"** will be created in the working directory which will contain the resultant datasets.

5. The resultant datasets are: 
 
    - **"mergedDataset.csv"** : Here test and train datasets are merged here with their means and Standard deviation variables only. The variables are named according to the descriptive naming conventions.
 
    - **"tidyData.csv"** : this dataset contains the merged test and train datasets with means of all variables grouped by subjects and activities  
