
# 2017-03-08
# Kruskal Wallis rank sum test

rm(list=ls());
# 1. data
dataTable = read.csv('regrTable.csv',header = TRUE,stringsAsFactors = FALSE);
# mode of survey: paper = 1, online = 0;
dataTable$mode_survey[dataTable$mode_survey==2]=0;
# gender: male = 0; female = 1
dataTable$gender = dataTable$gender-1;

# age: categorical variable by 5-year band
# # five-year age band
# dataTable$age_or_mid_range = findInterval(dataTable$age_or_mid_range,c(seq(0,65,5),101),left.open = TRUE);
# age bands: 0-10, 11-20, 21-40, 41-65, >65
dataTable$age_or_mid_range = findInterval(dataTable$age_or_mid_range,c(0,10,20,40,65,101),left.open = TRUE);

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

# 2. Factor to perform KW test
fac_list = c('gender','age_or_mid_range','actual_week_day','num_usual_contacts','edu','income_mid_range','mode_survey');
rec = data.frame(factor = rep(NA,length(fac_list)), pvalue = rep(NA,length(fac_list)));
for(iiFac in 1:length(fac_list)){
  hTest = kruskal.test(dataTable$num_diary_contact,dataTable[,fac_list[iiFac]]);
  rec$factor[iiFac] = fac_list[iiFac];
  rec$pvalue[iiFac] = hTest$p.value;
}
print(rec);


# 3. Stratified by paper/online
fac_list = c('gender','age_or_mid_range','actual_week_day','num_usual_contacts','edu','income_mid_range');
rec = data.frame(mode_survey = rep(NA,2*length(fac_list)),factor = rep(NA,2*length(fac_list)), pvalue = rep(NA,2*length(fac_list)));
for(iiMode in 1:2){
  for(iiFac in 1:length(fac_list)){
    hTest = kruskal.test(dataTable$num_diary_contact[dataTable$mode_survey==iiMode-1],
                         dataTable[dataTable$mode_survey==iiMode-1,fac_list[iiFac]]);
    rec$mode_survey[(iiMode-1)*length(fac_list)+iiFac]=iiMode-1;
    rec$factor[(iiMode-1)*length(fac_list)+iiFac] = fac_list[iiFac];
    rec$pvalue[(iiMode-1)*length(fac_list)+iiFac] = hTest$p.value;
  }
}
print(rec);