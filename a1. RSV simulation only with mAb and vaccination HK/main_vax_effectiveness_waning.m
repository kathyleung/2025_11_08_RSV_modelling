
% 2024-12-28
% RSV model from David Hodgson
% clear all;
clearvars;
clf;

numRnd = 300;
figure(1);

% 1. Impact of interventions
% mAb
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
oVaxEffectiveness = 0.01*normrnd(80,(85-71)/2/1.96,[numRnd,1]);
oVaxEffectiveness(oVaxEffectiveness<0) = 1e-6;
oVaxEffectiveness(oVaxEffectiveness>1) = 1-1e-6;
% Solve
oVaxShape = 2;
tempX = 180;
oVaxScale = tempX./gaminv(1-oVaxEffectiveness, oVaxShape, 1);
oVaxScale(isnan(oVaxScale)) = Inf;
oVaxDuration = oVaxShape.*oVaxScale;

% Plot waning effectiveness over time
tDays = 0:1:1000;
nt = length(tDays);

% --- mAb ---
mAbEff = zeros(numRnd, nt);
for ii = 1:numRnd
    mAbEff(ii,:) = 1 - gamcdf(tDays, mAbShape, mAbScale(ii));
end
mAbMedian = median(mAbEff, 1);
mAbLo = prctile(mAbEff, 2.5, 1);
mAbHi = prctile(mAbEff, 97.5, 1);

subplot(3,1,1);
hold on;
fill([tDays, fliplr(tDays)], [mAbHi, fliplr(mAbLo)], ...
    [0.8 0.85 1], 'EdgeColor', 'none', 'FaceAlpha', 0.5);
plot(tDays, mAbMedian, 'b', 'LineWidth', 1.5);
hold off;
xlabel('Days after administration');
ylabel('Effectiveness');
title('Infant mAb');
ylim([0 1]);
xlim([0 1000]);

% --- Maternal vaccination ---
mVaxEff = zeros(numRnd, nt);
for ii = 1:numRnd
    mVaxEff(ii,:) = 1 - gamcdf(tDays, mVaxShape, mVaxScale(ii));
end
mVaxMedian = median(mVaxEff, 1);
mVaxLo = prctile(mVaxEff, 2.5, 1);
mVaxHi = prctile(mVaxEff, 97.5, 1);

subplot(3,1,2);
hold on;
fill([tDays, fliplr(tDays)], [mVaxHi, fliplr(mVaxLo)], ...
    [0.8 1 0.8], 'EdgeColor', 'none', 'FaceAlpha', 0.5);
plot(tDays, mVaxMedian, 'Color', [0 0.6 0], 'LineWidth', 1.5);
hold off;
xlabel('Days after administration');
ylabel('Effectiveness');
title('Maternal vaccination');
ylim([0 1]);
xlim([0 1000]);

% --- Older adult vaccination ---
oVaxEff = zeros(numRnd, nt);
for ii = 1:numRnd
    oVaxEff(ii,:) = 1 - gamcdf(tDays, oVaxShape, oVaxScale(ii));
end
oVaxMedian = median(oVaxEff, 1);
oVaxLo = prctile(oVaxEff, 2.5, 1);
oVaxHi = prctile(oVaxEff, 97.5, 1);

subplot(3,1,3);
hold on;
fill([tDays, fliplr(tDays)], [oVaxHi, fliplr(oVaxLo)], ...
    [1 0.85 0.8], 'EdgeColor', 'none', 'FaceAlpha', 0.5);
plot(tDays, oVaxMedian, 'r', 'LineWidth', 1.5);
hold off;
xlabel('Days after administration');
ylabel('Effectiveness');
title('Older adult vaccination');
ylim([0 1]);
xlim([0 1000]);

