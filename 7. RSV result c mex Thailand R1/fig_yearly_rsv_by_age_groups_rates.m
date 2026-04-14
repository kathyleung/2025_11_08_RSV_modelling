function [out, rec] = fig_yearly_rsv_by_age_groups_rates(mcRecMonthlyByAgePrctile, monthlyCaseRSV, populationAgeGroup, dateZero, cutoffCOVID)
    % 5 subplots (one per age group), each showing grouped bars of
    % estimated vs observed RSV hospitalisation cases per 100,000
    % for each year 2015-2019 (Thailand context).

    % Population denominator
    populationAgeGroupMean = mean(populationAgeGroup, 1);

    % Convert model estimates to rates per 100,000
    mtrSize = size(mcRecMonthlyByAgePrctile);
    mcRates = mcRecMonthlyByAgePrctile ./ repmat(populationAgeGroupMean, mtrSize(1), 1, mtrSize(3)) * 100000;

    % Cut off data at COVID
    monthlyCaseRSV = monthlyCaseRSV(monthlyCaseRSV.month_start < cutoffCOVID, :);

    % Add year column
    monthlyCaseRSV.Year = year(dateZero + monthlyCaseRSV.month_start);

    % Filter to 2015-2019
    targetYears = (2015:2019)';
    yearMask = ismember(monthlyCaseRSV.Year, targetYears);
    monthlyCaseRSV = monthlyCaseRSV(yearMask, :);
    mcRates = mcRates(yearMask, :, :);

    if isempty(monthlyCaseRSV)
        error('No data available for 2015-2019.');
    end

    numAgeGroups = 5;
    numYears = length(targetYears);

    age_labels = {'0-4 years', '5-19 years', '20-49 years', '50-64 years', '\geq65 years'};

    modelColor    = [0, 0.4470, 0.7410];
    observedColor = [0.8500, 0.3250, 0.0980];

    % Pre-compute yearly totals per age group (rates per 100,000)
    yearly_obs = zeros(numYears, numAgeGroups);
    yearly_med = zeros(numYears, numAgeGroups);
    yearly_lo  = zeros(numYears, numAgeGroups);
    yearly_hi  = zeros(numYears, numAgeGroups);

    for ag = 1:numAgeGroups
        data_col = ag + 3;  % columns 4-8 in the Thailand CSV
        for yy = 1:numYears
            yidx = monthlyCaseRSV.Year == targetYears(yy);
            yearly_obs(yy, ag) = sum(monthlyCaseRSV{yidx, data_col}) / populationAgeGroupMean(ag) * 100000;
            yearly_med(yy, ag) = sum(mcRates(yidx, ag, 1));
            yearly_lo(yy, ag)  = sum(mcRates(yidx, ag, 2));
            yearly_hi(yy, ag)  = sum(mcRates(yidx, ag, 3));
        end
    end

    rec = cat(3, yearly_med, yearly_lo, yearly_hi);  % numYears x numAgeGroups x 3

    % --- Create figure ---
    fig_handle = figure(13);
    clf;

    ylimArr = [300, 3, 3, 5, 15];

    for ag = 1:numAgeGroups
        ax = subplot(5, 1, ag);
        hold(ax, 'on');

        % Grouped bar data: [Observed, Model]
        groupedData = [yearly_obs(:, ag), yearly_med(:, ag)];
        b = bar(ax, targetYears, groupedData, 'grouped');

        % Style bars
        b(1).FaceColor = observedColor;
        b(1).EdgeColor = 'none';
        b(1).FaceAlpha = 0.7;
        b(2).FaceColor = modelColor;
        b(2).EdgeColor = 'none';
        b(2).FaceAlpha = 0.7;

        % Error bars on model bars
        err_lo = yearly_med(:, ag) - yearly_lo(:, ag);
        err_hi = yearly_hi(:, ag) - yearly_med(:, ag);
        xCenters = b(2).XEndPoints;
        errorbar(ax, xCenters, yearly_med(:, ag), err_lo, err_hi, ...
            'k', 'linestyle', 'none', 'LineWidth', 0.6, 'CapSize', 3);

        % Formatting
        title(ax, age_labels{ag}, 'FontSize', 10);
        set(ax, 'XTick', targetYears);
        xlim(ax, [min(targetYears)-0.5, max(targetYears)+0.5]);
        ylim(ax, [0, ylimArr(ag)]);
        box(ax, 'off');
        ax.TickDir = 'out';

        ylabel(ax, 'Cases per 100,000', 'FontSize', 10);

        % X label on bottom subplot only; hide tick labels on upper rows
        if ag == numAgeGroups
            xlabel(ax, 'Year', 'FontSize', 10);
        else
            xticklabels(ax, {});
        end

        % Legend in first subplot
        if ag == 1
            lgd = legend(ax, {'Observed', 'Model Estimate'}, 'FontSize', 8, 'Location', 'northwest');
            lgd.Box = 'off';
        end

        hold(ax, 'off');
    end

    sgtitle('Yearly Reported RSV Hospitalisation Cases per 100,000 by Age Group, Thailand (2015-2019)', ...
        'FontSize', 12, 'FontWeight', 'bold');

    out = fig_handle;
end
