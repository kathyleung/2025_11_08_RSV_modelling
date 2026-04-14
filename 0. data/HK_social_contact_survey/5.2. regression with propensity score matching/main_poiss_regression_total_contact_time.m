
% Jan 10, 2017
% Same method as Mossong et al PLOS Med 2008
% 1. Data
clear all;
demographics = readtable('../4. data_cleaning_from_pop_file/demographics.csv');
usuContactGeneral = readtable('../4. data_cleaning_from_pop_file/usual_contact_general.csv');
dailyContactGeneral = readtable('../4. data_cleaning_from_pop_file/contact_diary_general.csv');
dailyContactDetail = readtable('../4. data_cleaning_from_pop_file/contact_diary_detail.csv');
% Total contact time
timeUnitVec = [2.5,9.5,37,150,240];
timeIdx = unique(dailyContactDetail.total_time);
dailyContactDetail.total_time(dailyContactDetail.total_time==999|dailyContactDetail.total_time==9001) = 1;
total_time_mins = zeros(length(dailyContactDetail.total_time),1);
physical_time_mins = zeros(length(dailyContactDetail.total_time),1);
for iiTime = 1:5
    total_time_mins(dailyContactDetail.total_time==iiTime) = timeUnitVec(iiTime);
    physical_time_mins(dailyContactDetail.total_time==iiTime & dailyContactDetail.skin_contact==1) = timeUnitVec(iiTime);
end
dailyContactDetail = [dailyContactDetail,array2table([total_time_mins,physical_time_mins],...
    'VariableNames',{'total_time_mins','physical_time_mins'})];
for iiPart = 1:length(demographics.participant_code)
    iiRec = dailyContactDetail(dailyContactDetail.participant_code==demographics{iiPart,'participant_code'},:);
    total_hrs_participant(iiPart,:) = [demographics{iiPart,'participant_code'},sum(iiRec.total_time_mins)/60];
    physical_hrs_participant(iiPart,:) = [demographics{iiPart,'participant_code'},sum(iiRec.physical_time_mins)/60];
end
total_hrs_participant = array2table(total_hrs_participant,'VariableNames',{'participant_code','total_hrs_participant'});
physical_hrs_participant = array2table(physical_hrs_participant,'VariableNames',{'participant_code','physical_hrs_participant'});
% Join table
regrTable = join(join(join(demographics,usuContactGeneral(:,[1,3]),'Keys','participant_code'),total_hrs_participant,'Keys','participant_code'),physical_hrs_participant,...
    'Keys','participant_code');
% write table
writetable(regrTable,'regrTable_total_time.csv');