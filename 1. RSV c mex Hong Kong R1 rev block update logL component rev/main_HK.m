
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

% % PHLSB data from CHP website
% yearArr = 2014:2024;
% for ii = 1:length(yearArr)
%     % disp(num2str(yearArr(ii)))
%     iiFile = strcat('detection_of_other_respiratory_viruses_in_respiratory_specimens_in_',num2str(yearArr(ii)),'_en.csv');
%     iiData = readtable(strcat('../0. data/Hong_Kong_CHP/',iiFile));
%     iiData = iiData(~isnan(iiData{:,1}),:);
%     if yearArr(ii)>=2018
%         if yearArr(ii)>=2020 & yearArr(ii)<=2022
%             iiData = iiData(:,[1:2,4:8,11:end]);
%         else
%             iiData = iiData(:,[1:7,10:end]);
%         end
%     end
%     iiData.Properties.VariableNames = {'week_num','date','num_specimen',...
%         'num_adenovirus','perc_adenovirus','num_RSV','perc_RSV',...
%         'num_rhino_entero_combined','perc_rhino_entero_combined',...
%         'num_rhino_entero_tested','num_rhino_tested','num_entero_tested'};
%     iiData.year = repmat(num2str(yearArr(ii)),size(iiData.week_num));
%     iiData = iiData(:,{'year','week_num','date','num_specimen',...
%         'num_adenovirus','perc_adenovirus','num_RSV','perc_RSV',...
%         'num_rhino_entero_combined','perc_rhino_entero_combined',...
%         'num_rhino_entero_tested','num_rhino_tested','num_entero_tested'});
%     if ii == 1
%         weeklyLab = iiData;
%     else
%         weeklyLab = [weeklyLab;iiData];
%     end
% end
% weeklyLab.week_start = (datetime('2013-12-29','Format','uuuu-MM-dd')+caldays(0:7:(7*(length(weeklyLab.year)-1))))';
% weeklyLab.week_end = weeklyLab.week_start+caldays(6);
% weeklyLab = weeklyLab(:,{'year','week_num','week_start','week_end','num_specimen',...
%         'num_adenovirus','perc_adenovirus','num_RSV','perc_RSV',...
%         'num_rhino_entero_combined','perc_rhino_entero_combined',...
%         'num_rhino_entero_tested','num_rhino_tested','num_entero_tested'});
% writetable(weeklyLab,'../0. data/Hong_Kong_CHP/weekly_lab_2014_2024.csv');

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
% qTransmissConversation = 0.95;
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
expReport = [-4.6, -0.233];
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

% More data from literature
% Relating in vivo RSV infection kinetics to host infectiousness in different age groups
rng(100);
dataPitzerIncubation = round(exprnd((3.54+3.5)/2,53,1));
dataPitzerIncubation = dataPitzerIncubation(dataPitzerIncubation>=0);
% Infectious period
dataPitzerInfectious.children = round(normrnd(14.7,14.7*((6.6-0.94+6.32-1)/2/1.96)/((3.54+3.5)/2),24,1));
dataPitzerInfectious.children = dataPitzerInfectious.children(dataPitzerInfectious.children>0);
dataPitzerInfectious.adult = round(normrnd((5.3+7.8)/2,((5.3+7.8)/3)*((6.6-0.94+6.32-1)/2/1.96)/((3.54+3.5)/2),29,1));
dataPitzerInfectious.adult = dataPitzerInfectious.adult(dataPitzerInfectious.adult>0);

% Likelihood
x0 = [xiMaternalImmunity, omegaInfectionImmunity, sigmaExposure, gammaZeroPrimaryInfection,...
    g1ReductionInfectiousDuration, g2ReductionInfectiousDuration, delta1RelSuscep, delta2RelSuscep, delta3RelSuscep,...
    pAsym, ...
    alphaReductionInfectiousness, qTransmissPhysical,...
    b1AmpTransmissPeak,phiSeasonalShift,psiSeasonalWavelength,...
    iniInfectiousProp, iniRecoveredProp,...
    expReport, epsilonReport17,epsilonReport18,epsilonReport19,probSeropos];

% MLE
% Lower and upper bound
x0LowerBound = [1e-6, 1e-6, 1/30, 1/30,...
    0, 0, 0, 0, 0,...
    0, 0, 0, 0,...
    0, 0, ...
    0, 0, 0,...
    0, 0,...
    -10, -10,...
    0, 0, 0, 0];

x0UpperBound = [1/30,  1/30, 100, 100,...
    1, 1, 1, 1, 1,...
    1, 1, 1, 1,...
    1, 1,...
    500, 1, 1,...
    1, 1,...
    0, 0,...
    1, 1, 1, 1];

% Negative log likelihood
tic
disp(['Starting neg log likelihood: ',num2str(negTotalLogLikelihood(...
    x0,...
    weeklyILI,weeklyLab,monthlyCaseRSV,indicesMonthlyRSV,...
    seroprevData,indicesSeroPreg,indicesSeroAge,...
    seroprevDataMeta,indicesSeroAgeMeta,...
    seroprevDataHKRec,indicesSeroAgeHK,...
    dataPitzerIncubation, dataPitzerInfectious,...
    stateM,...
    stateS0, stateS1, stateS2, stateS3,...
    stateE0, stateE1, stateE2, stateE3,...
    stateI0, stateI1, stateI2, stateI3,...
    stateA0, stateA1, stateA2, stateA3,...
    stateR0, stateR1, stateR2, stateR3,...
    stateZ,...
    probVmAb, probVvax,...
    totalPopulation, ageGroupDefRangeAll, muBirthRate,populationSizeTable,populationSizeTableRev,...
    phyContactMatr, conversationContactMatr,...
    dateZero,dateStart,cutoffCOVID, numDays, numTimeSteps, dt))]); 
toc

% MLE
dirFolder = 'mcmc_result';
if ~(exist(dirFolder,'dir')==7)
    mkdir(dirFolder);
end
% Point estimates from fmincon
redeffun = @(x)negTotalLogLikelihood(x,...
    weeklyILI,weeklyLab,monthlyCaseRSV,indicesMonthlyRSV,...
    seroprevData,indicesSeroPreg,indicesSeroAge,...
    seroprevDataMeta,indicesSeroAgeMeta,...
    seroprevDataHKRec,indicesSeroAgeHK,...
    dataPitzerIncubation, dataPitzerInfectious,...
    stateM,...
    stateS0, stateS1, stateS2, stateS3,...
    stateE0, stateE1, stateE2, stateE3,...
    stateI0, stateI1, stateI2, stateI3,...
    stateA0, stateA1, stateA2, stateA3,...
    stateR0, stateR1, stateR2, stateR3,...
    stateZ,...
    probVmAb, probVvax,...
    totalPopulation, ageGroupDefRangeAll, muBirthRate,populationSizeTable,populationSizeTableRev,...
    phyContactMatr, conversationContactMatr,...
    dateZero,dateStart,cutoffCOVID, numDays, numTimeSteps, dt);
options = optimoptions(@fmincon,'Display','iter','MaxFunEvals',30000);

negA = zeros(3,length(x0));
negB = zeros(3,1);
negA(1,10:11) = [1,-1];
negA(2,11:12) = [1,-1];
negA(3,12:13) = [1,-1];

if exist(strcat('mcmc_result/',countryText,'_mcmc_res.csv'),'file') == 2
    mcmcRes = readmatrix(strcat('mcmc_result/',countryText,'_mcmc_res.csv'));
    mcmcRes = mcmcRes(mcmcRes(:,1)~=0,:);
    x0 = mcmcRes(end,:);
    % xfmin = fmincon(redeffun,x0,negA,negB,[],[],x0LowerBound,x0UpperBound,[],options);
    xfmin = x0;
    write_matrix_new(xfmin,strcat('mcmc_result/',countryText,'_mle.csv'),'w',',','dec');
else
    if exist(strcat('mcmc_result/',countryText,'_mle.csv'),'file') == 2
        x0 = readmatrix(strcat('mcmc_result/',countryText,'_mle.csv'));
        xfmin = fmincon(redeffun,x0,negA,negB,[],[],x0LowerBound,x0UpperBound,[],options);
        write_matrix_new(xfmin,strcat('mcmc_result/',countryText,'_mle.csv'),'w',',','dec');
    else
        xfmin = fmincon(redeffun,x0,negA,negB,[],[],x0LowerBound,x0UpperBound,[],options);
        write_matrix_new(xfmin,strcat('mcmc_result/',countryText,'_mle.csv'),'w',',','dec');
    end
end

disp(['MLE neg log likelihood: ',num2str(negTotalLogLikelihood(...
    xfmin,...
    weeklyILI,weeklyLab,monthlyCaseRSV,indicesMonthlyRSV,...
    seroprevData,indicesSeroPreg,indicesSeroAge,...
    seroprevDataMeta,indicesSeroAgeMeta,...
    seroprevDataHKRec,indicesSeroAgeHK,...
    dataPitzerIncubation, dataPitzerInfectious,...
    stateM,...
    stateS0, stateS1, stateS2, stateS3,...
    stateE0, stateE1, stateE2, stateE3,...
    stateI0, stateI1, stateI2, stateI3,...
    stateA0, stateA1, stateA2, stateA3,...
    stateR0, stateR1, stateR2, stateR3,...
    stateZ,...
    probVmAb, probVvax,...
    totalPopulation, ageGroupDefRangeAll, muBirthRate,populationSizeTable,populationSizeTableRev,...
    phyContactMatr, conversationContactMatr,...
    dateZero,dateStart,cutoffCOVID, numDays, numTimeSteps, dt))]); 

% MCMC
mcSteps = 40000;
if exist(strcat('mcmc_result/',countryText,'_parameter_step.csv'),'file') == 2
    stepSize = readmatrix(strcat('mcmc_result/',countryText,'_parameter_step.csv'));
else
    stepSize = abs(0.05*xfmin);
end
blockUpdateGroup = [
    1,1;
    2,2;
    3,3;
    4,6;
    7,9;
    10,13;
    14,14;
    15,16;
    17,18;
    19,19;
    20,20;
    21,22;
    23,23;
    24,24;
    25,25;
    26,26];
out = mcmcParallelBlock(countryText,mcSteps,...
    weeklyILI,weeklyLab,monthlyCaseRSV,indicesMonthlyRSV,...
    seroprevData,indicesSeroPreg,indicesSeroAge,...
    seroprevDataMeta,indicesSeroAgeMeta,...
    seroprevDataHKRec,indicesSeroAgeHK,...
    dataPitzerIncubation, dataPitzerInfectious,...
    stateM,...
    stateS0, stateS1, stateS2, stateS3,...
    stateE0, stateE1, stateE2, stateE3,...
    stateI0, stateI1, stateI2, stateI3,...
    stateA0, stateA1, stateA2, stateA3,...
    stateR0, stateR1, stateR2, stateR3,...
    stateZ,...
    probVmAb, probVvax,...
    totalPopulation, ageGroupDefRangeAll, muBirthRate,populationSizeTable,populationSizeTableRev,...
    phyContactMatr, conversationContactMatr,...
    dateZero,dateStart,cutoffCOVID, numDays, numTimeSteps, dt,...
    xfmin,stepSize,x0LowerBound,x0UpperBound,blockUpdateGroup);

