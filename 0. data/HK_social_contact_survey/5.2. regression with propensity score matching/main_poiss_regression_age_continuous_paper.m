
% Jan 10, 2017
% Same method as Mossong et al PLOS Med 2008
% 1. Data
clear all;
demographics = readtable('../4. data_cleaning_from_pop_file/demographics.csv');
usuContactGeneral = readtable('../4. data_cleaning_from_pop_file/usual_contact_general.csv');
dailyContactGeneral = readtable('../4. data_cleaning_from_pop_file/contact_diary_general.csv');
% Join table
regrTable = join(join(demographics,usuContactGeneral(:,[1,3]),'Keys','participant_code'),dailyContactGeneral,'Keys','participant_code');
% write table
writetable(regrTable,'regrTable.csv');

% Age weights
ageGroupDefRange = [-1,6:5:66,101];
ageDistributionOneyear = loadAgeDistrCensus('Hong Kong');
AgeDistribution = zeros(1,(length(ageGroupDefRange)-1));      
for ii = 1:(length(ageGroupDefRange)-1)
    if ageGroupDefRange(ii) <= 1
        AgeDistribution(ii) = sum(ageDistributionOneyear(1:ageGroupDefRange(ii+1)));
    else
        AgeDistribution(ii) = sum(ageDistributionOneyear((ageGroupDefRange(ii)+1):ageGroupDefRange(ii+1)));
    end
end

% Y: number of reported contacts
% X: age, gender, household size, day of the week

% 1. age: ref 0-5 age group, total 9 categories
numObservations = length(demographics.participant_code);
regrAge = regrTable.age_or_mid_range;
% 2. gender: ref male
regrTable.gender = regrTable.gender;
regrGender = zeros(numObservations,max(regrTable.gender)-1);
for iiGender = 2:max(regrTable.gender)
    regrGender(regrTable.gender==iiGender,iiGender-1) = 1;
end
% 3. household size: ref size of 1, continous variable
% all participants have filled in usual contact number
regrTable.num_usual_contacts = regrTable.num_usual_contacts+1;
regrTable.num_usual_contacts(regrTable.num_usual_contacts>5) = 5;
regrHousehold = zeros(numObservations,1);
for iiHousehold = 1:max(regrTable.num_usual_contacts)
    regrHousehold(regrTable.num_usual_contacts==iiHousehold,1) = iiHousehold;
end
% 4. day of the week: ref weekday
regrTable.actual_week_day(ismember(regrTable.actual_week_day,1:5)) = 1;
regrTable.actual_week_day(ismember(regrTable.actual_week_day,6:7)) = 2;
regrWeekday = zeros(numObservations,max(regrTable.actual_week_day)-1);
for iiWeekday = 2:max(regrTable.actual_week_day)
    regrWeekday(regrTable.actual_week_day==iiWeekday,iiWeekday-1) = 1;
end
% 5. mode of survey: ref online
regrMode = ones(numObservations,max(regrTable.mode_survey)-1);
for iiMode = 2:max(regrTable.mode_survey)
    regrMode(regrTable.mode_survey==iiMode,iiMode-1) = 0;
end
% 6. education: ref primary or below and unknown
% descriptive
for iiEduIdx = 1:3
    display([length(regrTable.num_diary_contact(regrTable.edu==iiEduIdx)),mean(regrTable.num_diary_contact(regrTable.edu==iiEduIdx)),std(regrTable.num_diary_contact(regrTable.edu==iiEduIdx))]);
end
regrTable.edu(regrTable.edu>6) = 4;
regrEdu = zeros(numObservations,max(regrTable.edu)-1);
for iiEdu = 2:max(regrTable.edu)
    regrEdu(regrTable.edu==iiEdu,iiEdu-1) = 1;
end
% 7. income: continuous
regrTable.income_mid_range(ismember(regrTable.income_mid_range,1:2)) = 1;
regrTable.income_mid_range(ismember(regrTable.income_mid_range,3:4)) = 2;
regrTable.income_mid_range(ismember(regrTable.income_mid_range,5:7)) = 3;
regrTable.income_mid_range(ismember(regrTable.income_mid_range,8:11)) = 4;
regrTable.income_mid_range(regrTable.income_mid_range>100) = 5;
% descriptive
for iiIncomeIdx = 1:5
    display([length(regrTable.num_diary_contact(regrTable.income_mid_range==iiIncomeIdx)),...
        mean(regrTable.num_diary_contact(regrTable.income_mid_range==iiIncomeIdx)),...
        std(regrTable.num_diary_contact(regrTable.income_mid_range==iiIncomeIdx))]);
end
regrIncome = zeros(numObservations,max(regrTable.income_mid_range)-1);
for iiIncome = 2:max(regrTable.income_mid_range)
    regrIncome(regrTable.income_mid_range==iiIncome,iiIncome-1) = 1;
end

% Likelihood based estimation
% Parameters
betaZero = 0;
betaVec = zeros(1,...
    max(regrTable.gender)-1+...
    1+...
    max(regrTable.actual_week_day)-1+...
    1+...
    max(regrTable.edu)-1+...
    max(regrTable.income_mid_range)-1);
alphaDisp = 0.3;
% Data
regrX = [regrGender,regrAge,regrWeekday,regrHousehold,regrEdu,regrIncome];
regrY = regrTable.num_diary_contact;
regrX = regrX(regrTable.mode_survey==1,:);
regrY = regrY(regrTable.mode_survey==1,:);
% MLE
x0 = [alphaDisp,betaZero,betaVec];
x0LowerBound = [0,-5*ones(1,length(x0)-1)];
x0UpperBound = [1,5*ones(1,length(x0)-1)];
redeffun = @(x)negLogLikelihood(x,regrX,regrY);
options = optimoptions(@fmincon,'Display','iter','MaxFunEvals',30000,'MaxIterations',10000);
xfmin = fmincon(redeffun,x0,[],[],[],[],x0LowerBound,x0UpperBound,[],options);

% MCMC
mcSteps = 20000;
stepSize = (x0UpperBound-x0LowerBound)/10;
[iPar,iLogL] = mcmcParallel(mcSteps,regrX,regrY,xfmin,stepSize,x0LowerBound,x0UpperBound);
posteri = csvread('mcmc_result/mcmc.csv');
posteri = posteri(0.2*length(posteri(:,1)):end,:);
figure(1)
% Check posterior 
for ii = 1:length(posteri(1,:))
    subplot(5,5,ii);
    histogram(posteri(:,ii));
end
posteriMean = mean(posteri);
alphaDispPosteri = posteriMean(1);
alphaCI = prctile(posteri(:,1),[50,2.5,97.5]);
betaVecPosteri = exp(posteriMean(3:end));
betaVecCI = exp(prctile(posteri(:,3:end),[50,2.5,97.5]))';
betaVec = prctile(posteri(:,3:end),[50,2.5,97.5])';

% Display results
alphaDispPosteri
alphaCI
betaVecPosteri
betaVecCI

betaVecCIprint = [strcat(num2str(round(betaVecCI(:,1),2)),' ('),...
    strcat(num2str(round(betaVecCI(:,2),2)),'-'),...
    strcat(num2str(round(betaVecCI(:,3),2)),')')];