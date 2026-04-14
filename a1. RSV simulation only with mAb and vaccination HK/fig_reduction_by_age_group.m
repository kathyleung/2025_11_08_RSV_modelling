function fig = fig_reduction_by_age_group(yearlyAvgReportOutcomePerc8)
% fig_reduction_by_age_group  Grouped bar plot of percentage reduction in
% reported RSV outcomes by age group and prophylactic strategy.
%
%   yearlyAvgReportOutcomePerc8: 8 x 3 x 6 array
%       dim 1 = 8 age groups
%       dim 2 = [median, 2.5th, 97.5th percentile]
%       dim 3 = 6 strategies

    figure(8);
    clf;

    % Labels
    ageGroupLabels = {'0-11m', '12-23m', '2-4y', '5-17y', '18-59y', '60-74y', '75+y', 'All'};
    % Select 4 strategies: 1=mAb, 2=Maternal vax, 3=Elderly vax, 6=All combined
    strategyIdx = [1, 2, 3, 6];
    strategyLabels = {'mAb', 'Maternal vax.', 'Older adult vax.', ...
        'mAb + Maternal + Older adult vax.'};

    % Extract data (8 age groups x 4 selected strategies)
    allMedian = reshape(yearlyAvgReportOutcomePerc8(:,1,:), 8, 6) * 100;
    allLower  = reshape(yearlyAvgReportOutcomePerc8(:,2,:), 8, 6) * 100;
    allUpper  = reshape(yearlyAvgReportOutcomePerc8(:,3,:), 8, 6) * 100;
    medianPct = allMedian(:, strategyIdx);
    lowerPct  = allLower(:, strategyIdx);
    upperPct  = allUpper(:, strategyIdx);

    lowerError = medianPct - lowerPct;
    upperError = upperPct - medianPct;

    % Colors (matching workspace style)
    colors = [
        0      0.4470  0.7410;   % blue
        0.8500 0.3250  0.0980;   % orange
        0.9290 0.6940  0.1250;   % yellow
        0.4940 0.1840  0.5560;   % purple
    ];

    % Grouped bar plot
    hb = bar(medianPct, 'grouped');
    hold on;

    % Apply colors
    for i = 1:length(hb)
        hb(i).FaceColor = colors(i,:);
    end

    % Error bars at correct x positions
    xpos = zeros(size(medianPct));
    for i = 1:length(hb)
        xpos(:,i) = hb(i).XEndPoints;
    end
    for i = 1:size(medianPct,2)
        errorbar(xpos(:,i), medianPct(:,i), lowerError(:,i), upperError(:,i), ...
            'k.', 'LineWidth', 0.75, 'CapSize', 0);
    end

    % Axes formatting
    xlabel('Age group', 'FontSize', 14);
    ylabel('Reduction in reported outcomes (%)', 'FontSize', 14);

    xticks(1:length(ageGroupLabels));
    xticklabels(ageGroupLabels);
    xtickangle(45);

    % Legend
    leg = legend(hb, strategyLabels, 'Location', 'northeast', 'FontSize', 10);
    set(leg, 'Box', 'off');

    % Axes style
    ax = gca;
    set(ax, 'FontSize', 12, 'LineWidth', 1);
    ax.XAxis.TickDirection = 'out';
    ax.YAxis.TickDirection = 'out';
    ax.Box = 'off';
    grid off;

    hold off;
    fig = gcf;
end
