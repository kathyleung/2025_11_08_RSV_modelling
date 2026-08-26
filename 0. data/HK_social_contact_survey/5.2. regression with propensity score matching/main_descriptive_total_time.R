
# 2017-03-08
# Calculate propensity score for social contact survey
# Treatment - Paper questionnaire
# Control - Online questionnaire
# https://stanford.edu/~ejdemyr/r-tutorials-archive/tutorial8.html

rm(list=ls());
library(MatchIt);
library(dplyr);
library(ggplot2);
library(MASS);
library(plotrix);

# 1. data
dataTable = read.csv('regrTable_total_time.csv',header = TRUE,stringsAsFactors = FALSE);
ageWeights = read.csv('age_census_weights.csv',header=TRUE,stringsAsFactors = FALSE);
dataTable = merge(dataTable,ageWeights,by.x='participant_code',by.y='participant_code');
# mode of survey: paper = 1, online = 0;
dataTable$mode_survey[dataTable$mode_survey==2]=0;
# gender: male = 0; female = 1
dataTable$gender = dataTable$gender-1;
# age:0-10, 11-20, 21-40, 41-65, >65
dataTable$age_or_mid_range = findInterval(dataTable$age_or_mid_range,c(-1,10,20,40,65,101),left.open = TRUE);
dataTable$age_or_mid_range = factor(dataTable$age_or_mid_range,labels = c('0-10','11-19','21-40','41-65','>65'));
# weekday/weekend: weekday = 0, weekend = 1
dataTable$actual_week_day[dataTable$actual_week_day %in% 1:5] = 0;
dataTable$actual_week_day[dataTable$actual_week_day %in% 6:7] = 1;
# household size: continuous 
dataTable$num_usual_contacts = dataTable$num_usual_contacts + 1;
# education: primary or below, secondary, post-secondary, unknown
dataTable$edu[dataTable$edu>10]=999;
dataTable$edu = factor(dataTable$edu,labels = c('primary','secondary','postsec','unknown'));
# income level
dataTable$income_mid_range[dataTable$income_mid_range %in% 1:2] = 0;
dataTable$income_mid_range[dataTable$income_mid_range %in% 3:4] = 1;
dataTable$income_mid_range[dataTable$income_mid_range %in% 5:7] = 2;
dataTable$income_mid_range[dataTable$income_mid_range %in% 8:11] = 3;
dataTable$income_mid_range[dataTable$income_mid_range>100] = 4;
dataTable$income_mid_range = factor(dataTable$income_mid_range,labels = c('<10k','10-19k','20-39k','>=40k','unknown'));

textVec = c('all','paper','online');
for(iiText in textVec){
  if(iiText == 'all'){
    iiDataTable = dataTable
  }else if(iiText == 'paper'){
    iiDataTable = dataTable[dataTable$mode_survey==1,];
  }else if(iiText == 'online'){
    iiDataTable = dataTable[dataTable$mode_survey==0,];
  }
  # descriptives
  print(mean(iiDataTable$total_hrs_participant))
  print(sd(iiDataTable$total_hrs_participant))
  print(std.error(iiDataTable$total_hrs_participant))
  # gender
  print(with(iiDataTable, tapply(total_hrs_participant, gender, mean)))
  print(with(iiDataTable, tapply(total_hrs_participant, gender, sd)))
  print(with(iiDataTable, tapply(total_hrs_participant, gender, std.error)))
  # age
  print(with(iiDataTable, tapply(total_hrs_participant, age_or_mid_range, mean)))
  print(with(iiDataTable, tapply(total_hrs_participant, age_or_mid_range, sd)))
  print(with(iiDataTable, tapply(total_hrs_participant, age_or_mid_range, std.error)))
  # weekday
  print(with(iiDataTable, tapply(total_hrs_participant, actual_week_day, mean)))
  print(with(iiDataTable, tapply(total_hrs_participant, actual_week_day, sd)))
  print(with(iiDataTable, tapply(total_hrs_participant, actual_week_day, std.error)))
  # household size
  iiDataTable$num_usual_contacts[iiDataTable$num_usual_contacts>5] = 5;
  print(with(iiDataTable, tapply(total_hrs_participant, num_usual_contacts, mean)))
  print(with(iiDataTable, tapply(total_hrs_participant, num_usual_contacts, sd)))
  print(with(iiDataTable, tapply(total_hrs_participant, num_usual_contacts, std.error)))
  # edu
  print(with(iiDataTable, tapply(total_hrs_participant, edu, mean)))
  print(with(iiDataTable, tapply(total_hrs_participant, edu, sd)))
  print(with(iiDataTable, tapply(total_hrs_participant, edu, std.error)))
  # income
  print(with(iiDataTable, tapply(total_hrs_participant, income_mid_range, mean)))
  print(with(iiDataTable, tapply(total_hrs_participant, income_mid_range, sd)))
  print(with(iiDataTable, tapply(total_hrs_participant, income_mid_range, std.error)))
}
