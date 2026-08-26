
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

# 2. Propensity score estimation
# glm regression
dataTable$houseSize = findInterval(dataTable$num_usual_contacts,c(0,1,2,3,4),left.open = TRUE);
dataTable$houseSize = factor(dataTable$houseSize,labels = c('1','2','3','4','>=5'));
estPS = glm(mode_survey~gender+age_or_mid_range+actual_week_day+houseSize+edu+income_mid_range,
            family = binomial(),data = dataTable);
summary(estPS)
estPSCI = cbind(Estimate = coef(estPS), confint(estPS))
round(exp(estPSCI),digits=3)

# predict of propensity score
predPS = data.frame(participant_code = dataTable$participant_code,
                    mode_survey = dataTable$mode_survey,
                    pred_ps = predict(estPS,type = 'response'));
# examine the distribution of propensity score
labs <- paste("Actual mode of questionnaire:", c("Paper", "Online"))
predPS %>%
  mutate(mode_survey = ifelse(mode_survey == 1, labs[1], labs[2])) %>%
  ggplot(aes(x = pred_ps)) +
  geom_histogram(color = "white") +
  facet_wrap(~mode_survey) +
  xlab("Probability of choosing paper questionnaire") +
  ylab("Number of participants")+
  theme_bw()

# 3. Matching algorithm
matchData = matchit(mode_survey~gender+age_or_mid_range+actual_week_day+num_usual_contacts+edu+income_mid_range,
                    method = 'nearest',data = dataTable);
matchDataTab = match.data(matchData);
write.csv(matchDataTab,'regrTab_total_time_matchedPS.csv',row.names = FALSE);
# demographics of the matched sample
table(matchDataTab$gender)
table(matchDataTab$age_or_mid_range)
table(matchDataTab$actual_week_day)
table(matchDataTab$num_usual_contacts)
table(matchDataTab$edu)
table(matchDataTab$income_mid_range)
table(matchDataTab$mode_survey)

# 4. Demographics in PS-matched samples: standard difference
matChar = c('original','matched');
bsChar = c('gender','age_or_mid_range','actual_week_day','houseSize','edu','income_mid_range');
bsBinary = c('gender','actual_week_day');
bsDichron = c('age_or_mid_range','houseSize','edu','income_mid_range');

for(iiMatch in matChar){
  if(iiMatch=='original'){
    iiDataTab = dataTable;
  }
  else{
    iiDataTab = matchDataTab;
  }
  rec = data.frame(covar=NA,std_diff=NA);
  for(iiFac in bsChar){
    if(iiFac %in% bsBinary){
      pTr = sum(iiDataTab[iiDataTab$mode_survey==1,iiFac])/length(iiDataTab[iiDataTab$mode_survey==1,iiFac]);
      pCtrl = sum(iiDataTab[iiDataTab$mode_survey==0,iiFac])/length(iiDataTab[iiDataTab$mode_survey==0,iiFac]);
      stdDiff = 100*(pTr-pCtrl)/sqrt((pTr*(1-pTr)+pCtrl*(1-pCtrl))/2);
      rec = rbind(rec,data.frame(covar=iiFac,std_diff=stdDiff));
    }
    else if (iiFac %in% bsDichron){
      pTr = as.numeric(table(iiDataTab[iiDataTab$mode_survey==1,iiFac])/length(iiDataTab[iiDataTab$mode_survey==1,iiFac]));
      pCtrl = as.numeric(table(iiDataTab[iiDataTab$mode_survey==0,iiFac])/length(iiDataTab[matchDataTab$mode_survey==0,iiFac]));
      pTr = pTr[2:length(pTr)];
      pCtrl = pCtrl[2:length(pCtrl)];
      covMatr = matrix(NA,nrow=length(pTr),ncol=length(pCtrl));
      for(iiTr in 1:length(pTr)){
        for(iiCtrl in 1:length(pCtrl)){
          if(iiTr==iiCtrl){
            covMatr[iiTr,iiCtrl] = (pTr[iiTr]*(1-pTr[iiTr])+pCtrl[iiCtrl]*(1-pCtrl[iiCtrl]))/2;
          }
          else{
            covMatr[iiTr,iiCtrl] = (pTr[iiTr]*pTr[iiCtrl]+pCtrl[iiTr]*pCtrl[iiCtrl])/2;
          }
        }
      }
      stdDiff = 100*sqrt(((pTr-pCtrl)%*%covMatr)%*%t(t(pTr-pCtrl)));
      rec = rbind(rec,data.frame(covar=rep(iiFac,length(stdDiff)),std_diff=stdDiff));
    }
    else if (iiFac %in% bsContin){
      mTr = mean(iiDataTab[iiDataTab$mode_survey==1,iiFac]);
      varTr = var(iiDataTab[iiDataTab$mode_survey==1,iiFac]);
      mCtrl = mean(iiDataTab[iiDataTab$mode_survey==0,iiFac]);
      varCtrl = var(iiDataTab[iiDataTab$mode_survey==0,iiFac]);
      stdDiff = 100*(mTr-mCtrl)/sqrt((varTr+varCtrl)/2);
      rec = rbind(rec,data.frame(covar=iiFac,std_diff=stdDiff));
    }
  }
  rec = rec[2:length(rec[,1]),];
  if(iiMatch=='original'){
    overallRec = rec;
  }
  else{
    overallRec = cbind(overallRec,rec);
  }
}
print(overallRec)

# 5. Examining covariate balance in the matched sample
# Estimating treatment effects
# i.e. the effect of choice of paper/online questionnaire on the total contact time
# Matched samples
matchedNB = glm.nb(total_hrs_participant~gender+age_or_mid_range+actual_week_day+num_usual_contacts+edu+income_mid_range+mode_survey,
                   data = matchDataTab,
                   weights = matchDataTab$age_weights);
summary(matchedNB)
matchedNBCI = cbind(Estimate = coef(matchedNB), confint(matchedNB));
expcoeff = round(exp(matchedNBCI),digits=3);
expcoeff


# Original samples
originalNB = glm.nb(total_hrs_participant~gender+age_or_mid_range+actual_week_day+num_usual_contacts+edu+income_mid_range+mode_survey,
                    data = dataTable,
                    weights = dataTable$age_weights);
summary(originalNB)
originalNBCI = cbind(Estimate = coef(originalNB), confint(originalNB))
expcoeff = round(exp(originalNBCI),digits=3);
expcoeff

# 5. Inverse Probability of Treatment Weighting
predPS = cbind(predPS,
               data.frame(inv_ps_paper = 1/predPS$pred_ps,
                          inv_ps_online = 1/(1-predPS$pred_ps),
                          IPTW = predPS$mode_survey/predPS$pred_ps + (1-predPS$mode_survey)/(1-predPS$pred_ps)));
predPS = cbind(predPS,
               data.frame(PT = 1/predPS$IPTW));
write.csv(predPS,'predicted_propensity_score.csv',row.names = FALSE);

