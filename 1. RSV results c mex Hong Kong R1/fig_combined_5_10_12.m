function out = fig_combined_5_10_12(...
    mcRecMonthlyByAgePrctile, monthlyCaseRSV, populationAgeGroup, dateZero, cutoffCOVID, ...
    mcRecSerologyPrctile, seroprevData, dataSerologyMean, dataSerologyCI, ...
    mcRecSerologyMetaPrctile, seroprevDataMeta, dataSerologyMetaMean, dataSerologyMetaCI, ...
    mcRecSerologyHKPrctile, seroprevDataHKRec, dataSerologyHKMean, dataSerologyHKCI)
% FIG_COMBINED_5_10_12 Combined figure: monthly rates, period average
% rates, and seroprevalence for RSV model validation.
%
% Layout (5 rows x 6 columns via tiledlayout):
%   Rows 1-3:    Monthly RSV rates per 100,000 by age — 6 panels (Figure 10)
%   Row 4:       Average yearly rates bar chart (Figure 12) — 1 panel
%   Row 5:       Seroprevalence (HK, Beijing, Thailand) — 3 panels (Figure 5)

    % Consistent colours
    modelColor    = [0, 0.4470, 0.7410];       % blue
    observedColor = [0.8500, 0.3250, 0.0980];   % red-orange

    % --- Create figure ---
    fig_handle = figure('Units', 'centimeters', 'Position', [1, 1, 18, 28]);
    set(fig_handle, 'Color', 'white');
    t = tiledlayout(5, 6, 'TileSpacing', 'compact', 'Padding', 'compact');

    % =====================================================================
    % ROWS 1-3 — Monthly RSV rates per 100,000 by age (Figure 10)
    % =====================================================================

    % Convert model output to rates per 100,000
    mtrSize = size(mcRecMonthlyByAgePrctile);
    mcRatesMonthly = mcRecMonthlyByAgePrctile ./ ...
        repmat(mean(populationAgeGroup), mtrSize(1), 1, mtrSize(3)) * 100000;

    % Prepare observed data (rate-converted copy, cut at COVID)
    monthlyCaseRSVcut = monthlyCaseRSV(monthlyCaseRSV.month_start < cutoffCOVID, :);
    nObsCut = size(monthlyCaseRSVcut, 1);
    monthlyCaseRSVcut{:,4:9} = monthlyCaseRSVcut{:,4:9} ./ ...
        repmat(mean(populationAgeGroup), nObsCut, 1) * 100000;

    age_labels_monthly = {'0-5 months', '6-11 months', '1-4 years', ...
                          '5-64 years', '65-74 years', '75+ years'};
    ylimArr = [1200, 800, 300, 5, 15, 100];

    for ageGroup = 1:6
        nexttile([1, 3]);
        hold on;

        data_col = ageGroup + 3;

        % --- Left axis: model ---
        yyaxis left;
        x_fill = [monthlyCaseRSVcut.month_start; flipud(monthlyCaseRSVcut.month_start)];
        y_fill = [mcRatesMonthly(1:nObsCut, ageGroup, 2); ...
                  flipud(mcRatesMonthly(1:nObsCut, ageGroup, 3))];
        fill(x_fill, y_fill, modelColor, 'FaceAlpha', 0.3, 'EdgeColor', 'none');
        hModelM = plot(monthlyCaseRSVcut.month_start, ...
            mcRatesMonthly(1:nObsCut, ageGroup, 1), '-', ...
            'Color', modelColor, 'LineWidth', 0.8);
        ylabel('Model (per 100k)', 'Color', modelColor, 'FontSize', 7);
        set(gca, 'YColor', modelColor);
        ylim([0, ylimArr(ageGroup)]);

        % --- Right axis: observed ---
        yyaxis right;
        hObsM = plot(monthlyCaseRSVcut.month_start, ...
            smooth(monthlyCaseRSVcut{:, data_col}, 1), '-', ...
            'Color', observedColor, 'LineWidth', 0.8);
        ylabel('Observed (per 100k)', 'Color', observedColor, 'FontSize', 7);
        set(gca, 'YColor', observedColor);
        ylim([0, ylimArr(ageGroup)]);

        title(age_labels_monthly{ageGroup}, 'FontSize', 8);

        % Year tick marks
        years = unique(year(dateZero + monthlyCaseRSVcut.month_start));
        tick_positions = [];
        tick_labels_yr = {};
        for i = 1:length(years)
            jan_pos = days(datetime(years(i), 1, 1) - dateZero);
            if jan_pos >= min(monthlyCaseRSVcut.month_start) && ...
               jan_pos <= max(monthlyCaseRSVcut.month_start)
                tick_positions(end+1) = jan_pos; %#ok<AGROW>
                tick_labels_yr{end+1} = num2str(years(i)); %#ok<AGROW>
            end
        end
        set(gca, 'XTick', tick_positions, 'XTickLabel', tick_labels_yr, 'FontSize', 6);
        xlim([min(monthlyCaseRSVcut.month_start), max(monthlyCaseRSVcut.month_start)]);
        grid off; box off;

        % Legend on second panel only
        if ageGroup == 2
            hLegM = legend([hModelM, hObsM], {'Model estimates','Observed RSV'});
            set(hLegM, 'Box', 'off', 'FontSize', 6);
        end
        hold off;
    end

    % =====================================================================
    % ROW 5 — Average yearly rates bar chart (Figure 12)
    % =====================================================================

    nexttile([1, 6]);
    hold on;

    populationAgeGroupMean = mean(populationAgeGroup, 1);
    mcRatesBar = mcRecMonthlyByAgePrctile ./ ...
        repmat(populationAgeGroupMean, mtrSize(1), 1, mtrSize(3)) * 100000;

    % Filter to 2015-2019
    monthlyCaseRSVbar = monthlyCaseRSV(monthlyCaseRSV.month_start < cutoffCOVID, :);
    monthlyCaseRSVbar.Year = year(dateZero + monthlyCaseRSVbar.month_start);
    targetYears = 2015:2019;
    yearMask = ismember(monthlyCaseRSVbar.Year, targetYears);
    monthlyCaseRSVbar = monthlyCaseRSVbar(yearMask, :);
    mcRatesBar = mcRatesBar(yearMask, :, :);

    numAgeGroups = 6;
    obs_rate          = zeros(numAgeGroups, 1);
    model_median_rate = zeros(numAgeGroups, 1);
    model_lower_rate  = zeros(numAgeGroups, 1);
    model_upper_rate  = zeros(numAgeGroups, 1);

    uniqueYears = unique(monthlyCaseRSVbar.Year);
    numYears    = length(uniqueYears);

    for ag = 1:numAgeGroups
        data_col = ag + 3;
        yearly_obs = zeros(numYears, 1);
        yearly_med = zeros(numYears, 1);
        yearly_lo  = zeros(numYears, 1);
        yearly_hi  = zeros(numYears, 1);
        for yy = 1:numYears
            yidx = monthlyCaseRSVbar.Year == uniqueYears(yy);
            yearly_obs(yy) = sum(monthlyCaseRSVbar{yidx, data_col});
            yearly_med(yy) = sum(mcRatesBar(yidx, ag, 1));
            yearly_lo(yy)  = sum(mcRatesBar(yidx, ag, 2));
            yearly_hi(yy)  = sum(mcRatesBar(yidx, ag, 3));
        end
        obs_rate(ag)          = mean(yearly_obs) / populationAgeGroupMean(ag) * 100000;
        model_median_rate(ag) = mean(yearly_med);
        model_lower_rate(ag)  = mean(yearly_lo);
        model_upper_rate(ag)  = mean(yearly_hi);
    end

    groupedBarData = [obs_rate, model_median_rate];
    b = bar(1:numAgeGroups, groupedBarData, 'grouped');
    b(1).FaceColor = observedColor;
    b(1).EdgeColor = 'none';
    b(1).FaceAlpha = 0.7;
    b(2).FaceColor = modelColor;
    b(2).EdgeColor = 'none';
    b(2).FaceAlpha = 0.7;

    err_lower = model_median_rate - model_lower_rate;
    err_upper = model_upper_rate  - model_median_rate;
    xCenters  = b(2).XEndPoints;
    valid     = ~isnan(model_median_rate);
    errorbar(xCenters(valid), model_median_rate(valid), ...
        err_lower(valid), err_upper(valid), ...
        'k', 'LineStyle', 'none', 'LineWidth', 0.8, 'CapSize', 4);

    age_labels_bar = {'0-5 months','6-11 months','1-4 years', ...
                      '5-64 years','65-74 years','75+ years'};
    set(gca, 'XTick', 1:numAgeGroups, 'XTickLabel', age_labels_bar, 'FontSize', 7);
    xlabel('Age group', 'FontSize', 8);
    ylabel('Cases per 100,000', 'FontSize', 8);
    title(sprintf('Average yearly reported RSV cases per 100,000 (%d-%d)', ...
        min(targetYears), max(targetYears)), 'FontSize', 8, 'FontWeight', 'bold');
    lgdBar = legend({'Observed','Model estimate'}, 'FontSize', 6, 'Location', 'northeast');
    lgdBar.Box = 'off';
    box off;
    set(gca, 'TickDir', 'out');
    hold off;

    % =====================================================================
    % ROW 5 — Seroprevalence (Figure 5)
    % =====================================================================

    % --- Panel h: Hong Kong seroprevalence ---
    nexttile([1, 2]);
    hold on;
    unique_ages_hk = (1:length(seroprevDataHKRec.age_start)) - 1;

    yyaxis left;
    errorbar(unique_ages_hk - 0.05, mcRecSerologyHKPrctile(:,1), ...
        mcRecSerologyHKPrctile(:,1) - mcRecSerologyHKPrctile(:,2), ...
        mcRecSerologyHKPrctile(:,3) - mcRecSerologyHKPrctile(:,1), ...
        '^-', 'Color', modelColor, 'LineWidth', 0.75, ...
        'MarkerSize', 3, 'CapSize', 3, 'MarkerFaceColor', modelColor);
    ylabel('Model estimates', 'Color', modelColor, 'FontSize', 8);
    set(gca, 'YColor', modelColor);
    ylim([0, 1]);

    yyaxis right;
    errorbar(unique_ages_hk + 0.05, dataSerologyHKMean, ...
        dataSerologyHKMean - dataSerologyHKCI(:,1), ...
        dataSerologyHKCI(:,2) - dataSerologyHKMean, ...
        'o-', 'Color', observedColor, 'LineWidth', 0.75, ...
        'MarkerSize', 3, 'CapSize', 3, 'MarkerFaceColor', observedColor);
    ylabel('Observed', 'Color', observedColor, 'FontSize', 8);
    set(gca, 'YColor', observedColor);
    ylim([0, 1]);

    title('Hong Kong, 2020', 'FontSize', 8);
    grid off; box off;
    set(gca, 'XTick', unique_ages_hk, ...
        'XTickLabel', {'0-11m','12-23m','2-4y','5-9y','10-14y', ...
                       '15-19y','20-39y','40-59y','60-80y'}, ...
        'FontSize', 6);
    xtickangle(45);
    xlim([-0.5, max(unique_ages_hk)*1.05]);
    hold off;

    % --- Panel i: Beijing seroprevalence (from meta-analysis) ---
    nexttile([1, 2]);
    hold on;

    uniquePMIDs  = unique(seroprevDataMeta.PMID);
    currentPMID  = uniquePMIDs(3);
    pmidIndices  = find(seroprevDataMeta.PMID == currentPMID);

    yyaxis left;
    hModelSero = errorbar((1:length(pmidIndices)) - 0.05, ...
        mcRecSerologyMetaPrctile(pmidIndices,1), ...
        mcRecSerologyMetaPrctile(pmidIndices,1) - mcRecSerologyMetaPrctile(pmidIndices,2), ...
        mcRecSerologyMetaPrctile(pmidIndices,3) - mcRecSerologyMetaPrctile(pmidIndices,1), ...
        '^-', 'Color', modelColor, 'LineWidth', 0.75, ...
        'MarkerSize', 3, 'CapSize', 3, 'MarkerFaceColor', modelColor);
    ylabel('Model estimates', 'Color', modelColor, 'FontSize', 8);
    set(gca, 'YColor', modelColor);
    ylim([0, 1]);

    yyaxis right;
    hObsSero = errorbar((1:length(pmidIndices)) + 0.05, ...
        dataSerologyMetaMean(pmidIndices), ...
        dataSerologyMetaMean(pmidIndices) - dataSerologyMetaCI(pmidIndices,1), ...
        dataSerologyMetaCI(pmidIndices,2) - dataSerologyMetaMean(pmidIndices), ...
        'o-', 'Color', observedColor, 'LineWidth', 0.75, ...
        'MarkerSize', 3, 'CapSize', 3, 'MarkerFaceColor', observedColor);
    ylabel('Observed', 'Color', observedColor, 'FontSize', 8);
    set(gca, 'YColor', observedColor);
    ylim([0, 1]);

    % Build age-range tick labels for Beijing
    ageLabels = cell(length(pmidIndices), 1);
    for jj = 1:length(pmidIndices)
        idx = pmidIndices(jj);
        startMonth = round(seroprevDataMeta.ageStart(idx) * 12);
        endMonth   = round(seroprevDataMeta.ageEnd(idx) * 12);
        if startMonth == endMonth
            if startMonth < 24
                ageLabels{jj} = sprintf('%dm', startMonth);
            else
                ageLabels{jj} = sprintf('%dy', startMonth/12);
            end
        elseif endMonth < 24
            ageLabels{jj} = sprintf('%d-%dm', startMonth, endMonth);
        elseif startMonth >= 60 && endMonth >= 60
            ageLabels{jj} = sprintf('%d-%dy', round(startMonth/12), round(endMonth/12));
        else
            if mod(startMonth,12)==0 && mod(endMonth,12)==0
                ageLabels{jj} = sprintf('%d-%dy', startMonth/12, endMonth/12);
            else
                ageLabels{jj} = sprintf('%d-%dm', startMonth, endMonth);
            end
        end
    end
    set(gca, 'XTick', 1:length(pmidIndices), 'XTickLabel', ageLabels, 'FontSize', 6);
    xtickangle(45);
    xlim([0.5, length(pmidIndices)+0.5]);

    studyCountry = seroprevDataMeta.study_country{pmidIndices(1)};
    studyYear    = seroprevDataMeta.study_year{pmidIndices(1)};
    title(sprintf('%s, %s', studyCountry, studyYear), 'FontSize', 8);
    grid off; box off;

    hLegendSero = legend([hModelSero, hObsSero], ...
        {'Model estimates','Observed seroprevalence'});
    set(hLegendSero, 'Location', 'southeast', 'Box', 'off', 'FontSize', 6);
    hold off;

    % --- Panel j: Thailand seroprevalence ---
    nexttile([1, 2]);
    hold on;

    seroprevData.age_by_year(1) = -1;   % pregnant women coded as −1

    yyaxis left;
    errorbar(seroprevData.age_by_year - 0.05, mcRecSerologyPrctile(:,1), ...
        mcRecSerologyPrctile(:,1) - mcRecSerologyPrctile(:,2), ...
        mcRecSerologyPrctile(:,3) - mcRecSerologyPrctile(:,1), ...
        '^-', 'Color', modelColor, 'LineWidth', 0.75, ...
        'MarkerSize', 3, 'CapSize', 3, 'MarkerFaceColor', modelColor);
    ylabel('Model estimates', 'Color', modelColor, 'FontSize', 8);
    set(gca, 'YColor', modelColor);
    ylim([0, 1]);

    yyaxis right;
    errorbar(seroprevData.age_by_year + 0.05, dataSerologyMean, ...
        dataSerologyMean - dataSerologyCI(:,1), ...
        dataSerologyCI(:,2) - dataSerologyMean, ...
        'o-', 'Color', observedColor, 'LineWidth', 0.75, ...
        'MarkerSize', 3, 'CapSize', 3, 'MarkerFaceColor', observedColor);
    ylabel('Observed', 'Color', observedColor, 'FontSize', 8);
    set(gca, 'YColor', observedColor);
    ylim([0, 1]);

    title('Thailand, 2015-2021', 'FontSize', 8);
    grid off; box off;

    unique_ages_thai = unique(round(seroprevData.age_by_year));
    xticks_labels_thai = cell(size(unique_ages_thai));
    xticks_labels_thai{1} = 'M';
    for ii = 2:length(unique_ages_thai)
        age_months = round(seroprevData.age_by_month(ii));
        if age_months < 24
            xticks_labels_thai{ii} = sprintf('%dm', age_months);
        else
            xticks_labels_thai{ii} = sprintf('%dy', unique_ages_thai(ii));
        end
    end
    set(gca, 'XTick', unique_ages_thai, 'XTickLabel', xticks_labels_thai, 'FontSize', 6);
    xtickangle(45);
    xlim([-1.5, max(seroprevData.age_by_year)*1.05]);
    hold off;

    % =====================================================================
    % Panel labels (a – j)
    % =====================================================================
    AddLetters2Plots(fig_handle, ...
        {'a','b','c','d','e','f','g','h','i','j'});

    out = fig_handle;
end
