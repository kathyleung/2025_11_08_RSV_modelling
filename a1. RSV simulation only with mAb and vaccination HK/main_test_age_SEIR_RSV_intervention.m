
% 2024-12-28
% RSV model from David Hodgson
% clear all;
clearvars;
clf;

% 0. Hong Kong data 
% HK reported case number
monthlyCaseRSV = readtable('../0. data/Hong_Kong_CHP/RSV data to HKU.xlsx');
monthlyCaseRSV.Properties.VariableNames = {'year_month',...
    'num_lab_RSV_0_5_month','num_lab_RSV_6_11_month',...
    'num_lab_RSV_1_4_yr','num_lab_RSV_5_64_yr','num_lab_RSV_65_74',...
    'num_lab_RSV_75_yr_above','num_lab_RSV_no_DOB','num_lab_RSV_all_ages'};
for ii = 1:length(monthlyCaseRSV.year_month)
    monthlyCaseRSV.year(ii) = str2double(monthlyCaseRSV.year_month{ii}(1:4));
    monthlyCaseRSV.month(ii) = str2double(monthlyCaseRSV.year_month{ii}(6:7));
end
monthlyCaseRSV = monthlyCaseRSV(:,{'year','month','year_month',...
    'num_lab_RSV_0_5_month','num_lab_RSV_6_11_month',...
    'num_lab_RSV_1_4_yr','num_lab_RSV_5_64_yr','num_lab_RSV_65_74',...
    'num_lab_RSV_75_yr_above','num_lab_RSV_no_DOB','num_lab_RSV_all_ages'});
ageDefMonthlyRSV = [6/12,12/12,5,65,75,100];

% ILI data from CHP website
weeklyILI = readtable('../0. data/Hong_Kong_CHP/flux_data.xlsx');
weeklyILI = weeklyILI(~isnan(weeklyILI{:,1}),[1:9,11:14,17:23,24]);
weeklyILI.Properties.VariableNames = {...
    'year','week','week_start','week_end',...
    'ILI_GOPC_per_1000_consultations','ILI_GP_per_1000_consultations',...
    'num_lab_flu_A_H1','num_lab_flu_A_H3','num_lab_flu_B',...
    'perc_lab_flu_A_H1','perc_lab_flu_A_H3','perc_flu_lab_B','perc_flu_all_ages',...
    'flu_hosp_0_5_yr_per_10000_population','flu_hosp_6_11_yr_per_10000_population',...
    'flu_hosp_12_17_yr_per_10000_population','flu_hosp_18_49_yr_per_10000_population',...
    'flu_hosp_50_64_yr_per_10000_population','flu_hosp_65_above_yr_per_10000_population',...
    'flu_hosp_all_age_per_10000_population','ILI_AED_per_1000_consultations'};
weeklyILI = weeklyILI(weeklyILI.year>2014&weeklyILI.year<2025,:);

% Seroprevalence data from Thailand
% https://www.ijidonline.com/article/S1201-9712(22)00579-3/fulltext
% age of months, number of samples tested, seropositive %
seroprevData = [
    -1, 302, 0.858, 259, 18, 25, 171, 88;
     0, 291, 0.952, 277, 3, 11, 131, 146;
     2, 281, 0.313, 88, 135, 58, 84, 4;
     7, 258, 0.081, 21, 229, 8, 21, 0;
    18, 264, 0.348, 92, 157, 15, 66, 26;
    19, 262, 0.382, 100, 149, 13, 73, 27;
    24, 236, 0.479, 113, 112, 11, 69, 44;
    36, 233, 0.682, 159, 61, 13, 79, 80;
    48, 235, 0.843, 198, 23, 14, 87, 111;
    60, 216, 0.880, 190, 16, 10, 102, 88];
seroprevData = array2table(seroprevData,...
    "VariableNames",{'age_by_month','num_samples','perc_seropos','num_seropos',...
    'sero_lower_16','sero_16_21','sero_22_100','sero_high_100'});
seroprevData.age_by_year = seroprevData.age_by_month/12;

% Additional seroprevalence data from meta-analysis
seroprevDataMeta = readtable('../0. data/Nakajo_review_paper/RSV_sero.xlsx');
seroprevDataMeta = seroprevDataMeta(~strcmp(seroprevDataMeta.Assay,'CF'),:);

% PHLSB data from CHP website
weeklyLab = readtable('../0. data/Hong_Kong_CHP/weekly_lab_2014_2024.csv');

% 1. Model states
% Subscripts: age, time, number of previous infections
% Number of age groups: 25 age groups were considered, allowing for the dynamics of RSV incidence in infants to be closely monitored
% (age groups: <1, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 months, and 1, 2, 3, 4, 5, 5-9, 10-14, 15-24, 25-34, 35-44, 45-54, 55-64, 65-74, 75+ years).

ageGroupLower = [...
    0, 1/12, 2/12, 3/12, 4/12, 5/12, 6/12, 7/12, 8/12, 9/12, 10/12, 11/12,...
    1, 2, 3, 4, 5, 10, 15, 25, 35, 45, 55, 65, 75];
ageGroupUpper = [...
    1/12, 2/12, 3/12, 4/12, 5/12, 6/12, 7/12, 8/12, 9/12, 10/12, 11/12, 1, ...
    2, 3, 4, 5, 10, 15, 25, 35, 45, 55, 65, 75, 100];
numAgeGroups = length(ageGroupLower);

% State variables
numDays = 365*22;
dt = 0.1;
numTimeSteps = numDays/dt;
% Number of individuals at time t who are completely protected due to maternally derived Ab
stateM = zeros(numTimeSteps,numAgeGroups);
% Number of individuals at time t who are susceptible to acquiring infections, who have experienced i previous infections. 
stateS0 = zeros(numTimeSteps,numAgeGroups);
stateS1 = zeros(numTimeSteps,numAgeGroups);
stateS2 = zeros(numTimeSteps,numAgeGroups);
stateS3 = zeros(numTimeSteps,numAgeGroups);
% Number of individuals at time t who are exposed to RSV, who have experienced i previous infections. 
stateE0 = zeros(numTimeSteps,numAgeGroups);
stateE1 = zeros(numTimeSteps,numAgeGroups);
stateE2 = zeros(numTimeSteps,numAgeGroups);
stateE3 = zeros(numTimeSteps,numAgeGroups);
% Number of individuals at time t who are infected with RSV but with no symptoms, who have experienced i previous infections. 
stateA0 = zeros(numTimeSteps,numAgeGroups);
stateA1 = zeros(numTimeSteps,numAgeGroups);
stateA2 = zeros(numTimeSteps,numAgeGroups);
stateA3 = zeros(numTimeSteps,numAgeGroups);
% Number of individuals at time t who are infected with RSV but with symptoms, who have experienced i previous infections. 
stateI0 = zeros(numTimeSteps,numAgeGroups);
stateI1 = zeros(numTimeSteps,numAgeGroups);
stateI2 = zeros(numTimeSteps,numAgeGroups);
stateI3 = zeros(numTimeSteps,numAgeGroups);
% Number of individuals at time t who are completely protected due to immunity acquired from natural infection
stateR0 = zeros(numTimeSteps,numAgeGroups);
stateR1 = zeros(numTimeSteps,numAgeGroups);
stateR2 = zeros(numTimeSteps,numAgeGroups);
stateR3 = zeros(numTimeSteps,numAgeGroups);
% Cumulative number of new RSV infections at time t
stateZ = zeros(numTimeSteps,numAgeGroups);

% Interventions
% Monoclonal antibodies
stateVmab1 = zeros(numTimeSteps,numAgeGroups);
stateVmab2 = zeros(numTimeSteps,numAgeGroups);
% Maternal vaccination
stateVmvax1 = zeros(numTimeSteps,numAgeGroups);
stateVmvax2 = zeros(numTimeSteps,numAgeGroups);
% Individual vaccination
stateVpvax1 = zeros(numTimeSteps,numAgeGroups);
stateVpvax2 = zeros(numTimeSteps,numAgeGroups);

% Interventions
% Proportion of newborns completely protected by mAb = uptake x effectiveness
probVmAb = 0;
% Proportion of individuals completely protected by vaccination = uptake x effectiveness
probVvax = zeros(numTimeSteps,numAgeGroups);
probVvax(:,(end-1):end) = 0;

% 1. (Fixed parameters) that are not included in Table 1
% Load contact matrix data
% Contact matrix countries
SKINCONTACT = 1;
CONVERSATIONCONTACT = 2;
% 1. Demographics
% Hong Kong population
populationSizeTable = readtable('../0. data/2024_12_27_age_distr_HK.csv');
populationSize = populationSizeTable(:,[1,2,3,4]);
countryText = 'hongkong';
refCountryText = 'Hong Kong';
% Define age groups
ageGroupDefRangeAll = [ageGroupLower,ageGroupUpper(end)];
ageGroupDefRangeUse = unique(round(ageGroupDefRangeAll));
numUnderAge1 = length(ageGroupDefRangeAll)-length(ageGroupDefRangeUse);
if strcmp(refCountryText,'Hong Kong')
    % Define age groups
    ageGroupDefRange = ageGroupDefRangeUse;
    totalPop = sum(populationSize.population_count);
    ageDistributionFiveyear =  loadAgeDistrCensus(refCountryText);
    [refContactMatrSkin,~] = polymodHKcontactMatrix(ageGroupDefRange,ageDistributionFiveyear,totalPop,SKINCONTACT);
    [refContactMatrConversation,~] = polymodHKcontactMatrix(ageGroupDefRange,ageDistributionFiveyear,totalPop,CONVERSATIONCONTACT);
end
refContactMatrSkin(refContactMatrSkin==0) = 1e-7;
refContactMatrConversation(refContactMatrConversation==0) = 1e-7;
if strcmp(countryText,'hongkong')
    dataDir = '../0. data/HK_social_contact_survey/';
    countryText = 'hongkong';
    totalPopulation = sum(populationSize.population_count);
    ageGroupDefRange = ageGroupDefRangeUse;
    % Age distribution
    ageDistrTemp = readmatrix([dataDir,'hongkong_age_distribution_prem_all_80.csv']);
    totalPop = totalPopulation;
    ageDistributionOneyear =  ageDistrTemp(:,2)/sum(ageDistrTemp(:,2));
    % Contact matrix by setting
    overallMatr = readmatrix([dataDir,'hongkong_contact_matrix_prem_all.csv']);

    [overallMatr,ageDistribution] = polymodContactMatrix(ageGroupDefRange,overallMatr,ageDistributionOneyear,totalPop);
    contactMatrSkin = overallMatr*(refContactMatrSkin./(refContactMatrSkin+refContactMatrConversation));
    contactMatrConversation = overallMatr*(refContactMatrConversation./(refContactMatrSkin+refContactMatrConversation));
    ageDistribution = ageDistribution/sum(ageDistribution);
    totalPopulation = totalPop*ageDistribution;
    totalPopulationAgeBand = totalPopulation;  
end

% Adjust for under 1
% Skin
contactMatrSkinAll = zeros(length(ageGroupDefRangeAll)-1);
contactMatrSkinAll((numUnderAge1+2):end,(numUnderAge1+2):end) = contactMatrSkin(2:end,2:end);
contactMatrSkinAll(1:(numUnderAge1+1),1:(numUnderAge1+1)) = contactMatrSkin(1)/((numUnderAge1+1)*(numUnderAge1+1));
contactMatrSkinAll(1:(numUnderAge1+1),(numUnderAge1+2):end) = repmat(contactMatrSkin(1,2:end)/(numUnderAge1+1),numUnderAge1+1,1);
contactMatrSkinAll((numUnderAge1+2):end,1:(numUnderAge1+1)) = repmat(contactMatrSkin(2:end,1)/(numUnderAge1+1),1,numUnderAge1+1);
% Conversation
contactMatrConversationAll = zeros(length(ageGroupDefRangeAll)-1);
contactMatrConversationAll((numUnderAge1+2):end,(numUnderAge1+2):end) = contactMatrConversation(2:end,2:end);
contactMatrConversationAll(1:(numUnderAge1+1),1:(numUnderAge1+1)) = contactMatrConversation(1)/((numUnderAge1+1)*(numUnderAge1+1));
contactMatrConversationAll(1:(numUnderAge1+1),(numUnderAge1+2):end) = repmat(contactMatrConversation(1,2:end)/(numUnderAge1+1),numUnderAge1+1,1);
contactMatrConversationAll((numUnderAge1+2):end,1:(numUnderAge1+1)) = repmat(contactMatrConversation(2:end,1)/(numUnderAge1+1),1,numUnderAge1+1);
% Population
totalPopulation = [repmat(totalPopulation(1)/(numUnderAge1+1),1,(numUnderAge1+1)),totalPopulation(2:end)];

% Aging rate from age group a to age group a+1
% Census: https://www.censtatd.gov.hk/en/EIndexbySubject.html?scode=160&pcode=FA100094
% etaMortalityRate = 1/85/365.25*(ageGroupDefRangeAll(2:end)-ageGroupDefRangeAll(1:(end-1)));
populationSizeTableRev= [];
populationSizeTableRev(:,1) = ageGroupDefRangeAll(1:(end-1));
populationSizeTableRev(:,2) = ageGroupDefRangeAll(2:end);
populationSizeTableRev(:,3) = totalPopulation;
populationSizeTableRev = array2table(populationSizeTableRev,"VariableNames",{'age_group_start','age_group_end','population_count'});

% Daily number of live births
% mu1 = round(totalPopulation(1)/365.25);
% mu2 = round(sum(totalPopulation)/85/365.25);
% muBirthRate = round((mu1+mu2)/2);
% Census: https://www.censtatd.gov.hk/en/scode160.html
muBirthRate(1) = populationSize.population_count(1)/4/365.25; 
% muBirthRate(1) = 205; % UK level
muBirthRate(2) = 0;

% Total number of daily physical contacts made by age group a with age group b
phyContactMatr = contactMatrSkinAll;
% Total number of daily conversational contacts made by age group a with age group b
conversationContactMatr = contactMatrConversationAll;

% Initial condition
dateZero = datetime('2004-01-01','Format','yyyy-MM-dd');
dateStart =  days(datetime('2004-05-01','Format','yyyy-MM-dd')-dateZero);

% Reformat dates in the data
weeklyILI.week_start_rev = days(datetime(weeklyILI.week_start)-dateZero);
weeklyILI.week_end_rev = days(datetime(weeklyILI.week_end)-dateZero);
weeklyLab.week_start = days(datetime(weeklyLab.week_start)-dateZero);
weeklyLab.week_end = days(datetime(weeklyLab.week_end)-dateZero);
monthlyCaseRSV.month_start = days(datetime(monthlyCaseRSV.year, monthlyCaseRSV.month, 15*ones(size(monthlyCaseRSV.year)))-dateZero);
monthlyCaseRSV.month_end = days(datetime(monthlyCaseRSV.year, monthlyCaseRSV.month+1, 15*ones(size(monthlyCaseRSV.year)))-dateZero)-1;

% Select data till Jan 23 2020
cutoffCOVID = days(datetime('2020-01-23','Format','uuuu-MM-dd')-dateZero);
% Find indices for monthly RSV data
[~, indicesMonthlyRSV] = ismember(ageDefMonthlyRSV, ageGroupDefRangeAll);
% Find indices for seroprevalence data
[~, indicesSeroPreg] = ismember([25,35],ageGroupDefRangeAll);
revAgeSero = seroprevData.age_by_month(seroprevData.age_by_month>0)/12;
revAgeSero(revAgeSero>1 & revAgeSero<2) = 1;
[~, indicesSeroAge] = ismember(revAgeSero,ageGroupDefRangeAll);
indicesSeroAge = indicesSeroAge-1;
% Find indices for seroprevalence data meta
indicesSeroAgeMeta = zeros(length(seroprevDataMeta.ageStart),length(ageGroupDefRangeAll)-1);
for iiMeta = 1:length(seroprevDataMeta.ageStart)
    temp = find(ageGroupDefRangeAll>=seroprevDataMeta.ageStart(iiMeta)&ageGroupDefRangeAll<=seroprevDataMeta.ageEnd(iiMeta));
    temp = temp-1;
    if isempty(temp) || any(temp==0)
        temp = find(seroprevDataMeta.ageStart(iiMeta)>=ageGroupDefRangeAll, 1, 'last' );
    end
    indicesSeroAgeMeta(iiMeta,1:length(temp)) = temp;
end

% 2. MCMC parameters
maxIter = 1000;
mcmcRes = readmatrix('../38. RSV c mex more data no ILI proxy Hong Kong adj rep prem matrix HK sero/mcmc_result/hongkong_mcmc_res.csv');
mcmcRes = mcmcRes(mcmcRes(:,1)~=0,:);
mcmcRes = mcmcRes(length(mcmcRes(:,1))*0.2:end,:);

% % Posterior
% for iiParms = 1:length(mcmcRes(1,:))
%     figure(1)
%     subplot(5,6,iiParms)
%     plot(mcmcRes(:,iiParms))
% 
%     figure(2)
%     subplot(5,6,iiParms)
%     histogram(mcmcRes(:,iiParms))
% end
% 
% % Parameter estimates
% disp(prctile(1./mcmcRes(:,1:4),[50,2.5,97.5]));
% disp(prctile(mcmcRes,[50,2.5,97.5])');
% parmPosterior = prctile(mcmcRes,[50,2.5,97.5])';

% Disease burden
dateStartArr = [
    days(datetime('2014-01-01','Format','yyyy-MM-dd')-dateZero),...
    days(datetime('2015-01-01','Format','yyyy-MM-dd')-dateZero),...
    days(datetime('2016-01-01','Format','yyyy-MM-dd')-dateZero),...
    days(datetime('2017-01-01','Format','yyyy-MM-dd')-dateZero),...
    days(datetime('2018-01-01','Format','yyyy-MM-dd')-dateZero),...
    days(datetime('2019-01-01','Format','yyyy-MM-dd')-dateZero)];
dateEndArr = [
    days(datetime('2014-12-31','Format','yyyy-MM-dd')-dateZero),...
    days(datetime('2015-12-31','Format','yyyy-MM-dd')-dateZero),...
    days(datetime('2016-12-31','Format','yyyy-MM-dd')-dateZero),...
    days(datetime('2017-12-31','Format','yyyy-MM-dd')-dateZero),...
    days(datetime('2018-12-31','Format','yyyy-MM-dd')-dateZero),...
    days(datetime('2019-12-31','Format','yyyy-MM-dd')-dateZero)];

% Pre-allocate arrays for storing results before the loop
numIterations = size(mcmcRes(mcmcRes(:,1)~=0,1), 1);
% Determine dimensions for pre-allocation from first iteration
x0_test = mcmcRes(1,:);
test_output = mcmcRes_RSV(x0_test, ... 
    weeklyILI,weeklyLab,monthlyCaseRSV,indicesMonthlyRSV,...
    seroprevData,indicesSeroPreg,indicesSeroAge,...
    seroprevDataMeta,indicesSeroAgeMeta,...
    stateM, stateS0, stateS1, stateS2, stateS3, stateE0, stateE1, stateE2, stateE3,...
    stateI0, stateI1, stateI2, stateI3, stateA0, stateA1, stateA2, stateA3,...
    stateR0, stateR1, stateR2, stateR3, stateZ, probVmAb, probVvax,...
    totalPopulation, ageGroupDefRangeAll, muBirthRate,populationSizeTable,populationSizeTableRev,...
    phyContactMatr, conversationContactMatr, dateZero,dateStart,cutoffCOVID, numDays, numTimeSteps, dt);


% 8. Impact of interventions
numRnd = 1;
revNumIterations = numRnd;

% mAb
coeffVar = (37-16)/2/1.96/25;
mAbCoverage = 0.25*ones([numRnd,1]);
mAbCoverage(mAbCoverage<0) = 0;
mAbEffectiveness = 0.01*normrnd(77.3,(89.7-50.3)/2/1.96,[numRnd,1]);
mAbEffectiveness(mAbEffectiveness<0) = 1e-6;
mAbEffectiveness(mAbEffectiveness>1) = 1-1e-6;
% Solve
mAbShape = 2;
tempX = 180;
mAbScale = tempX./gaminv((1-mAbEffectiveness), mAbShape, 1);
% gaminv(0,...) is 0, so mAbEffectiveness=0 leads to 0/0=NaN. Replace with Inf.
mAbScale(isnan(mAbScale)) = Inf;
mAbDuration = mAbShape.*mAbScale;

% maternal vaccination
mVaxCoverage = 0.01*normrnd(38.5,coeffVar*38.5,[numRnd,1]);
mVaxCoverage(mVaxCoverage<0) = 0;
mVaxEffectiveness = 0.01*normrnd(69.4,(84.1-44.3)/2/1.96,[numRnd,1]);
mVaxEffectiveness(mVaxEffectiveness<0) = 1e-6;
mVaxEffectiveness(mVaxEffectiveness>1) = 1-1e-6;
% Solve
mVaxShape = 2;
tempX = 180;
mVaxScale = tempX./gaminv(1-mVaxEffectiveness, mVaxShape, 1);
mVaxScale(isnan(mVaxScale)) = Inf;
mVaxDuration = mVaxShape.*mVaxScale;

% elderly vaccination
oVaxCoverage = [...
    0.01*normrnd(31.4/2,coeffVar*31.4/2,[numRnd,1]),...
    0.01*normrnd(31.4,coeffVar*31.4,[numRnd,1]),...
    0.01*normrnd(39.7,coeffVar*39.7,[numRnd,1])];
oVaxCoverage(oVaxCoverage<0) = 0;
oVaxEffectiveness = 0.01*normrnd(80,(85-71)/2/1.96,[numRnd,1]);
oVaxEffectiveness(oVaxEffectiveness<0) = 1e-6;
oVaxEffectiveness(oVaxEffectiveness>1) = 1-1e-6;
% Solve
oVaxShape = 2;
tempX = 180;
oVaxScale = tempX./gaminv(1-oVaxEffectiveness, oVaxShape, 1);
oVaxScale(isnan(oVaxScale)) = Inf;
oVaxDuration = oVaxShape.*oVaxScale;

% Pre-allocate arrays based on first run dimensions
mcRecMonthlyByAge = zeros(size(test_output.monthlyReportByAge, 1), size(test_output.monthlyReportByAge, 2), revNumIterations);
mcRecSerology = zeros(size(test_output.allStateRByAgeUse, 1), revNumIterations);
mcRecSerologyMeta = zeros(size(test_output.allStateRMetaUse, 1), revNumIterations);
numUsedAgeGroup = size(test_output.monthlyReportByAge,2);
numAgeGroup = length(totalPopulation);
yearlyAgeSpecificIncNoIntervention = zeros(length(dateStartArr),numUsedAgeGroup,revNumIterations,6);
yearlyAgeSpecificIncWithIntervention = zeros(length(dateStartArr),numUsedAgeGroup,revNumIterations,6);
yearlyAgeSpecificReportOutcome = zeros(length(dateStartArr),numAgeGroup,revNumIterations,6);
yearlyAgeSpecificReportOutcomeRate = zeros(length(dateStartArr),numAgeGroup,revNumIterations,6);

% Intervention
for kkStrategy = 1:6
    if kkStrategy == 1
        % Strategy 1: mAb only
        mAbCoverageIter = zeros([numAgeGroup,1]);
        mAbEffectivenessIter = zeros([numAgeGroup,1]);
        mAbCoverageIter(1:6,1) = randsample(mAbCoverage,1);
        mAbEffectivenessIter(1:6,1) = 1;
        mVaxCoverageIter = zeros([numAgeGroup,1]);
        mVaxEffectivenessIter = zeros([numAgeGroup,1]);
        oVaxCoverageIter = zeros([numAgeGroup,1]);
        oVaxEffectivenessIter = zeros([numAgeGroup,1]);
    else
        if kkStrategy == 2
            % Strategy 2: mVax only
            mAbCoverageIter = zeros([numAgeGroup,1]);
            mAbEffectivenessIter = zeros([numAgeGroup,1]);
            mVaxCoverageIter = zeros([numAgeGroup,1]);
            mVaxEffectivenessIter = zeros([numAgeGroup,1]);
            mVaxCoverageIter(1:6,1) = randsample(mVaxCoverage,1);
            mVaxEffectivenessIter(1:6,1) = 1;
            oVaxCoverageIter = zeros([numAgeGroup,1]);
            oVaxEffectivenessIter = zeros([numAgeGroup,1]);
        else 
            if kkStrategy == 3
                % Strategy 3: oVax only
                mAbCoverageIter = zeros([numAgeGroup,1]);
                mAbEffectivenessIter = zeros([numAgeGroup,1]);
                mVaxCoverageIter = zeros([numAgeGroup,1]);
                mVaxEffectivenessIter = zeros([numAgeGroup,1]);
                oVaxCoverageIter = zeros([numAgeGroup,1]);
                oVaxEffectivenessIter = zeros([numAgeGroup,1]);
                oVaxCoverageIter((end-2):end,1) = oVaxCoverage(randsample(numRnd,1),:);
                oVaxEffectivenessIter((end-2):end,1) = 1;
            else
                if kkStrategy == 4
                    % Strategy 4: mAb + oVax
                    mAbCoverageIter = zeros([numAgeGroup,1]);
                    mAbEffectivenessIter = zeros([numAgeGroup,1]);
                    mAbCoverageIter(1:6,1) = randsample(mAbCoverage,1);
                    mAbEffectivenessIter(1:6,1) = 1;
                    mVaxCoverageIter = zeros([numAgeGroup,1]);
                    mVaxEffectivenessIter = zeros([numAgeGroup,1]);
                    oVaxCoverageIter = zeros([numAgeGroup,1]);
                    oVaxEffectivenessIter = zeros([numAgeGroup,1]);
                    oVaxCoverageIter((end-2):end,1) = oVaxCoverage(randsample(numRnd,1),:);
                    oVaxEffectivenessIter((end-2):end,1) = 1;
                else
                    if kkStrategy == 5
                        % Strategy 5: mVax + oVax
                        mAbCoverageIter = zeros([numAgeGroup,1]);
                        mAbEffectivenessIter = zeros([numAgeGroup,1]);
                        mVaxCoverageIter = zeros([numAgeGroup,1]);
                        mVaxEffectivenessIter = zeros([numAgeGroup,1]);
                        mVaxCoverageIter(1:6,1) = randsample(mVaxCoverage,1);
                        mVaxEffectivenessIter(1:6,1) = 1;
                        oVaxCoverageIter = zeros([numAgeGroup,1]);
                        oVaxEffectivenessIter = zeros([numAgeGroup,1]);
                        oVaxCoverageIter((end-2):end,1) = oVaxCoverage(randsample(numRnd,1),:);
                        oVaxEffectivenessIter((end-2):end,1) = 1;
                    else 
                        if kkStrategy == 6
                            % Strategy 6: mAb + mVax + oVax
                            mAbCoverageIter = zeros([numAgeGroup,1]);
                            mAbEffectivenessIter = zeros([numAgeGroup,1]);
                            mAbCoverageIter(1:6,1) = randsample(mAbCoverage,1);
                            mAbEffectivenessIter(1:6,1) = 1;
                            mVaxCoverageIter = zeros([numAgeGroup,1]);
                            mVaxEffectivenessIter = zeros([numAgeGroup,1]);
                            mVaxCoverageIter(1:6,1) = randsample(mVaxCoverage,1);
                            mVaxEffectivenessIter(1:6,1) = 1;
                            oVaxCoverageIter = zeros([numAgeGroup,1]);
                            oVaxEffectivenessIter = zeros([numAgeGroup,1]);
                            oVaxCoverageIter((end-2):end,1) = oVaxCoverage(randsample(numRnd,1),:);
                            oVaxEffectivenessIter((end-2):end,1) = 1;
                        end
                    end
                end
            end
        end
    end

    mAbCoverageIter = mAbCoverageIter';
    mAbEffectivenessIter = mAbEffectivenessIter';
    mVaxCoverageIter = mVaxCoverageIter';
    mVaxEffectivenessIter = mVaxEffectivenessIter';
    oVaxCoverageIter = oVaxCoverageIter';
    oVaxEffectivenessIter = oVaxEffectivenessIter';

    for iiIter = 1:revNumIterations
        x0 = mcmcRes(iiIter,:);
        yearlyAgeSpecificIARIter = zeros(length(dateStartArr),numUsedAgeGroup,1);
        disp(iiIter)
        iterOutput = mcmcRes_RSV_intervention(x0,...
            weeklyILI,weeklyLab,monthlyCaseRSV,indicesMonthlyRSV,...
            seroprevData,indicesSeroPreg,indicesSeroAge,...
            seroprevDataMeta,indicesSeroAgeMeta,...
            stateM, stateS0, stateS1, stateS2, stateS3, stateE0, stateE1, stateE2, stateE3,...
            stateI0, stateI1, stateI2, stateI3, stateA0, stateA1, stateA2, stateA3,...
            stateR0, stateR1, stateR2, stateR3, stateZ,...
            stateVmab1,stateVmab2,stateVmvax1,stateVmvax2,stateVpvax1,stateVpvax2,...
            totalPopulation, ageGroupDefRangeAll, muBirthRate,populationSizeTable,populationSizeTableRev,...
            phyContactMatr, conversationContactMatr, dateZero,dateStart,cutoffCOVID, numDays, numTimeSteps, dt,...
            mAbCoverageIter,mAbEffectivenessIter,mAbDuration(iiIter),...
            mVaxCoverageIter,mVaxEffectivenessIter,mVaxDuration(iiIter),...
            oVaxCoverageIter,oVaxEffectivenessIter,oVaxDuration(iiIter));
        
        yearlyAgeSpecificIncNoInterventionIter = zeros(length(dateStartArr),numUsedAgeGroup);
        yearlyAgeSpecificIncWithInterventionIter = zeros(length(dateStartArr),numUsedAgeGroup);

        yearlyAgeSpecificOutcomeIter = zeros(length(dateStartArr),numAgeGroup);
        yearlyAgeSpecificOutcomeIterRate = zeros(length(dateStartArr),numAgeGroup);

        for jjYear = 1:length(dateStartArr)
            % Get date range indices for current year
            dateRange = dateStartArr(jjYear):dateEndArr(jjYear);
            % Calculate yearly age-specific IAR
            % Convert dateRange to row vector of positive integers
            dateRangeRow = reshape(dateRange, 1, []);
            % Incidence
            yearlyAgeSpecificIncNoInterventionIter(jjYear,:) = sum(iterOutput.dailyAgeSpecificIncidenceGroup_no_intervention(dateRangeRow,:),1);
            yearlyAgeSpecificIncWithInterventionIter(jjYear,:) = sum(iterOutput.dailyAgeSpecificIncidenceGroup_intervention(dateRangeRow,:),1);
            % Calculate sum over date range and normalize by population
            yearlyAgeSpecificOutcomeIter(jjYear,:) = sum(iterOutput.dailyAgeSpecificIncidenceReportInterventionAverted(dateRangeRow,:),1);
            % Calculate sum over date range and normalize by population
            yearlyAgeSpecificOutcomeIterRate(jjYear,:) = sum(iterOutput.dailyAgeSpecificIncidenceReportInterventionAverted(dateRangeRow,:),1)./totalPopulation;
        end
        % Incidence
        yearlyAgeSpecificIncNoIntervention(:,:,iiIter,kkStrategy) = yearlyAgeSpecificIncNoInterventionIter;
        yearlyAgeSpecificIncWithIntervention(:,:,iiIter,kkStrategy) = yearlyAgeSpecificIncWithInterventionIter;
        % Reported outcomes
        yearlyAgeSpecificReportOutcome(:,:,iiIter,kkStrategy) = yearlyAgeSpecificOutcomeIter;
        yearlyAgeSpecificReportOutcomeRate(:,:,iiIter,kkStrategy) = yearlyAgeSpecificOutcomeIterRate;
    end
end
