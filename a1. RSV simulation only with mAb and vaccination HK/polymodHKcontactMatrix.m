function [out,ageDistributionOneyear] =  polymodHKcontactMatrix(ageGroupDefRange,ageDistribution,totalPopulation,CONTACTLABEL)

% Simple contact matrix
% Input parameters
% Example: ageGroupDefRange = [-1,6:5:71,101];

% Read clean dataset
demographics = readtable('../0. data/HK_social_contact_survey/4. data_cleaning_from_pop_file/demographics.csv');
% Propensity score
propenScore = readtable('../0. data/HK_social_contact_survey/5.2. regression with propensity score matching/predicted_propensity_score.csv');
% Contact matrix data
dailyContactDetail = readtable('../0. data/HK_social_contact_survey/4. data_cleaning_from_pop_file/contact_diary_detail.csv');
% select home contacts
if CONTACTLABEL == 1
    dailyContactDetail = dailyContactDetail(dailyContactDetail.skin_contact==1,:);
else
    dailyContactDetail = dailyContactDetail(dailyContactDetail.skin_contact~=1,:);
end

dailyContactMatrAll = join(dailyContactDetail,demographics(:,{'participant_code','age_or_mid_range','mode_survey'}));
% All data
dailyContactMatr = dailyContactMatrAll;
% Contact matrix
% Simple contact matrix
dailyContactMatr = dailyContactMatr(dailyContactMatr{:,'age_or_mid_range'}<=100 & dailyContactMatr{:,'contact_age_or_mid_range'}<=100,:);
participant_age_group = findAgeGroupSmallInterv(dailyContactMatr.age_or_mid_range,ageGroupDefRange);
contact_age_group = findAgeGroupSmallInterv(dailyContactMatr.contact_age_or_mid_range,ageGroupDefRange);
dailyContactMatr = [dailyContactMatr,array2table(participant_age_group),array2table(contact_age_group)];
dailyContactMatr = dailyContactMatr(dailyContactMatr.participant_age_group>0 & dailyContactMatr.contact_age_group>0,:);
% Unique participant
uniParticipant = unique(dailyContactMatr(:,{'participant_code','age_or_mid_range','participant_age_group'}));
distrParticipantAge = hist(uniParticipant.participant_age_group,1:max([max(participant_age_group),max(contact_age_group)]));

% Build contact matrix
recMatr = zeros(max([max(participant_age_group),max(contact_age_group)]),max([max(participant_age_group),max(contact_age_group)]));
recCount = [];
uniParticipant = unique(dailyContactMatr.participant_code);
for ii = 1:length(uniParticipant)
    [iiCount,~] = histcounts(dailyContactMatr.contact_age_group(dailyContactMatr.participant_code==uniParticipant(ii)),1:(max([max(participant_age_group),max(contact_age_group)])+1));
    % Age distribution of contacts of this participant
    iiDistr = iiCount*length(uniParticipant)/sum(propenScore.IPTW)*propenScore.IPTW(propenScore.participant_code==uniParticipant(ii));
    recCount(ii) = sum(iiDistr);
    for jj = 1:length(iiCount)
        if iiCount(jj)>0
            recMatr(unique(dailyContactMatr.participant_age_group(dailyContactMatr.participant_code==uniParticipant(ii))),jj) = ...
                recMatr(unique(dailyContactMatr.participant_age_group(dailyContactMatr.participant_code==uniParticipant(ii))),jj)+iiDistr(jj)/distrParticipantAge(unique(dailyContactMatr.participant_age_group(dailyContactMatr.participant_code==uniParticipant(ii))));
        end
    end
end
contactMatr = recMatr;

adSize = length(ageDistribution);
ageDistributionOneyear = zeros(1,ageGroupDefRange(end));
for ii=1:adSize
    if ii<adSize
        ageDistributionOneyear((5*ii-4):5*ii)=ageDistribution(ii)/5;
    else
        ageDistributionOneyear((5*(ii-1)+1):(5*(ii-1)+15))=ageDistribution(ii)/15;
    end
end

% Adjusted contact matrix, symmetric
AgeDistribution = zeros(1,(length(ageGroupDefRange)-1));      
for ii = 1:(length(ageGroupDefRange)-1)
    if ageGroupDefRange(ii) <= 1
        AgeDistribution(ii) = sum(ageDistributionOneyear(1:ageGroupDefRange(ii+1)));
    else
        AgeDistribution(ii) = sum(ageDistributionOneyear((ageGroupDefRange(ii)+1):ageGroupDefRange(ii+1)));
    end
end
AgeDisPopulation = AgeDistribution*totalPopulation;
adOutputContactMatrix = zeros(size(contactMatr));
for ii = 1:(length(ageGroupDefRange)-1)
    for jj = 1:(length(ageGroupDefRange)-1)
        adOutputContactMatrix(ii,jj) = 0.5*(contactMatr(ii,jj)/AgeDisPopulation(ii)+contactMatr(jj,ii)/AgeDisPopulation(jj));
    end
end
out = adOutputContactMatrix;

end

