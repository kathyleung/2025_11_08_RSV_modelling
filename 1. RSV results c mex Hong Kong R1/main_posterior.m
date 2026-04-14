
% 2025-10-13
% RSV model from David Hodgson
% Posterior distribution
% clear all;
clearvars;
clf;

% 1. MCMC results
mcmcRes = readmatrix('../1. RSV c mex Hong Kong R1 rev block update logL component rev/mcmc_result/hongkong_mcmc_res.csv');
% mcmcRes = readmatrix('../2. RSV c mex Hong Kong R1 rev block update logL component no sero/mcmc_result/hongkong_mcmc_res.csv');
% mcmcRes = readmatrix('../3. RSV c mex Hong Kong R1 rev block update logL component region sero/mcmc_result/hongkong_mcmc_res.csv');

% 2. MCMC parameters
mcmcRes = mcmcRes(mcmcRes(:,1)~=0,:);
mcmcRes = mcmcRes((length(mcmcRes(:,1))*0.4):end,:);

% Posterior
plotArr = [1:18,21:length(mcmcRes(1,:))];
labelArr = {...
    '\xi','\omega','\sigma','\gamma_0',...
    'g_1','g_2','\delta_1','\delta_2',...
    '\delta_3','p_a_s_y_m(<1)','p_a_s_y_m(1-4)','p_a_s_y_m(5-14)',...
    'p_a_s_y_m(\geq15)','\alpha','q_p','b_1',...
    '\phi','\psi','\epsilon_\lambda','\epsilon_c',...
    '\epsilon_5_-_5_4','\epsilon_5_5_-_7_4','\epsilon_\geq_7_5','\pi'};
for iiParms = 1:length(plotArr)
    figure(1)
    subplot(6,4,iiParms)
    plot(mcmcRes(:,plotArr(iiParms)))
    title(labelArr{iiParms})
    figure(2)
    subplot(6,4,iiParms)
    histogram(mcmcRes(:,plotArr(iiParms)))
    title(labelArr{iiParms})
end

% Plot
numRnd = 10000;
figure(3)
subplot(6,4,1)
yyaxis left
histogram(mcmcRes(:,1));
hold on
rndPrior = unifrnd(14,1825,[numRnd,1]);
x_prior = [1/14,1/1825];
f_prior = [(1/14-1/1825),(1/14-1/1825)];
yyaxis right
plot(x_prior,f_prior);
xlim([1/350,1/220])
title('\xi')

subplot(6,4,2)
yyaxis left
histogram(mcmcRes(:,2));
hold on
x_prior = 50:0.1:200;
f_prior = normpdf(x_prior,135,35);
yyaxis right
plot(1./x_prior,f_prior);
xlim([0.005,0.009])
title('\omega')

subplot(6,4,3)
yyaxis left
histogram(mcmcRes(:,3));
hold on
x_prior = 0:0.01:20;
f_prior = gampdf(x_prior,2,1);
yyaxis right
plot(1./x_prior,f_prior)
xlim([0.3,0.6])
title('\sigma')

subplot(6,4,4)
yyaxis left
histogram(mcmcRes(:,4));
hold on
x_prior = 0:0.01:20;
f_prior = wblpdf(x_prior,4, 2);
yyaxis right
plot(1./x_prior,f_prior)
xlim([0.15,0.25])
title('\gamma_0')

subplot(6,4,5)
yyaxis left
histogram(mcmcRes(:,5));
hold on
x_prior = 0:0.01:1;
f_prior = wblpdf(x_prior, 0.879, 34.224);
yyaxis right
plot(x_prior,f_prior)
xlim([0.5,1])
title('g_1')

subplot(6,4,6)
yyaxis left
histogram(mcmcRes(:,6));
hold on
x_prior = 0:0.01:1;
f_prior = lognpdf(x_prior, -0.561, 0.163);
yyaxis right
plot(x_prior,f_prior)
xlim([0.4,1])
title('g_2')

subplot(6,4,7)
yyaxis left
histogram(mcmcRes(:,7));
hold on
x_prior = 0:0.01:1;
f_prior = betapdf(x_prior, 35.583, 11.417);
yyaxis right
plot(x_prior,f_prior)
xlim([0.6,1])
title('\delta_1')

subplot(6,4,8)
yyaxis left
histogram(mcmcRes(:,8));
hold on
x_prior = 0:0.01:1;
f_prior = betapdf(x_prior, 22.829, 3.171);
yyaxis right
plot(x_prior,f_prior)
xlim([0.6,1])
title('\delta_2')

subplot(6,4,9)
yyaxis left
histogram(mcmcRes(:,9));
hold on
x_prior = 0:0.001:1;
f_prior = betapdf(x_prior, 6.117, 12.882);
yyaxis right
plot(x_prior,f_prior)
xlim([0.01,0.03])
title('\delta_3')

subplot(6,4,10)
yyaxis left
histogram(mcmcRes(:,10));
hold on
x_prior = 0:0.01:1;
f_prior = betapdf(x_prior, 3.003, 29.997);
yyaxis right
plot(x_prior,f_prior)
xlim([0,0.3])
title('p_a_s_y_m(<1)')

subplot(6,4,11)
yyaxis left
histogram(mcmcRes(:,11));
hold on
x_prior = 0:0.01:1;
f_prior = betapdf(x_prior, 8.996, 43.004);
yyaxis right
plot(x_prior,f_prior)
xlim([0,0.3])
title('p_a_s_y_m(1-4)')

subplot(6,4,12)
yyaxis left
histogram(mcmcRes(:,12));
hold on
x_prior = 0:0.01:1;
f_prior = betapdf(x_prior, 38.033, 34.967);
yyaxis right
plot(x_prior,f_prior)
xlim([0.2,1])
title('p_a_s_y_m(5-14)')

subplot(6,4,13)
yyaxis left
histogram(mcmcRes(:,13));
hold on
x_prior = 0:0.01:1;
f_prior = betapdf(x_prior, 35.955, 11.045);
yyaxis right
plot(x_prior,f_prior)
xlim([0.5,1])
title('p_a_s_y_m(\geq15)')

subplot(6,4,14)
yyaxis left
histogram(mcmcRes(:,14));
hold on
x_prior = [0,1];
f_prior = [1,1];
yyaxis right
plot(x_prior,f_prior);
xlim([0,0.1])
title('\alpha')

subplot(6,4,15)
yyaxis left
histogram(mcmcRes(:,15));
hold on
x_prior = 0:0.001:1;
f_prior = normpdf(x_prior,0.1,0.1);
yyaxis right
plot(x_prior,f_prior);
xlim([0.01,0.04])
title('q_p')


subplot(6,4,16)
yyaxis left
histogram(mcmcRes(:,16));
hold on
x_prior = [0,500];
f_prior = [1/500,1/500];
yyaxis right
plot(x_prior,f_prior);
xlim([3.5,5.5])
title('b_1')

subplot(6,4,17)
yyaxis left
histogram(mcmcRes(:,17));
hold on
x_prior = [0,1];
f_prior = [1,1];
yyaxis right
plot(x_prior,f_prior);
xlim([0.5,0.53])
title('\phi')

subplot(6,4,18)
yyaxis left
histogram(mcmcRes(:,18));
hold on
x_prior = [0,1];
f_prior = [1,1];
yyaxis right
plot(x_prior,f_prior);
xlim([0.4,0.6])
title('\psi')

subplot(6,4,19)
yyaxis left
histogram(mcmcRes(:,21));
hold on
x_prior = [-10,0];
f_prior = [1/10,1/10];
yyaxis right
plot(x_prior,f_prior);
xlim([-0.9,-0.5])
title('\epsilon_\lambda')

subplot(6,4,20)
yyaxis left
histogram(mcmcRes(:,22));
hold on
x_prior = [-10,0];
f_prior = [1/10,1/10];
yyaxis right
plot(x_prior,f_prior);
xlim([-2.8,-2.3])
title('\epsilon_c')

subplot(6,4,21)
yyaxis left
histogram(mcmcRes(:,23));
hold on
x_prior = 0:0.0001:0.1;
f_prior = normpdf(x_prior,0.02,0.02);
yyaxis right
plot(x_prior,f_prior);
xlim([0.001,0.003])
title('\epsilon_5_-_5_4')

subplot(6,4,22)
yyaxis left
histogram(mcmcRes(:,24));
hold on
x_prior = 0:0.0001:0.1;
f_prior = normpdf(x_prior,0.02,0.02);
yyaxis right
plot(x_prior,f_prior);
xlim([0.02,0.04])
title('\epsilon_5_5_-_7_4')

subplot(6,4,23)
yyaxis left
histogram(mcmcRes(:,25));
hold on
x_prior = 0:0.0001:0.4;
f_prior = normpdf(x_prior,0.02,0.02);
yyaxis right
plot(x_prior,f_prior);
xlim([0.1,0.3])
title('\epsilon_\geq_7_5')

subplot(6,4,24)
yyaxis left
histogram(mcmcRes(:,26));
hold on
x_prior = [0,1];
f_prior = [1,1];
yyaxis right
plot(x_prior,f_prior);
xlim([0.94,1])
title('\pi')