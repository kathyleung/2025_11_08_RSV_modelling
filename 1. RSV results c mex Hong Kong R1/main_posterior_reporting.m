
% 2025-10-13
% RSV model from David Hodgson
% Posterior distribution
% clear all;
clearvars;
clf;

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
% Define age groups
ageGroupDefRangeAll = [ageGroupLower,ageGroupUpper(end)];

% 1. MCMC results
mcmcResHK = readmatrix('../1. RSV c mex Hong Kong R1 rev block update logL component rev/mcmc_result/hongkong_mcmc_res.csv');
mcmcResBJ = readmatrix('../4. RSV c mex Beijing R1 block update logL component/mcmc_result/China_subnational_Beijing_mcmc_res.csv');
mcmcResTL = readmatrix('../7. RSV c mex Thailand R1 block update logL component/mcmc_result/thailand_mcmc_res.csv');

% 2. MCMC parameters

% HK
mcmcRes = mcmcResHK;
mcmcRes = mcmcRes(mcmcRes(:,1)~=0,:);
mcmcRes = mcmcRes(length(mcmcRes(:,1))*0.2:end,:);
% Probability that an RSV infection is reported (0-4 yr; 5-54 yr; 55+ yr)
for ii = 1:length(mcmcRes(:,1))
    x0 = mcmcRes(ii,:);

    expReport = [x0(21), x0(22)];
    epsilonReport17 = x0(23);
    epsilonReport18 = x0(24);
    epsilonReport19 = x0(25);
    
    epsilonReportArr = exp(expReport(1)+expReport(2)*ageGroupDefRangeAll(1:(find(ageGroupDefRangeAll==5)-1)));
    epsilonByAge(ii,:) = [...
        epsilonReportArr,...
        repmat(epsilonReport17,1,find(ageGroupDefRangeAll==55)-find(ageGroupDefRangeAll==5)),...
        repmat(epsilonReport18,1,find(ageGroupDefRangeAll==75)-find(ageGroupDefRangeAll==55)),...
        repmat(epsilonReport19,1,numAgeGroups-find(ageGroupDefRangeAll==75)+1)];
end
prctileEpsilonHK = prctile(epsilonByAge,[50,2.5,97.5]);

% BJ
mcmcRes = mcmcResBJ;
mcmcRes = mcmcRes(mcmcRes(:,1)~=0,:);
mcmcRes = mcmcRes(length(mcmcRes(:,1))*0.2:end,:);
% Probability that an RSV infection is reported (0-4 yr; 5-54 yr; 55+ yr)
for ii = 1:length(mcmcRes(:,1))
    x0 = mcmcRes(ii,:);

    expReport = [x0(21), x0(22)];
    epsilonReport17 = x0(23);
    epsilonReport18 = x0(24);
    epsilonReport19 = x0(25);
    epsilonReport20 = x0(26);
    epsilonReport21 = x0(27);

    epsilonReportArr = exp(expReport(1)+expReport(2)*ageGroupDefRangeAll(1:(find(ageGroupDefRangeAll==2)-1)));
    epsilonByAge(ii,:) = [...
        epsilonReportArr,...
        repmat(epsilonReport17,1,find(ageGroupDefRangeAll==5)-find(ageGroupDefRangeAll==2)),...
        repmat(epsilonReport18,1,find(ageGroupDefRangeAll==15)-find(ageGroupDefRangeAll==5)),...
        repmat(epsilonReport19,1,find(ageGroupDefRangeAll==55)-find(ageGroupDefRangeAll==15)),...
        repmat(epsilonReport20,1,find(ageGroupDefRangeAll==75)-find(ageGroupDefRangeAll==55)),...
        repmat(epsilonReport21,1,numAgeGroups-find(ageGroupDefRangeAll==75)+1)];
end
prctileEpsilonBJ = prctile(epsilonByAge,[50,2.5,97.5]);

% Thailand
mcmcRes = mcmcResTL;
mcmcRes = mcmcRes(mcmcRes(:,1)~=0,:);
mcmcRes = mcmcRes(length(mcmcRes(:,1))*0.2:end,:);
% Probability that an RSV infection is reported (0-4 yr; 5-54 yr; 55+ yr)
for ii = 1:length(mcmcRes(:,1))
    x0 = mcmcRes(ii,:);

    expReport = [x0(21), x0(22)];
    epsilonReport17 = x0(23);
    epsilonReport18 = x0(24);
    epsilonReport19 = x0(25);
    epsilonReport20 = x0(26);
    epsilonReport21 = x0(27);

    epsilonReportArr = exp(expReport(1)+expReport(2)*ageGroupDefRangeAll(1:(find(ageGroupDefRangeAll==2)-1)));
    epsilonByAge(ii,:) = [...
        epsilonReportArr,...
        repmat(epsilonReport17,1,find(ageGroupDefRangeAll==5)-find(ageGroupDefRangeAll==2)),...
        repmat(epsilonReport18,1,find(ageGroupDefRangeAll==15)-find(ageGroupDefRangeAll==5)),...
        repmat(epsilonReport19,1,find(ageGroupDefRangeAll==55)-find(ageGroupDefRangeAll==15)),...
        repmat(epsilonReport20,1,find(ageGroupDefRangeAll==75)-find(ageGroupDefRangeAll==55)),...
        repmat(epsilonReport21,1,numAgeGroups-find(ageGroupDefRangeAll==75)+1)];
end
prctileEpsilonTL = prctile(epsilonByAge,[50,2.5,97.5]);

figure(1)

% HK
% <1
subplot(3,2,1)
x_fill = [ageGroupLower(1:13), fliplr(ageGroupLower(1:13))];
y_fill = [prctileEpsilonHK(2,1:13),fliplr(prctileEpsilonHK(3,1:13))];
fill(x_fill, y_fill, [0, 0.4470, 0.7410], 'FaceAlpha', 0.3, 'EdgeColor', 'none');
hold on
hModel = plot(ageGroupLower(1:13), prctileEpsilonHK(1,1:13), '-', ...
    'Color', [0, 0.4470, 0.7410], 'LineWidth', 1);
xlim([0,1])
set(gca,'XTick',(0:2:12)/12,'XTickLabel',{'0m','2m','4m','6m','8m','10m','12m'})
box off
ylabel({'Probability of','lab confirmation'})
xlabel('Age')
title('Hong Kong: Probability of laboratory confirmation')
% >=1
subplot(3,2,2)
x_fill = [ageGroupUpper(12:end), fliplr(ageGroupUpper(12:end))];
y_fill = [prctileEpsilonHK(2,12:end),fliplr(prctileEpsilonHK(3,12:end))];
fill(x_fill, y_fill, [0.8500, 0.3250, 0.0980], 'FaceAlpha', 0.3, 'EdgeColor', 'none');
hold on
hModel = plot(ageGroupUpper(12:end), prctileEpsilonHK(1,12:end), '-', ...
    'Color', [0.8500, 0.3250, 0.0980], 'LineWidth', 1);
xlim([1,85])
set(gca,'XTick',[1,5:10:100])
box off
ylabel({'Probability of','lab confirmation'})
xlabel('Age')
% title('Hong Kong: Probability of lab confirmation')

% BJ
% <1
subplot(3,2,3)
x_fill = [ageGroupLower(1:13), fliplr(ageGroupLower(1:13))];
y_fill = [prctileEpsilonBJ(2,1:13),fliplr(prctileEpsilonBJ(3,1:13))];
fill(x_fill, y_fill, [0, 0.4470, 0.7410], 'FaceAlpha', 0.3, 'EdgeColor', 'none');
hold on
hModel = plot(ageGroupLower(1:13), prctileEpsilonBJ(1,1:13), '-', ...
    'Color', [0, 0.4470, 0.7410], 'LineWidth', 1);
xlim([0,1])
set(gca,'XTick',(0:2:12)/12,'XTickLabel',{'0m','2m','4m','6m','8m','10m','12m'})
box off
ylabel({'Probability of RSV-ARI','reported to RPSS'})
xlabel('Age')
title('Beijing: Probability of RSV-ARI reported to RPSS')
% >=1
subplot(3,2,4)
x_fill = [ageGroupUpper(12:end), fliplr(ageGroupUpper(12:end))];
y_fill = [prctileEpsilonBJ(2,12:end),fliplr(prctileEpsilonBJ(3,12:end))];
fill(x_fill, y_fill, [0.8500, 0.3250, 0.0980], 'FaceAlpha', 0.3, 'EdgeColor', 'none');
hold on
hModel = plot(ageGroupUpper(12:end), prctileEpsilonBJ(1,12:end), '-', ...
    'Color', [0.8500, 0.3250, 0.0980], 'LineWidth', 1);
xlim([1,85])
set(gca,'XTick',[1,5:10:100])
box off
ylabel({'Probability of RSV-ARI','reported to RPSS'})
xlabel('Age')
% title('Beijing: Probability of RSV-ARI reported to RPSS')

% Thailand
% <1
subplot(3,2,5)
x_fill = [ageGroupLower(1:13), fliplr(ageGroupLower(1:13))];
y_fill = [prctileEpsilonTL(2,1:13),fliplr(prctileEpsilonTL(3,1:13))];
fill(x_fill, y_fill, [0, 0.4470, 0.7410], 'FaceAlpha', 0.3, 'EdgeColor', 'none');
hold on
hModel = plot(ageGroupLower(1:13), prctileEpsilonTL(1,1:13), '-', ...
    'Color', [0, 0.4470, 0.7410], 'LineWidth', 1);
xlim([0,1])
set(gca,'XTick',(0:2:12)/12,'XTickLabel',{'0m','2m','4m','6m','8m','10m','12m'})
box off
ylabel({'Probability of','RSV-ALRI hospitalisation'})
xlabel('Age')
title('Thailand: Probability of RSV-ALRI hospitalisation')
% >=1
subplot(3,2,6)
x_fill = [ageGroupUpper(12:end), fliplr(ageGroupUpper(12:end))];
y_fill = [prctileEpsilonTL(2,12:end),fliplr(prctileEpsilonTL(3,12:end))];
fill(x_fill, y_fill, [0.8500, 0.3250, 0.0980], 'FaceAlpha', 0.3, 'EdgeColor', 'none');
hold on
hModel = plot(ageGroupUpper(12:end), prctileEpsilonTL(1,12:end), '-', ...
    'Color', [0.8500, 0.3250, 0.0980], 'LineWidth', 1);
xlim([1,85])
set(gca,'XTick',[1,5:10:100])
box off
ylabel({'Probability of','RSV-ALRI hospitalisation'})
xlabel('Age')
% title('Thailand: Probability of RSV-ALRI hospitalisation')