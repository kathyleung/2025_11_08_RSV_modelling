
% 2024-12-28
% RSV model adapted from David Hodgson's BMC Medicine paper
clearvars;

% Check if MEX file exists and is accessible
if ~exist('age_SEIR_RSV_mex', 'file')
    error('MEX file age_SEIR_RSV_mex not found in MATLAB path');
end

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

% Additional seroprevalence data from the meta-analysis
seroprevDataMeta = readtable('../0. data/Nakajo_review_paper/RSV_sero.xlsx');
seroprevDataMeta = seroprevDataMeta(~strcmp(seroprevDataMeta.Assay,'CF'),:);

% New ELISA data from HK
seroprevDataHK = readtable('../0. data/Hong_Kong_serology_CC/250813CC RSV-F IgG data cutoff.xlsx');
% HK Seroprevalence Data
ageStartHK = [0,1,2,5,10,15,20,40,60];
ageEndHK = [1,2,5,10,15,20,40,60,80];
for iiIdx = 1:length(seroprevDataHK.age_atFirstSampleCollectionDate_)
    seroprevDataHK.age_start(iiIdx) = ageStartHK(...
        seroprevDataHK.age_atFirstSampleCollectionDate_(iiIdx)>=ageStartHK & ...
        seroprevDataHK.age_atFirstSampleCollectionDate_(iiIdx)<ageEndHK);
    seroprevDataHK.age_end(iiIdx) = ageEndHK(...
        seroprevDataHK.age_atFirstSampleCollectionDate_(iiIdx)>=ageStartHK & ...
        seroprevDataHK.age_atFirstSampleCollectionDate_(iiIdx)<ageEndHK);
end
seroprevDataHKRec = zeros(length(ageStartHK),4);
for iiAge = 1:length(ageStartHK)
    seroprevDataHKRec(iiAge,1) = ageStartHK(iiAge);
    seroprevDataHKRec(iiAge,2) = ageEndHK(iiAge);
    seroprevDataHKRec(iiAge,3) = sum(seroprevDataHK.age_start==ageStartHK(iiAge) & seroprevDataHK.age_end==ageEndHK(iiAge));
    seroprevDataHKRec(iiAge,4) = sum(seroprevDataHK.age_start==ageStartHK(iiAge) & seroprevDataHK.age_end==ageEndHK(iiAge) & seroprevDataHK.RSVIgG_positive==1);
end
seroprevDataHKRec = array2table(seroprevDataHKRec,'VariableNames',{'age_start','age_end','num_samples','num_IgG_positive'});

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
% Proportion of newborns completely protected by mAb = uptake x effectiveness
probVmAb = 0;
% Proportion of individuals completely protected by vaccination = uptake x effectiveness
probVvax = zeros(numTimeSteps,numAgeGroups);
probVvax(:,(end-1):end) = 0;

% Parameters in Table 1 (to be estimated)
% Average duration of maternally derived immunity (days)
xiMaternalImmunity = 1/134;
% Average duration of post-infection immunity (days)
omegaInfectionImmunity = 1/359;
% Average duration of exposure (days)
sigmaExposure = 1/3.5;
% Average duration of primary infection (days)
gammaZeroPrimaryInfection = 1/6;
% Decrease in secondary infection duration relative to primary
g1ReductionInfectiousDuration = 0.87;
% Decrease in subsequent infection duration relative to secondary
g2ReductionInfectiousDuration = 0.79;
% Susceptibility
% Secondary infection relative to primary
delta1RelSuscep = 0.89;
% 3rd infection relative to 2nd
delta2RelSuscep = 0.81;
% Subsequent infections relative to 3rd
delta3RelSuscep = 0.33;
% Proportion asymptomatic (<1 yr, 1-4 yr, 5-14 yr, and 15+ yr)
pAsym = [0.09, 0.16, 0.52, 0.75];
% Relative reduction in infectiousness for asymptomatic infections
alphaReductionInfectiousness = 0.63;
% Probability of RSV transmission per physical contact
qTransmissPhysical = 0.0015;
% Relative reduction in probability of RSV transmission per conversational contact compared to physical contact
qTransmissConversation = 0.95;
% Relative amplitude of transmission during peak
b1AmpTransmissPeak = 3;
% Seasonal shift in transmission
phiSeasonalShift = 0.75;
% Seasonal wavelength constant
psiSeasonalWavelength = 0.6;
% Seed
% Initial proportion (at t = 0) of people who are infected (i.e. in epidemiological compartments E, I or A) with RSV
iniInfectiousProp = 1e-6;
% Initial proportion (at t = 0) of people who not-infected but are protected (in epidemiological compartment R) from RSV
iniRecoveredProp = 1e-6;

% Probability that an RSV infection is reported (0-4 yr; 5-54 yr; 55-74 yr, 75 or above)
expReport = [-4.6, -0.233, 0.85];
% epsilonReportArr = exp(expReport(1)+expReport(2)*0:(4/12):5);
epsilonReport17 = 33*10^-5;
epsilonReport18 = 60.7*10^-5;
epsilonReport19 = 80.7*10^-5;

% Seropositive probability of RSV infected S E I A individuals 
probSeropos = 0.75;

% 2. (Fixed parameters) that are not included in Table 1
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
% Find indices for seroprevalence data meta
indicesSeroAgeMeta = zeros(length(seroprevDataMeta.ageStart),length(ageGroupDefRangeAll)-1);
for iiMeta = 1:length(seroprevDataMeta.ageStart)
    temp = find(ageGroupDefRangeAll>=seroprevDataMeta.ageStart(iiMeta)&ageGroupDefRangeAll<seroprevDataMeta.ageEnd(iiMeta));
    if isempty(temp)
        temp = find(seroprevDataMeta.ageStart(iiMeta)>=ageGroupDefRangeAll, 1, 'last' );
    end
    indicesSeroAgeMeta(iiMeta,1:length(temp)) = temp;
end
% Find indices for HK local data
indicesSeroAgeHK = zeros(length(seroprevDataHKRec.age_start),length(ageGroupDefRangeAll)-1);
for iiHK = 1:length(seroprevDataHKRec.age_start)
    temp = find(ageGroupDefRangeAll>=seroprevDataHKRec.age_start(iiHK)&ageGroupDefRangeAll<seroprevDataHKRec.age_end(iiHK));
    if isempty(temp)
        temp = find(seroprevDataHKRec.age_start(iiHK)>=ageGroupDefRangeAll, 1, 'last' );
    end
    indicesSeroAgeHK(iiHK,1:length(temp)) = temp;
end

% 2. MCMC parameters
maxIter = 1000;

mcmcRes = readmatrix('../1. RSV c mex Hong Kong R1 rev block update logL component rev/mcmc_result/hongkong_mcmc_res.csv');
% mcmcRes = readmatrix('../2. RSV c mex Hong Kong R1 rev block update logL component no sero/mcmc_result/hongkong_mcmc_res.csv');
% mcmcRes = readmatrix('../3. RSV c mex Hong Kong R1 rev block update logL component region sero/mcmc_result/hongkong_mcmc_res.csv');

mcmcRes = mcmcRes(mcmcRes(:,1)~=0,:);
mcmcRes = mcmcRes((length(mcmcRes(:,1))*0.1):1:end,:);

% Posterior
for iiParms = 1:length(mcmcRes(1,:))
    figure(1)
    subplot(5,6,iiParms)
    plot(mcmcRes(:,iiParms))

    figure(2)
    subplot(5,6,iiParms)
    histogram(mcmcRes(:,iiParms))
end

% Parameter estimates
disp(prctile(1./mcmcRes(:,1:4),[50,2.5,97.5]));
disp(prctile(mcmcRes,[50,2.5,97.5])');
parmPosterior = prctile(mcmcRes,[50,2.5,97.5])';

% Contribution of loglikelihood component
mcmcLogL = readmatrix('../1. RSV c mex Hong Kong R1 rev block update logL component rev/mcmc_result/hongkong_log_likelihood_component.csv');
mcmcLogL = mcmcLogL(mcmcLogL(:,1)~=0,:);
mcmcLogLComponent = mcmcLogL(:,3:end);
mcmcLogLComponentPrctile = prctile(mcmcLogLComponent,[50,2.5,97.5]);
mcmcLogLComponentPercent = mcmcLogL(:,3:end)./repmat(sum(mcmcLogL(:,3:end),2),1,5);
mcmcLogLComponentPercentPrctile = prctile(mcmcLogLComponentPercent,[50,2.5,97.5]);


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
    seroprevDataHKRec,indicesSeroAgeHK,...
    stateM, stateS0, stateS1, stateS2, stateS3, stateE0, stateE1, stateE2, stateE3,...
    stateI0, stateI1, stateI2, stateI3, stateA0, stateA1, stateA2, stateA3,...
    stateR0, stateR1, stateR2, stateR3, stateZ, probVmAb, probVvax,...
    totalPopulation, ageGroupDefRangeAll, muBirthRate,populationSizeTable,populationSizeTableRev,...
    phyContactMatr, conversationContactMatr, dateZero,dateStart,cutoffCOVID, numDays, numTimeSteps, dt);

% Use parfor for parallel processing if Parallel Computing Toolbox is available
if numIterations <= maxIter
    rndSample = mcmcRes;
else
    rndSample = mcmcRes(randperm(numIterations, maxIter),:);
end
revNumIterations = size(rndSample, 1);

% % Pre-allocate arrays based on first run dimensions
% mcRecWeekly = zeros(size(test_output.weeklyReport, 1), revNumIterations);
% mcRecWeeklyIncidence = zeros(size(test_output.weeklyReport, 1), revNumIterations);
% mcRecMonthlyByAge = zeros(size(test_output.monthlyReportByAge, 1), size(test_output.monthlyReportByAge, 2), revNumIterations);
% mcRecMonthlyReportIncidence = zeros(size(test_output.monthlyReportByAge, 1), revNumIterations);
% mcRecSerology = zeros(size(test_output.allStateRByAgeUse, 1), revNumIterations);
% mcRecSerologyMeta = zeros(size(test_output.allStateRMetaUse, 1), revNumIterations);
% mcRecSerologyHK = zeros(size(test_output.allStateRHKUse, 1), revNumIterations);
% mcEpsilonByAge = zeros(revNumIterations,length(totalPopulation));
% yearlyAgeSpecificIAR = zeros(length(dateStartArr),size(test_output.monthlyReportByAge, 2),revNumIterations);
% mcStateR0 = zeros(revNumIterations,length(dateStartArr));
% mcStateR1 = zeros(revNumIterations,length(dateStartArr));
% mcStateR2 = zeros(revNumIterations,length(dateStartArr));
% mcStateR3 = zeros(revNumIterations,length(dateStartArr));
% parfor iiIter = 1:revNumIterations
%     x0 = mcmcRes(iiIter,:);
%     yearlyAgeSpecificIARIter = zeros(length(dateStartArr),size(test_output.monthlyReportByAge, 2),1);
%     mcStateR0Iter = zeros(length(dateStartArr),1);
%     mcStateR1Iter = zeros(length(dateStartArr),1);
%     mcStateR2Iter = zeros(length(dateStartArr),1);
%     mcStateR3Iter = zeros(length(dateStartArr),1);
%     disp(iiIter)
%     iterOutput = mcmcRes_RSV(x0,...
%         weeklyILI,weeklyLab,monthlyCaseRSV,indicesMonthlyRSV,...
%         seroprevData,indicesSeroPreg,indicesSeroAge,...
%         seroprevDataMeta,indicesSeroAgeMeta,...
%         seroprevDataHKRec,indicesSeroAgeHK,...
%         stateM, stateS0, stateS1, stateS2, stateS3, stateE0, stateE1, stateE2, stateE3,...
%         stateI0, stateI1, stateI2, stateI3, stateA0, stateA1, stateA2, stateA3,...
%         stateR0, stateR1, stateR2, stateR3, stateZ, probVmAb, probVvax,...
%         totalPopulation, ageGroupDefRangeAll, muBirthRate,populationSizeTable,populationSizeTableRev,...
%         phyContactMatr, conversationContactMatr, dateZero,dateStart,cutoffCOVID, numDays, numTimeSteps, dt);
% 
%     mcRecWeekly(:,iiIter) = iterOutput.weeklyReport;
%     mcRecWeeklyIncidence(:,iiIter) = iterOutput.weeklyIncidence;
%     mcRecMonthlyByAge(:,:,iiIter) = iterOutput.monthlyReportByAge;
%     mcRecMonthlyReportIncidence(:,iiIter) = iterOutput.monthlyReportIncidence;
%     mcRecSerology(:,iiIter) = iterOutput.allStateRByAgeUse;
%     mcRecSerologyMeta(:,iiIter) = iterOutput.allStateRMetaUse;
%     mcRecSerologyHK(:,iiIter) = iterOutput.allStateRHKUse;
%     mcEpsilonByAge(iiIter,:) = iterOutput.epsilonByAge;
%     populationAgeGroup(iiIter,:) = iterOutput.populationAgeGroup;
% 
%     for jjYear = 1:length(dateStartArr)
%         % Get date range indices for current year
%         dateRange = dateStartArr(jjYear):dateEndArr(jjYear);
%         % Calculate yearly age-specific IAR
%         % Convert dateRange to row vector of positive integers
%         dateRangeRow = reshape(dateRange, 1, []);
%         % Calculate sum over date range and normalize by population
%         yearlyAgeSpecificIARIter(jjYear,:) = sum(iterOutput.dailyAgeSpecificIncidenceGroup(dateRangeRow,:),1)./iterOutput.populationAgeGroup;
%         % Average age of infection
%         mcStateR0Iter(jjYear) = sum(iterOutput.outSEIR.stateR0(dateRangeRow,:),1)*(ageGroupDefRangeAll(1:(end-1))')/sum(sum(iterOutput.outSEIR.stateR0(dateRangeRow,:),1));
%         mcStateR1Iter(jjYear) = sum(iterOutput.outSEIR.stateR1(dateRangeRow,:),1)*(ageGroupDefRangeAll(1:(end-1))')/sum(sum(iterOutput.outSEIR.stateR1(dateRangeRow,:),1));
%         mcStateR2Iter(jjYear) = sum(iterOutput.outSEIR.stateR2(dateRangeRow,:),1)*(ageGroupDefRangeAll(1:(end-1))')/sum(sum(iterOutput.outSEIR.stateR2(dateRangeRow,:),1));
%         mcStateR3Iter(jjYear) = sum(iterOutput.outSEIR.stateR3(dateRangeRow,:),1)*(ageGroupDefRangeAll(1:(end-1))')/sum(sum(iterOutput.outSEIR.stateR3(dateRangeRow,:),1));
%     end
%     yearlyAgeSpecificIAR(:,:,iiIter) = yearlyAgeSpecificIARIter;
%     mcStateR0(iiIter,:) = mcStateR0Iter';
%     mcStateR1(iiIter,:) = mcStateR1Iter';
%     mcStateR2(iiIter,:) = mcStateR2Iter';
%     mcStateR3(iiIter,:) = mcStateR3Iter';
% end
% 
% % Save the key simulation result variables
% save('RSV_simulation_raw_results.mat', ...
%     'mcRecWeekly','mcRecWeeklyIncidence',...
%     'mcRecMonthlyByAge','mcRecMonthlyReportIncidence',...
%     'mcRecSerology','mcRecSerologyMeta','mcRecSerologyHK',...
%     'mcEpsilonByAge','yearlyAgeSpecificIAR','populationAgeGroup',...
%     'mcStateR0','mcStateR1','mcStateR2','mcStateR3');


% Plot figures
load('RSV_simulation_raw_results.mat');

% 0. Average age of infection
mean(prctile(mcStateR0,[50,2.5,97.5]),2)
mean(prctile(mcStateR1,[50,2.5,97.5]),2)
mean(prctile(mcStateR2,[50,2.5,97.5]),2)
mean(prctile(mcStateR3,[50,2.5,97.5]),2)

% 1. Serology
mcRecSerologyPrctile = prctile(mcRecSerology,[50,2.5,97.5],2);
[dataSerologyMean,dataSerologyCI] = binofit(seroprevData.num_seropos,seroprevData.num_samples); 

% 2. Weekly record 
numRnd = 1000;
mcRecWeeklyRnd = zeros(length(mcRecWeekly(:,1)),numRnd);
for iiWeek = 1:length(mcRecWeekly(:,1))
    % mcRecWeeklyRnd(iiWeek,:) = poissrnd(randsample(mcRecWeekly(iiWeek,:),numRnd,true));
    temp1 = randsample(mcRecWeekly(iiWeek,:),numRnd,true);
    temp2 = randsample(mcRecWeeklyIncidence(iiWeek,:),numRnd,true);
    mcRecWeeklyRnd(iiWeek,:) = (nbinrnd(temp1,temp1./temp2)+temp1).*(temp1./temp2);

end
mcRecWeeklyPrctile = prctile(mcRecWeeklyRnd,[50,2.5,97.5],2);
figure4 = fig_weekly_rsv(mcRecWeeklyPrctile, weeklyLab, dateZero,cutoffCOVID);

% 3. Monthly record by age
mcRecMonthlyByAgeRnd = zeros(length(mcRecMonthlyByAge(:,1,1)),length(mcRecMonthlyByAge(1,:,1)),numRnd);
for iiMonth = 1:length(mcRecMonthlyByAge(:,1,1))
    % mcRecMonthlyByAgeRnd(iiMonth,iiAge,:) = poissrnd(randsample(reshape(mcRecMonthlyByAge(iiMonth,iiAge,:),[1,min(maxIter,revNumIterations)]),numRnd,true));
    temp1 = reshape(mcRecMonthlyByAge(iiMonth,:,:),[length(mcRecMonthlyByAge(1,:,1)),min(maxIter,revNumIterations)]);
    temp = (temp1(:,randsample(1:length(temp1(1,:)),numRnd,true)))';
    temp2 = mnrnd(round(randsample(mcRecMonthlyReportIncidence(iiMonth,:),numRnd,true)'),temp./repmat(sum(temp,2),1,length(mcRecMonthlyByAge(1,:,1))));
    mcRecMonthlyByAgeRnd(iiMonth,:,:) = reshape(temp2',[1,length(mcRecMonthlyByAge(1,:,1)),numRnd]);
end
mcRecMonthlyByAgePrctile(:,:,1) = prctile(mcRecMonthlyByAgeRnd,50,3);
mcRecMonthlyByAgePrctile(:,:,2) = prctile(mcRecMonthlyByAgeRnd,2.5,3);
mcRecMonthlyByAgePrctile(:,:,3) = prctile(mcRecMonthlyByAgeRnd,97.5,3);
figure3 = fig_monthly_rsv_by_age_groups(mcRecMonthlyByAgePrctile, monthlyCaseRSV, dateZero, cutoffCOVID);
figure10 = fig_monthly_rsv_by_age_groups_rates(mcRecMonthlyByAgePrctile, monthlyCaseRSV, populationAgeGroup, dateZero, cutoffCOVID);
[figure12, recPeriodRates] = fig_period_rsv_by_age_groups_rates(mcRecMonthlyByAgePrctile, monthlyCaseRSV, populationAgeGroup, dateZero, cutoffCOVID);
[figure13, recYearlyRates] = fig_yearly_rsv_by_age_groups_rates(mcRecMonthlyByAgePrctile, monthlyCaseRSV, populationAgeGroup, dateZero, cutoffCOVID);

% Rates 
mtrSize = size(mcRecMonthlyByAgePrctile);
mcRecMonthlyByAgePrctileRates = mcRecMonthlyByAgePrctile./repmat(mean(populationAgeGroup),mtrSize(1),1,mtrSize(3))*100000;
mcRecMonthlyByAgePrctileYearly = reshape(sum(mcRecMonthlyByAgePrctileRates(1:48,:,:),1)/4,6,3);

% 4. Serology from meta analysis
mcRecSerologyMetaRnd = zeros(length(mcRecSerologyMeta(:,1)),numRnd);
for iiSero = 1:length(mcRecSerologyMeta(:,1))
    mcRecSerologyMetaRnd(iiSero,:) = binornd(seroprevDataMeta.N(iiSero)*ones(1,numRnd),randsample(mcRecSerologyMeta(iiSero,:),numRnd,true))/seroprevDataMeta.N(iiSero);
end
mcRecSerologyMetaPrctile = prctile(mcRecSerologyMetaRnd,[50,2.5,97.5],2);
[dataSerologyMetaMean,dataSerologyMetaCI] = binofit(seroprevDataMeta.N_positive,seroprevDataMeta.N); 
figure6 = fig_serology_meta(mcRecSerologyMetaPrctile,seroprevDataMeta,dataSerologyMetaMean,dataSerologyMetaCI);

% 4. Serology from HK local data
mcRecSerologyHKRnd = zeros(length(mcRecSerologyHK(:,1)),numRnd);
for iiSero = 1:length(mcRecSerologyHK(:,1))
    mcRecSerologyHKRnd(iiSero,:) = binornd(seroprevDataHKRec.num_samples(iiSero)*ones(1,numRnd),randsample(mcRecSerologyHK(iiSero,:),numRnd,true))/seroprevDataHKRec.num_samples(iiSero);
end
mcRecSerologyHKPrctile = prctile(mcRecSerologyHKRnd,[50,2.5,97.5],2);
[dataSerologyHKMean,dataSerologyHKCI] = binofit(seroprevDataHKRec.num_IgG_positive,seroprevDataHKRec.num_samples); 

% 5. Disease burden
yearlyAgeSpecificIARPrctile = prctile(yearlyAgeSpecificIAR,[50,2.5,97.5],3);
yearlyAgeSpecificIARPrctileTabMean = reshape(mean(yearlyAgeSpecificIARPrctile,1),6,3);
yearlyAgeSpecificIARPrctileTabMin = reshape(min(yearlyAgeSpecificIARPrctile,[],1),6,3);
yearlyAgeSpecificIARPrctileTabMax = reshape(max(yearlyAgeSpecificIARPrctile,[],1),6,3);

% 6. Seroprevalence Asia
figure5 = fig_serology_HK_BJ_Thailand(...
    mcRecSerologyPrctile, seroprevData, dataSerologyMean, dataSerologyCI, ...
    mcRecSerologyMetaPrctile, seroprevDataMeta, dataSerologyMetaMean, dataSerologyMetaCI,...
    mcRecSerologyHKPrctile, seroprevDataHKRec, dataSerologyHKMean, dataSerologyHKCI);
figure8 = fig_serology_asia(mcRecSerologyPrctile, seroprevData, dataSerologyMean, dataSerologyCI, mcRecSerologyMetaPrctile, seroprevDataMeta, dataSerologyMetaMean, dataSerologyMetaCI);

% 8. Combined figure (Figure 5 + Figure 10 + Figure 12)
figureCombined = fig_combined_5_10_12(...
    mcRecMonthlyByAgePrctile, monthlyCaseRSV, populationAgeGroup, dateZero, cutoffCOVID, ...
    mcRecSerologyPrctile, seroprevData, dataSerologyMean, dataSerologyCI, ...
    mcRecSerologyMetaPrctile, seroprevDataMeta, dataSerologyMetaMean, dataSerologyMetaCI, ...
    mcRecSerologyHKPrctile, seroprevDataHKRec, dataSerologyHKMean, dataSerologyHKCI);

% 7. Seroprevalence outside Asia
figure9 = fig_serology_meta_outside_asia(mcRecSerologyMetaPrctile,seroprevDataMeta,dataSerologyMetaMean,dataSerologyMetaCI);

% Reporting rates by age
reportRateByAge = prctile(mcEpsilonByAge,[50,2.5,97.5]);
disp(reportRateByAge')

sizeIAR = size(yearlyAgeSpecificIAR);
repOutcomeArr = zeros(sizeIAR);
repOutcomeArr(1,1,:) = reshape(sum(mcEpsilonByAge(:,1:6),2)/6,1,[],sizeIAR(3));
repOutcomeArr(1,2,:) = reshape(sum(mcEpsilonByAge(:,7:12),2)/6,1,[],sizeIAR(3));
repOutcomeArr(1,3,:) = reshape(sum(mcEpsilonByAge(:,13:16),2)/4,1,[],sizeIAR(3));
repOutcomeArr(1,4,:) = reshape(sum(mcEpsilonByAge(:,17:18),2)/2*0.2+sum(mcEpsilonByAge(:,19:23),2)/5*0.8,1,[],sizeIAR(3));
repOutcomeArr(1,5,:) = reshape(sum(mcEpsilonByAge(:,24),2),1,[],sizeIAR(3));
repOutcomeArr(1,6,:) = reshape(sum(mcEpsilonByAge(:,25),2),1,[],sizeIAR(3));

for ii = 1:sizeIAR(1)
    repOutcomeArr(:,ii,:) = repmat(repOutcomeArr(1,ii,:),sizeIAR(1),1,1);
end
temp = yearlyAgeSpecificIAR.*repOutcomeArr;
tempRev(:,1,:) = (temp(:,1,:)+temp(:,2,:))/2;
tempRev(:,2:5,:) = temp(:,3:6,:);
repOutcomePrctile = prctile(tempRev,[50,2.5,97.5],3);
repOutcomePrctileTabMean = 10^5*reshape(mean(repOutcomePrctile,1),5,3);
repOutcomePrctileTabMin = 10^5*reshape(min(repOutcomePrctile,[],1),5,3);
repOutcomePrctileTabMax = 10^5*reshape(max(repOutcomePrctile,[],1),5,3);

