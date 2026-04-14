% main_plot_combined_impact.m
% Combined figure showing percentage reduction in reported RSV outcomes
% by age group for Hong Kong, Beijing and Thailand (3 panels, top to bottom).
clearvars;
clf;

% Paths to RSV_simulation.mat for each region
matFiles = {
    'RSV_simulation.mat', ...                                              % HK (current folder)
    '../11. RSV simulation only with mAb and vaccination BJ/RSV_simulation.mat', ...  % BJ
    '../12. RSV simulation only with mAb and vaccination Thailand/RSV_simulation.mat'  % Thailand
};
regionLabels = {'Hong Kong', 'Beijing', 'Thailand'};

numAgeGroups = 25;

% Compute yearlyAvgReportOutcomePerc8 for each region
perc8All = cell(1, 3);
for rr = 1:3
    S = load(matFiles{rr});
    numRnd = size(S.yearlyAgeSpecificReportOutcome, 3);
    percReduction = S.yearlyAgeSpecificReportOutcome ./ S.yearlyAgeSpecificOutcomeNoIntervention;

    yearlyAvgReportOutcomePerc8 = zeros(8, 3, 6);
    for kkStrategy = 1:6
        % 0-11 months (indices 1:12)
        temp = mean(percReduction(:,1:12,:,kkStrategy), 1);
        tempR = reshape(temp, 12, numRnd);
        tempN = reshape(mean(S.yearlyAgeSpecificOutcomeNoIntervention(:,1:12,:,kkStrategy), 1), 12, numRnd);
        yearlyAvgReportOutcomePerc8(1,:,kkStrategy) = prctile(...
            sum(tempN.*tempR, 1) ./ sum(tempN, 1), [50, 2.5, 97.5]);
        % 12-23 months (index 13)
        temp = mean(percReduction(:,13,:,kkStrategy), 1);
        tempR = reshape(temp, 1, numRnd);
        tempN = reshape(mean(S.yearlyAgeSpecificOutcomeNoIntervention(:,13,:,kkStrategy), 1), 1, numRnd);
        yearlyAvgReportOutcomePerc8(2,:,kkStrategy) = prctile(...
            sum(tempN.*tempR, 1) ./ sum(tempN, 1), [50, 2.5, 97.5]);
        % 2-4 years (indices 14:16)
        temp = mean(percReduction(:,14:16,:,kkStrategy), 1);
        tempR = reshape(temp, 3, numRnd);
        tempN = reshape(mean(S.yearlyAgeSpecificOutcomeNoIntervention(:,14:16,:,kkStrategy), 1), 3, numRnd);
        yearlyAvgReportOutcomePerc8(3,:,kkStrategy) = prctile(...
            sum(tempN.*tempR, 1) ./ sum(tempN, 1), [50, 2.5, 97.5]);
        % 5-17 years (indices 17,18 full + index 19 at 3/10)
        temp4_1 = mean(percReduction(:,17,:,kkStrategy), 1) + mean(percReduction(:,18,:,kkStrategy), 1);
        temp4_2 = 0.3*mean(percReduction(:,19,:,kkStrategy), 1);
        tempR = reshape((temp4_1 + temp4_2)/2.3, 1, numRnd);
        tempN = reshape(mean(...
            S.yearlyAgeSpecificOutcomeNoIntervention(:,17,:,kkStrategy) + ...
            S.yearlyAgeSpecificOutcomeNoIntervention(:,18,:,kkStrategy) + ...
            0.3*S.yearlyAgeSpecificOutcomeNoIntervention(:,19,:,kkStrategy), 1), 1, numRnd);
        yearlyAvgReportOutcomePerc8(4,:,kkStrategy) = prctile(...
            sum(tempN.*tempR, 1) ./ sum(tempN, 1), [50, 2.5, 97.5]);
        % 18-59 years (index 19 at 7/10 + indices 20:22 full + index 23 at 5/10)
        temp5_1 = 0.7*mean(percReduction(:,19,:,kkStrategy), 1);
        temp5_2 = mean(percReduction(:,20,:,kkStrategy), 1) + mean(percReduction(:,21,:,kkStrategy), 1) + mean(percReduction(:,22,:,kkStrategy), 1);
        temp5_3 = 0.5*mean(percReduction(:,23,:,kkStrategy), 1);
        tempR = reshape((temp5_1 + temp5_2 + temp5_3)/4.2, 1, numRnd);
        tempN = reshape(mean(...
            0.7*S.yearlyAgeSpecificOutcomeNoIntervention(:,19,:,kkStrategy) + ...
            S.yearlyAgeSpecificOutcomeNoIntervention(:,20,:,kkStrategy) + ...
            S.yearlyAgeSpecificOutcomeNoIntervention(:,21,:,kkStrategy) + ...
            S.yearlyAgeSpecificOutcomeNoIntervention(:,22,:,kkStrategy) + ...
            0.5*S.yearlyAgeSpecificOutcomeNoIntervention(:,23,:,kkStrategy), 1), 1, numRnd);
        yearlyAvgReportOutcomePerc8(5,:,kkStrategy) = prctile(...
            sum(tempN.*tempR, 1) ./ sum(tempN, 1), [50, 2.5, 97.5]);
        % 60-74 years (index 23 at 5/10 + index 24 full)
        temp6_1 = 0.5*mean(percReduction(:,23,:,kkStrategy), 1);
        temp6_2 = mean(percReduction(:,24,:,kkStrategy), 1);
        tempR = reshape((temp6_1 + temp6_2)/1.5, 1, numRnd);
        tempN = reshape(mean(...
            S.yearlyAgeSpecificOutcomeNoIntervention(:,23,:,kkStrategy) + ...
            S.yearlyAgeSpecificOutcomeNoIntervention(:,24,:,kkStrategy), 1), 1, numRnd);
        yearlyAvgReportOutcomePerc8(6,:,kkStrategy) = prctile(...
            sum(tempN.*tempR, 1) ./ sum(tempN, 1), [50, 2.5, 97.5]);
        % 75+ years (index 25)
        temp = mean(percReduction(:,25,:,kkStrategy), 1);
        tempR = reshape(temp, 1, numRnd);
        tempN = reshape(mean(S.yearlyAgeSpecificOutcomeNoIntervention(:,25,:,kkStrategy), 1), 1, numRnd);
        yearlyAvgReportOutcomePerc8(7,:,kkStrategy) = prctile(...
            sum(tempN.*tempR, 1) ./ sum(tempN, 1), [50, 2.5, 97.5]);
        % All ages (indices 1:25)
        temp = mean(percReduction(:,:,:,kkStrategy), 1);
        tempR = reshape(temp, numAgeGroups, numRnd);
        tempN = reshape(mean(S.yearlyAgeSpecificOutcomeNoIntervention(:,:,:,kkStrategy), 1), [], numRnd);
        yearlyAvgReportOutcomePerc8(8,:,kkStrategy) = prctile(...
            sum(tempN.*tempR, 1) ./ sum(tempN, 1), [50, 2.5, 97.5]);
    end
    perc8All{rr} = yearlyAvgReportOutcomePerc8;
end

% Plot combined figure (3 rows x 1 column)
ageGroupLabels = {'0-11m', '12-23m', '2-4y', '5-17y', '18-59y', '60-74y', '75+y', 'All'};
strategyIdx = [1, 2, 3, 6];
strategyLabels = {'mAb', 'Maternal vax.', 'Older adult vax.', ...
    'mAb + Maternal vax. + Older adult vax.'};
colors = [
    0      0.4470  0.7410;
    0.8500 0.3250  0.0980;
    0.9290 0.6940  0.1250;
    0.4940 0.1840  0.5560;
];
markers = {'o', 's', 'd', '^'};
nStrategies = length(strategyIdx);
nAgeGroups = length(ageGroupLabels);
xBase = 1:nAgeGroups;
offsets = linspace(-0.15, 0.15, nStrategies);

fig = figure;
% A4: 21.0 x 29.7 cm. 2/3 width = 14.0 cm, full height = 29.7 cm
set(fig, 'Units', 'centimeters', 'Position', [2, 1, 14.0, 29.7]);
set(fig, 'PaperUnits', 'centimeters', 'PaperSize', [14.0, 29.7], 'PaperPosition', [0, 0, 14.0, 29.7]);
for rr = 1:3
    subplot(3, 1, rr);

    data = perc8All{rr};
    allMedian = reshape(data(:,1,:), 8, 6) * 100;
    allLower  = reshape(data(:,2,:), 8, 6) * 100;
    allUpper  = reshape(data(:,3,:), 8, 6) * 100;
    medianPct = allMedian(:, strategyIdx);
    lowerPct  = allLower(:, strategyIdx);
    upperPct  = allUpper(:, strategyIdx);
    lowerError = medianPct - lowerPct;
    upperError = upperPct - medianPct;

    hold on;
    hh = gobjects(1, nStrategies);
    for i = 1:nStrategies
        xpos = xBase + offsets(i);
        hh(i) = errorbar(xpos, medianPct(:,i), lowerError(:,i), upperError(:,i), ...
            markers{i}, 'Color', colors(i,:), 'MarkerFaceColor', colors(i,:), ...
            'MarkerSize', 7, 'LineWidth', 1, 'CapSize', 4, 'LineStyle', 'none');
    end

    yline(0, '--k');

    if rr == 2
        ylabel('Reduction in reported outcomes (%)', 'FontSize', 12);
    end
    xlim([0.5, nAgeGroups + 0.5]);
    ylim([-25, 75]);
    yticks(-25:25:75)
    xticks(xBase);
    xticklabels(ageGroupLabels);
    xtickangle(45);
    % title(regionLabels{rr}, 'FontSize', 14);

    ax = gca;
    set(ax, 'FontSize', 11, 'LineWidth', 1);
    ax.XAxis.TickDirection = 'out';
    ax.YAxis.TickDirection = 'out';
    ax.Box = 'off';
    grid off;
    hold off;

    % Add legend only to the first panel
    if rr == 1
        leg = legend(hh, strategyLabels, 'Location', 'northeast', 'FontSize', 9);
        set(leg, 'Box', 'off');
    end
end

% Add shared x-label at the bottom
subplot(3, 1, 3);
xlabel('Age group', 'FontSize', 12);
