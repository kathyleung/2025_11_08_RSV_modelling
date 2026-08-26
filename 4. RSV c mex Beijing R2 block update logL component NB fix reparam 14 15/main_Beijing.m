
% 2024-12-28
% RSV model from David Hodgson
clearvars;
rng("default")

% Keep relative paths stable when the script is launched from outside this folder.
scriptDir = fileparts(mfilename('fullpath'));
origDir = pwd;
cleanupObj = onCleanup(@() cd(origDir));
cd(scriptDir);
addpath(scriptDir);

% Check if MEX file exists and is accessible
if ~exist('age_SEIR_RSV_mex', 'file')
    error('MEX file age_SEIR_RSV_mex not found in MATLAB path');
end

% 0. Beijing data 
% Beijing reported case number
monthlyILICaseRSV = readtable('../0. data/Beijing_ILI_hosp/monthly_RSV_Beijing.xlsx');
% monthlyILICaseRSV.num_tested = round(monthlyILICaseRSV.num_monthly_RSV_pos./(monthlyILICaseRSV.detection_RSV_probability*0.01));
periodCaseRSV = readtable('../0. data/Beijing_ILI_hosp/period_RSV_by_age_Beijing.xlsx');
% Remove overlapping aggregate periods. The Beijing age file contains a
% 48-month block (2015-07 to 2019-06) alongside the four 12-month periods
% inside it, which would otherwise double-count the same age data.
periodStartMonth = periodCaseRSV.year_start*12 + periodCaseRSV.month_start;
periodEndMonth = periodCaseRSV.year_end*12 + periodCaseRSV.month_end;
periodLengthMonths = periodEndMonth - periodStartMonth + 1;
keepPeriodRow = true(height(periodCaseRSV),1);
for iiPeriod = 1:height(periodCaseRSV)
    sameAgeGroup = periodCaseRSV.age_group_index == periodCaseRSV.age_group_index(iiPeriod);
    containsShorterPeriod = sameAgeGroup & ...
        periodLengthMonths < periodLengthMonths(iiPeriod) & ...
        periodStartMonth >= periodStartMonth(iiPeriod) & ...
        periodEndMonth <= periodEndMonth(iiPeriod);
    if any(containsShorterPeriod)
        keepPeriodRow(iiPeriod) = false;
    end
end
periodCaseRSV = periodCaseRSV(keepPeriodRow,:);
ageDefPeriodRSV = [12/12,2,5,18,60,75,100];

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
% % Average duration of maternally derived immunity (days)
% xiMaternalImmunity = 1/269;
% Average duration of post-infection immunity (days)
omegaInfectionImmunity = 1/117;
% Average duration of exposure (days)
sigmaExposure = 1/2.48;
% Average duration of primary infection (days)
gammaZeroPrimaryInfection = 1/4.43;
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
qTransmissPhysical = 0.008;
% Relative reduction in probability of RSV transmission per conversational contact compared to physical contact
% qTransmissConversation = 0.95;
% Relative amplitude of transmission during peak
b1AmpTransmissPeak = 3;
% Seasonal shift in transmission
phiSeasonalShift = 0.66;
% Seasonal wavelength constant
psiSeasonalWavelength = 0.275;
% Seed
% Initial proportion (at t = 0) of people who are infected (i.e. in epidemiological compartments E, I or A) with RSV
iniInfectiousProp = 1e-6;
% Initial proportion (at t = 0) of people who not-infected but are protected (in epidemiological compartment R) from RSV
iniRecoveredProp = 1e-6;

% Probability that an RSV infection is reported (0-23 months; 2-4 yrs; 5-14 yrs; 15-54 yrs; 56-74 yr; 75 or above)
expReport = [-6.8, -0.833];
epsilonReport17 = 0.3*10^-5;
epsilonReport18 = 0.03*10^-5;
epsilonReport19 = 0.05*10^-5;
epsilonReport20 = 0.3*10^-5;
epsilonReport21 = 0.6*10^-5;

% Seropositive probability of RSV infected S E I A individuals 
probSeropos = 0.75;
% Linear overdispersion parameter for monthly RSV-positive counts.
% Start close to Poisson so Beijing only moves away from it if supported
% by the data.
linDispMonthlyLab = 1e-3;

% 2. (Fixed parameters) that are not included in Table 1
% Load contact matrix data
% Contact matrix countries
SKINCONTACT = 1;
CONVERSATIONCONTACT = 2;
% 1. Demographics
% Hong Kong population
populationSizeTable = readtable('../0. data/2025_03_28_age_distr_Beijing.csv');
populationSize = populationSizeTable(:,[1,2,3,4]);
countryText = 'Beijing';
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
if strcmp(countryText,'Beijing')
    dataDir = '../0. data/Beijing_social_contact_matrix/';
    countryText = 'China_subnational_Beijing';
    totalPopulation = sum(populationSize.population_count);
    ageGroupDefRange = ageGroupDefRangeUse;
    % Age distribution
    ageDistrTemp = readmatrix([dataDir,'age_distributions/',countryText,'_age_distribution_85.csv']);
    totalPop = totalPopulation;
    ageDistributionOneyear =  ageDistrTemp(:,2)/sum(ageDistrTemp(:,2));
    % Contact matrix by setting
    overallMatr = readmatrix([dataDir,'contact_matrices/',countryText,'_M_overall_contact_matrix_85.csv']);
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
monthlyILICaseRSV.month_start = days(datetime(monthlyILICaseRSV.year, monthlyILICaseRSV.month_start, 15*ones(size(monthlyILICaseRSV.year)))-dateZero);
monthlyILICaseRSV.month_end = days(datetime(monthlyILICaseRSV.year, 1+monthlyILICaseRSV.month_end, 15*ones(size(monthlyILICaseRSV.year)))-dateZero)-1;
periodCaseRSV.month_start = days(datetime(periodCaseRSV.year_start, periodCaseRSV.month_start, 15*ones(size(periodCaseRSV.year_start)))-dateZero);
periodCaseRSV.month_end = days(datetime(periodCaseRSV.year_end, periodCaseRSV.month_end, 15*ones(size(periodCaseRSV.year_end)))-dateZero)-1;

% Select data till Jan 23 2020
cutoffCOVID = days(datetime('2020-01-23','Format','uuuu-MM-dd')-dateZero);
% Find indices for monthly RSV data
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
x0 = [omegaInfectionImmunity, sigmaExposure, gammaZeroPrimaryInfection,...
    g1ReductionInfectiousDuration, g2ReductionInfectiousDuration, delta1RelSuscep, delta2RelSuscep, delta3RelSuscep,...
    pAsym, ...
    alphaReductionInfectiousness, qTransmissPhysical,...
    b1AmpTransmissPeak,phiSeasonalShift,psiSeasonalWavelength,...
    iniInfectiousProp, iniRecoveredProp,...
    expReport, epsilonReport17,epsilonReport18,epsilonReport19,epsilonReport20,epsilonReport21,probSeropos,linDispMonthlyLab];

% MLE
% Lower and upper bound
x0LowerBound = [1e-6, 1/30, 1/30,...
    1e-9, 1e-9, 1e-9, 1e-9, 1e-9,...
    1e-9, 1e-9, 1e-9, 1e-9,...
    1e-9, 1e-9,...
    1e-9, 1e-9, 1e-9,...
    1e-9, 1e-9,...
    -10, -10,...
    1e-9, 1e-9, 1e-9, 1e-9, 1e-9,...
    1e-9, 1e-9];

x0UpperBound = [1/30, 100, 100,...
    1, 1, 1, 1, 1,...
    1, 1, 1, 1,...
    1, 1,...
    500, 1, 1,...
    1, 1,...
    0, 0,...
    1, 1, 1, 1, 1,...
    1, 100];

% Negative log likelihood
tic
disp(['Starting neg log likelihood: ',num2str(negTotalLogLikelihood(...
    x0,...
    monthlyILICaseRSV,periodCaseRSV,ageDefPeriodRSV,...
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
    monthlyILICaseRSV,periodCaseRSV,ageDefPeriodRSV,...
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
expectedNumPars = length(x0);

negA = zeros(3,length(x0));
negB = zeros(3,1);
negA(1,9:10) = [1,-1];
negA(2,10:11) = [1,-1];
negA(3,11:12) = [1,-1];

savedMcmcPath = strcat('mcmc_result/',countryText,'_mcmc_res.csv');
savedMlePath = strcat('mcmc_result/',countryText,'_mle.csv');
savedStateVersionPath = strcat('mcmc_result/',countryText,'_likelihood_version.txt');
savedStateVersion = 'linear_dispersion_nb_v7_beijing_amp_prior_fix';
savedStateVersionMatches = false;
savedChainRes = [];
if exist(savedStateVersionPath,'file') == 2
    savedStateVersionMatches = strcmp(strtrim(fileread(savedStateVersionPath)), savedStateVersion);
end
if exist(savedMcmcPath,'file') == 2
    savedChainRes = readmatrix(savedMcmcPath);
    if ~isempty(savedChainRes)
        savedChainRes = savedChainRes(savedChainRes(:,1)~=0,:);
    end
end
if exist(savedMcmcPath,'file') == 2 && savedStateVersionMatches
    if ~isempty(savedChainRes) && size(savedChainRes,2) == expectedNumPars
        x0 = savedChainRes(end,:);
    elseif ~isempty(savedChainRes) && size(savedChainRes,2) == expectedNumPars-1
        x0 = [savedChainRes(end,:), linDispMonthlyLab];
        disp('Appended default linear-overdispersion parameter to saved MCMC state.');
    else
        disp('Ignoring saved MCMC state because parameter dimension does not match current model.');
    end
elseif exist(savedMlePath,'file') == 2 && savedStateVersionMatches
    savedMle = reshape(readmatrix(savedMlePath),1,[]);
    if numel(savedMle) == expectedNumPars
        x0 = savedMle;
    elseif numel(savedMle) == expectedNumPars-1
        x0 = [savedMle, linDispMonthlyLab];
        disp('Appended default linear-overdispersion parameter to saved MLE.');
    else
        disp('Ignoring saved MLE because parameter dimension does not match current model.');
    end
elseif exist(savedMcmcPath,'file') == 2 || exist(savedMlePath,'file') == 2
    disp('Ignoring saved Beijing state because it predates the linear-dispersion monthly likelihood.');
end

xfmin = fmincon(redeffun,x0,negA,negB,[],[],x0LowerBound,x0UpperBound,[],options);
write_matrix_new(xfmin,savedMlePath,'w',',','dec');
fid = fopen(savedStateVersionPath,'w');
fprintf(fid,'%s\n',savedStateVersion);
fclose(fid);

disp(['MLE neg log likelihood: ',num2str(negTotalLogLikelihood(...
    xfmin,...
    monthlyILICaseRSV,periodCaseRSV,ageDefPeriodRSV,...
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
mcSteps = 100000;
savedStepPath = strcat('mcmc_result/',countryText,'_parameter_step.csv');
if exist(savedStepPath,'file') == 2
    savedStepSize = reshape(readmatrix(savedStepPath),1,[]);
    if numel(savedStepSize) == length(xfmin)
        stepSize = savedStepSize;
        if savedStateVersionMatches
            disp('Loaded saved parameter step sizes.');
        else
            disp('Loaded saved parameter step sizes and ignored saved MCMC state because sampler version changed.');
        end
    elseif numel(savedStepSize) == length(xfmin)-1
        stepSize = [savedStepSize, max(abs(0.05*xfmin(end)),1e-5)];
        disp('Appended default step size for the linear-overdispersion parameter.');
    else
        disp('Ignoring saved parameter step sizes because parameter dimension does not match current model.');
        stepSize = abs(0.05*xfmin);
    end
else
    stepSize = abs(0.05*xfmin);
end
stepFloor = zeros(size(stepSize));
stepSize = max(stepSize,stepFloor);

proposalCov1415 = [];
if ~isempty(savedChainRes) && size(savedChainRes,2) >= 15
    covStartIdx = floor(size(savedChainRes,1)/2) + 1;
    covSamples1415Raw = savedChainRes(covStartIdx:end,14:15);
    validCovIdx = covSamples1415Raw(:,1) > 0 & covSamples1415Raw(:,2) > 0 & ...
        isfinite(covSamples1415Raw(:,1)) & isfinite(covSamples1415Raw(:,2));
    covSamples1415 = [...
        log(covSamples1415Raw(validCovIdx,1).*(1 + covSamples1415Raw(validCovIdx,2))),...
        log(covSamples1415Raw(validCovIdx,2))];
    if size(covSamples1415,1) >= 50
        proposalCov1415 = cov(covSamples1415);
        if ~all(isfinite(proposalCov1415(:))) || any(diag(proposalCov1415) <= 0)
            proposalCov1415 = [];
        else
            disp('Loaded transformed covariance proposal for parameters 14-15.');
        end
    end
end

blockUpdateGroup = [
    1,1;
    2,2;
    3,5;
    6,6;
    7,8;
    9,12;
    13,13;
    14,15;
    16,17;
    18,18;
    19,19;
    20,21;
    22,22;
    23,23;
    24,26;
    27,27;
    28,28];
out = mcmcParallelBlock(countryText,mcSteps,...
    monthlyILICaseRSV,periodCaseRSV,ageDefPeriodRSV,...
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
    xfmin,stepSize,stepFloor,x0LowerBound,x0UpperBound,blockUpdateGroup,proposalCov1415);

