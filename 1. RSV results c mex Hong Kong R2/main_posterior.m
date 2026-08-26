
% 2025-10-13
% RSV model from David Hodgson
% Posterior distribution
clearvars;
clf;

% Keep relative paths stable when the script is launched from outside this folder.
scriptDir = fileparts(mfilename('fullpath'));
origDir = pwd;
cleanupObj = onCleanup(@() cd(origDir));
cd(scriptDir);
addpath(scriptDir);

% 1. MCMC results
mcmcRes = readmatrix('../1. RSV c mex Hong Kong R2 rev block update logL component rev NB fix reparam 14 15/mcmc_result/hongkong_mcmc_res.csv');
% Alternative no-sero and region-sero MCMC folders are not bundled in this GitHub package.

% 2. MCMC parameters
mcmcRes = mcmcRes(mcmcRes(:,1)~=0,:);
burnInStartIdx = max(1,floor(size(mcmcRes,1)*0.4)+1);
mcmcRes = mcmcRes(burnInStartIdx:end,:);

paramLabels = {...
    '\omega','\sigma','\gamma_0',...
    'g_1','g_2','\delta_1','\delta_2','\delta_3',...
    'p_a_s_y_m(<1)','p_a_s_y_m(1-4)','p_a_s_y_m(5-14)','p_a_s_y_m(\geq15)',...
    '\alpha','q_p','b_1','\phi','\psi','l_1(0)','l_2(0)',...
    '\epsilon_\lambda','\epsilon_c','\epsilon_5_-_5_4','\epsilon_5_5_-_7_4','\epsilon_7_5_+','\pi','\partial'};
numParams = min(size(mcmcRes,2),length(paramLabels));
numRows = 5;
numCols = 6;
defaultColorOrder = get(groot,'defaultAxesColorOrder');
posteriorColor = defaultColorOrder(1,:);
priorColor = defaultColorOrder(2,:);

figure(1)
clf
set(gcf,'Units','centimeters','Position',[2 2 29.7 21],...
    'PaperUnits','centimeters','PaperOrientation','landscape',...
    'PaperSize',[29.7 21],'PaperPosition',[0 0 29.7 21]);

figure(2)
clf
set(gcf,'Units','centimeters','Position',[2 2 29.7 21],...
    'PaperUnits','centimeters','PaperOrientation','landscape',...
    'PaperSize',[29.7 21],'PaperPosition',[0 0 29.7 21]);

for iiParms = 1:numParams
    figure(1)
    subplot(numRows,numCols,iiParms)
    plot(mcmcRes(:,iiParms),'-','Color',posteriorColor)
    title(paramLabels{iiParms},'Interpreter','tex')
    box off

    figure(2)
    subplot(numRows,numCols,iiParms)
    histogram(mcmcRes(:,iiParms),30,'FaceColor',posteriorColor,...
        'EdgeColor',posteriorColor)
    title(paramLabels{iiParms},'Interpreter','tex')
    box off
end

% Plot
figure(3)
set(gcf,'Units','centimeters','Position',[2 2 29.7 21],...
    'PaperUnits','centimeters','PaperOrientation','landscape',...
    'PaperSize',[29.7 21],'PaperPosition',[0 0 29.7 21]);
for iiParms = 1:numParams
    subplot(numRows,numCols,iiParms)
    histogram(mcmcRes(:,iiParms),30,'Normalization','pdf',...
        'FaceColor',posteriorColor,'EdgeColor',posteriorColor,...
        'FaceAlpha',0.35);
    hold on
    [xPrior, fPrior, xLimits] = getPriorCurve(iiParms,mcmcRes(:,iiParms));
    plot(xPrior,fPrior,'-','Color',priorColor,'LineWidth',1.5);
    xlim(xLimits)
    if any(iiParms == [16,25])
        xticks(linspace(xLimits(1),xLimits(2),3));
    end
    title(paramLabels{iiParms},'Interpreter','tex')
    box off
end

disp(prctile(1./mcmcRes(:,1:3),[50,2.5,97.5]));
disp(prctile(mcmcRes,[50,2.5,97.5])');

function [xPrior, fPrior, xLimits] = getPriorCurve(paramIdx, posteriorSamples)
switch paramIdx
    case 1
        xBase = 50:0.1:250;
        fBase = normpdf(xBase,135,35);
        xPrior = fliplr(1./xBase);
        fPrior = fliplr(fBase);
        xLimits = posteriorLimits(posteriorSamples,1e-6,1/30);
    case 2
        xBase = 0.05:0.01:20;
        fBase = gampdf(xBase,2,1);
        xPrior = fliplr(1./xBase);
        fPrior = fliplr(fBase);
        xLimits = posteriorLimits(posteriorSamples,1/30,100);
    case 3
        xBase = 0.05:0.01:20;
        fBase = wblpdf(xBase,4,2);
        xPrior = fliplr(1./xBase);
        fPrior = fliplr(fBase);
        xLimits = posteriorLimits(posteriorSamples,1/30,100);
    case 4
        xPrior = 0:0.001:1;
        fPrior = wblpdf(xPrior,0.879,34.224);
        xLimits = posteriorLimits(posteriorSamples,0,1);
    case 5
        xPrior = 0.01:0.001:1.5;
        fPrior = lognpdf(xPrior,-0.561,0.163);
        xLimits = posteriorLimits(posteriorSamples,0,1.5);
    case 6
        xPrior = 0:0.001:1;
        fPrior = betapdf(xPrior,35.583,11.417);
        xLimits = posteriorLimits(posteriorSamples,0,1);
    case 7
        xPrior = 0:0.001:1;
        fPrior = betapdf(xPrior,22.829,3.171);
        xLimits = posteriorLimits(posteriorSamples,0,1);
    case 8
        xPrior = 0:0.001:1;
        fPrior = betapdf(xPrior,6.117,12.882);
        xLimits = posteriorLimits(posteriorSamples,0,1);
    case 9
        xPrior = 0:0.001:1;
        fPrior = betapdf(xPrior,3.003,29.997);
        xLimits = posteriorLimits(posteriorSamples,0,1);
    case 10
        xPrior = 0:0.001:1;
        fPrior = betapdf(xPrior,8.996,43.004);
        xLimits = posteriorLimits(posteriorSamples,0,1);
    case 11
        xPrior = 0:0.001:1;
        fPrior = betapdf(xPrior,38.033,34.967);
        xLimits = posteriorLimits(posteriorSamples,0,1);
    case 12
        xPrior = 0:0.001:1;
        fPrior = betapdf(xPrior,35.955,11.045);
        xLimits = posteriorLimits(posteriorSamples,0,1);
    case 13
        xPrior = [0,1];
        fPrior = [1,1];
        xLimits = posteriorLimits(posteriorSamples,0,1);
    case 14
        xPrior = 0:0.001:1;
        fPrior = ones(size(xPrior))*normpdf(0.1,0.1);
        xLimits = posteriorLimits(posteriorSamples,0,1);
    case 15
        xPrior = linspace(0,500,1000);
        expRateAmp = 1/100;
        truncNorm = exp(-expRateAmp*0) - exp(-expRateAmp*500);
        fPrior = expRateAmp*exp(-expRateAmp*xPrior)./truncNorm;
        xLimits = posteriorLimits(posteriorSamples,0,500);
    case {16,17,18,19}
        xPrior = [0,1];
        fPrior = [1,1];
        xLimits = posteriorLimits(posteriorSamples,0,1);
    case {20,21}
        xPrior = [-10,0];
        fPrior = [1/10,1/10];
        xLimits = posteriorLimits(posteriorSamples,-10,0);
    case {22,23,24}
        xPrior = 0:0.0001:0.1;
        fPrior = normpdf(xPrior,0.02,0.02);
        xLimits = posteriorLimits(posteriorSamples,0,1);
    case 25
        xPrior = [0,1];
        fPrior = [1,1];
        xLimits = posteriorLimits(posteriorSamples,0,1);
    case 26
        xPrior = linspace(1e-9,100,1000);
        expRateDisp = 20;
        truncNorm = exp(-expRateDisp*1e-9) - exp(-expRateDisp*100);
        fPrior = expRateDisp*exp(-expRateDisp*xPrior)./truncNorm;
        xLimits = posteriorLimits(posteriorSamples,1e-9,100);
    otherwise
        xPrior = [0,1];
        fPrior = [0,0];
        xLimits = posteriorLimits(posteriorSamples,min(posteriorSamples),max(posteriorSamples));
end
end

function xLimits = posteriorLimits(samples, lowerBound, upperBound)
quantiles = prctile(samples,[1,99]);
if any(~isfinite(quantiles))
    quantiles = [min(samples), max(samples)];
end
if quantiles(1) == quantiles(2)
    width = max(abs(quantiles(1))*0.1,1e-6);
else
    width = 0.1*(quantiles(2)-quantiles(1));
end
xLimits = [max(lowerBound,quantiles(1)-width), min(upperBound,quantiles(2)+width)];
if xLimits(1) >= xLimits(2)
    xLimits = [lowerBound, upperBound];
end
end
