
% 2017-02-21
% Data
clear all;
demographics = readtable('../4. data_cleaning_from_pop_file/demographics.csv');
dailyContactDetail = readtable('../4. data_cleaning_from_pop_file/contact_diary_detail.csv');
dailyContactMatrAll = join(dailyContactDetail,demographics(:,{'participant_code','age_or_mid_range','mode_survey'}));

% Record time to 24 HH
recordHour = hour(dailyContactMatrAll.record_time)+minute(dailyContactMatrAll.record_time)/60;
dailyContactMatrAll = [dailyContactMatrAll,array2table(recordHour)];

for iiIdx = 1:length(demographics.participant_code)
    iiContactTab = dailyContactMatrAll(dailyContactMatrAll.participant_code==demographics.participant_code(iiIdx),:);
    iiTime = iiContactTab.record_date*24+iiContactTab.recordHour;
    diary_first_acccess(iiIdx) = min(iiTime);
    diary_last_access(iiIdx) = max(iiTime);
    diary_time_elasped(iiIdx) = max(iiTime)-min(iiTime);    
end

prospective_proxy = [demographics,table(diary_first_acccess',diary_last_access',diary_time_elasped',...
    'VariableNames',{'diary_first_acccess','diary_last_access','diary_time_elasped'})];
writetable(prospective_proxy,'prospective_proxy_diary.csv','Delimiter',',');

% check the distribution of time elasped
figure(1)
subplot(1,2,1)
histogram(prospective_proxy.diary_time_elasped(prospective_proxy.mode_survey==1),0:0.5:6);
title('Paper')
subplot(1,2,2)
histogram(prospective_proxy.diary_time_elasped(prospective_proxy.mode_survey==2),0:0.5:6);
title('Online')