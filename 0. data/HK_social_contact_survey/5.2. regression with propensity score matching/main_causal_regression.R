
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

# 1. data
dataTable = read.csv('regrTable.csv',header = TRUE,stringsAsFactors = FALSE);
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
# household size
dataTable$num_usual_contacts = dataTable$num_usual_contacts + 1;
dataTable$num_usual_contacts[dataTable$num_usual_contacts>5] = 5;
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

# 2. Mediation analysis
# Step 1
# Number of reported contacts
originalNBnoSurvey = glm.nb(num_diary_contact~gender+age_or_mid_range+actual_week_day+num_usual_contacts+edu+income_mid_range,
                            data = dataTable);
summary(originalNBnoSurvey)
originalNBnoSurveyCI = cbind(Estimate = coef(originalNBnoSurvey), confint(originalNBnoSurvey))
round(exp(originalNBnoSurveyCI),digits=3)

# Step 2
# Mode of survey
estPS = glm(mode_survey~gender+age_or_mid_range+actual_week_day+num_usual_contacts+edu+income_mid_range,
            family = binomial(),data = dataTable);
summary(estPS)
estPSCI = cbind(Estimate = coef(estPS), confint(estPS))
round(exp(estPSCI),digits=3)

# Step 3
# Original samples
originalNB = glm.nb(num_diary_contact~gender+age_or_mid_range+actual_week_day+num_usual_contacts+edu+income_mid_range+mode_survey,
                    data = dataTable);
summary(originalNB)
exp(originalNB$coefficients)
# Paper only
originalNBpaper = glm.nb(num_diary_contact~gender+age_or_mid_range+actual_week_day+num_usual_contacts+edu+income_mid_range,
                    data = dataTable[dataTable$mode_survey==1,]);
summary(originalNBpaper)
exp(originalNBpaper$coefficients)
# Online only
originalNBonline = glm.nb(num_diary_contact~gender+age_or_mid_range+actual_week_day+num_usual_contacts+edu+income_mid_range,
                         data = dataTable[dataTable$mode_survey==0,]);
summary(originalNBonline)
exp(originalNBonline$coefficients)

# 3. Propensity score estimation
# glm regression
# including number of contacts
num_contact_categ = data.frame(num_contact_categ=rep(NA,length(dataTable$participant_code)));
num_contact_categ$num_contact_categ[dataTable$num_diary_contact<=5] = 1;
num_contact_categ$num_contact_categ[dataTable$num_diary_contact>5 & dataTable$num_diary_contact<=10] = 2;
num_contact_categ$num_contact_categ[dataTable$num_diary_contact>10 & dataTable$num_diary_contact<=20] = 3;
num_contact_categ$num_contact_categ[dataTable$num_diary_contact>21] = 4;
dataTable = cbind(dataTable,num_contact_categ);
dataTable$num_contact_categ= factor(dataTable$num_contact_categ,labels = c('0-5','6-10','11-20','>20'));
for(iiLabel in c('all','0-5','6-10','11-20','>20')){
  if(iiLabel=='all'){
    iiDataTable = dataTable;
  }
  else{
    iiDataTable = dataTable[dataTable$num_contact_categ==iiLabel,];
  }
  revCausal = glm(mode_survey~gender+age_or_mid_range+actual_week_day+num_usual_contacts+edu+income_mid_range,
                  family = binomial(),data = iiDataTable);
  print(summary(revCausal));
}
