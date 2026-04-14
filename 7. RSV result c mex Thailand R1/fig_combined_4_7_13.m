function [out, yearlyRatesRec] = fig_combined_4_7_13(...
    mcRecMonthlyByAgePrctile, monthlyILICaseRSV, populationAgeGroup, dateZero, cutoffCOVID, ...
    mcRecSerologyPrctile, seroprevData, dataSerologyMean, dataSerologyCI, ...
    mcRecSerologyMetaPrctile, seroprevDataMeta, dataSerologyMetaMean, dataSerologyMetaCI, ...
    mcRecSerologyHKPrctile, seroprevDataHKRec, dataSerologyHKMean, dataSerologyHKCI)
% FIG_COMBINED_4_7_13  Combined figure with:
%   Left column  (panels a-e): Monthly RSV ALRI hospitalisation rates per 100,000
%   Right column (panels f-h): RSV seroprevalence model fit (HK, Beijing, Thailand)
%   Right column (panel i):    Average yearly RSV hospitalisation rates (2015-2019 combined)

    % --- Colour palette ---
    modelColor    = [0, 0.4470, 0.7410];
    observedColor = [0.8500, 0.3250, 0.0980];

    % =====================================================================
    % Prepare data for monthly rates (Figure 4)
    % =====================================================================
    mtrSize = size(mcRecMonthlyByAgePrctile);
    mcRatesMonthly = mcRecMonthlyByAgePrctile ./ ...
        repmat(mean(populationAgeGroup, 1), mtrSize(1), 1, 3) * 100000;

    monthlyCaseRSV_cut = monthlyILICaseRSV(monthlyILICaseRSV.month_start < cutoffCOVID, :);
    monthlyCaseRSV_cut{:, 4:8} = monthlyCaseRSV_cut{:, 4:8} ./ ...
        repmat(mean(populationAgeGroup, 1), height(monthlyCaseRSV_cut), 1) * 100000;

    % =====================================================================
    % Prepare data for yearly average rates (Figure 13 modified)
    % =====================================================================
    populationAgeGroupMean = mean(populationAgeGroup, 1);
    mcRatesYearly = mcRecMonthlyByAgePrctile ./ ...
        repmat(populationAgeGroupMean, mtrSize(1), 1, mtrSize(3)) * 100000;

    monthlyCaseRSV_yr = monthlyILICaseRSV(monthlyILICaseRSV.month_start < cutoffCOVID, :);
    monthlyCaseRSV_yr.Year = year(dateZero + monthlyCaseRSV_yr.month_start);
    targetYears = (2015:2019)';
    yearMask = ismember(monthlyCaseRSV_yr.Year, targetYears);
    monthlyCaseRSV_yr = monthlyCaseRSV_yr(yearMask, :);
    mcRatesYearly = mcRatesYearly(yearMask, :, :);

    numAgeGroups = 5;
    numYears = length(targetYears);
    yearly_obs = zeros(numYears, numAgeGroups);
    yearly_med = zeros(numYears, numAgeGroups);
    yearly_lo  = zeros(numYears, numAgeGroups);
    yearly_hi  = zeros(numYears, numAgeGroups);
    for ag = 1:numAgeGroups
        data_col = ag + 3;
        for yy = 1:numYears
            yidx = monthlyCaseRSV_yr.Year == targetYears(yy);
            yearly_obs(yy, ag) = sum(monthlyCaseRSV_yr{yidx, data_col}) / populationAgeGroupMean(ag) * 100000;
            yearly_med(yy, ag) = sum(mcRatesYearly(yidx, ag, 1));
            yearly_lo(yy, ag)  = sum(mcRatesYearly(yidx, ag, 2));
            yearly_hi(yy, ag)  = sum(mcRatesYearly(yidx, ag, 3));
        end
    end
    yearlyRatesRec = cat(3, yearly_med, yearly_lo, yearly_hi);

    % Average across years 2015-2019
    avg_obs = mean(yearly_obs, 1);
    avg_med = mean(yearly_med, 1);
    avg_lo  = mean(yearly_lo,  1);
    avg_hi  = mean(yearly_hi,  1);

    % =====================================================================
    % Create figure — 5 rows x 2 columns
    % =====================================================================
    fig_handle = figure(14);
    clf;
    set(fig_handle, 'Color', 'white');

    % Panel positions: manually control via subplot indices on a 10x2 grid
    % Left column: rows 1-10 (each panel spans 2 grid rows) → 5 panels
    % Right column: rows 1-6 (each panel spans 2 grid rows) → 3 sero panels
    %               rows 7-10 (spans 4 grid rows) → 1 yearly avg panel

    age_labels_monthly = {'0-4 years', '5-19 years', '20-49 years', '50-64 years', '\geq 65 years'};
    ylimAge = [80, 1, 1, 2, 4];

    % =================================================================
    % LEFT COLUMN: Monthly RSV ALRI hospitalisation rates (panels a-e)
    % =================================================================
    for ageGroup = 1:5
        ax = subplot(5, 2, (ageGroup - 1) * 2 + 1);
        hold on;

        data_col = ageGroup + 3;
        nObs = size(monthlyCaseRSV_cut, 1);

        % Left y-axis: model
        yyaxis left;
        x_fill = [monthlyCaseRSV_cut.month_start; flipud(monthlyCaseRSV_cut.month_start)];
        y_fill = [mcRatesMonthly(1:nObs, ageGroup, 2); flipud(mcRatesMonthly(1:nObs, ageGroup, 3))];
        fill(x_fill, y_fill, modelColor, 'FaceAlpha', 0.3, 'EdgeColor', 'none');
        plot(monthlyCaseRSV_cut.month_start, mcRatesMonthly(1:nObs, ageGroup, 1), '-', ...
            'Color', modelColor, 'LineWidth', 1);
        ylabel('Model (per 100k)', 'Color', modelColor, 'FontSize', 8);
        ax.YColor = modelColor;
        ylim([0, ylimAge(ageGroup)]);

        % Right y-axis: observed
        yyaxis right;
        plot(monthlyCaseRSV_cut.month_start, smooth(monthlyCaseRSV_cut{:, data_col}, 1), '-', ...
            'Color', observedColor, 'LineWidth', 1);
        ylabel('Observed (per 100k)', 'Color', observedColor, 'FontSize', 8);
        ax.YColor = observedColor;
        ylim([0, ylimAge(ageGroup)]);

        title(age_labels_monthly{ageGroup}, 'FontSize', 9);

        % X-ticks at January of each year
        years = unique(year(dateZero + monthlyCaseRSV_cut.month_start));
        tick_pos = []; tick_lab = {};
        for i = 1:length(years)
            jan_pos = days(datetime(years(i), 1, 1) - dateZero);
            if jan_pos >= min(monthlyCaseRSV_cut.month_start) && jan_pos <= max(monthlyCaseRSV_cut.month_start)
                tick_pos(end+1) = jan_pos; %#ok<AGROW>
                tick_lab{end+1} = num2str(years(i)); %#ok<AGROW>
            end
        end
        set(ax, 'XTick', tick_pos, 'XTickLabel', tick_lab, 'FontSize', 7);
        xlim([min(monthlyCaseRSV_cut.month_start), max(monthlyCaseRSV_cut.month_start)]);
        grid off; box off;

        if ageGroup == 5
            xlabel('Year', 'FontSize', 8);
        end
    end

    % =================================================================
    % RIGHT COLUMN, top 3: Seroprevalence (panels f-h)
    % =================================================================

    % --- Panel f: Hong Kong ---
    ax_hk = subplot(5, 2, 2);
    hold on;
    unique_ages_hk = (1:height(seroprevDataHKRec)) - 1;

    yyaxis left;
    errorbar(unique_ages_hk - 0.05, mcRecSerologyHKPrctile(:,1), ...
        mcRecSerologyHKPrctile(:,1) - mcRecSerologyHKPrctile(:,2), ...
        mcRecSerologyHKPrctile(:,3) - mcRecSerologyHKPrctile(:,1), ...
        '^-', 'Color', modelColor, 'LineWidth', 0.75, 'MarkerSize', 3, 'CapSize', 3, 'MarkerFaceColor', modelColor);
    ylabel('Model estimates', 'Color', modelColor, 'FontSize', 8);
    ax_hk.YColor = modelColor; ylim([0, 1]);

    yyaxis right;
    errorbar(unique_ages_hk + 0.05, dataSerologyHKMean, ...
        dataSerologyHKMean - dataSerologyHKCI(:,1), ...
        dataSerologyHKCI(:,2) - dataSerologyHKMean, ...
        'o-', 'Color', observedColor, 'LineWidth', 0.75, 'MarkerSize', 3, 'CapSize', 3, 'MarkerFaceColor', observedColor);
    ylabel('Observed seroprevalence', 'Color', observedColor, 'FontSize', 8);
    ax_hk.YColor = observedColor; ylim([0, 1]);

    xticks_labels_hk = {'0-11m','12-23m','2-4y','5-9y','10-14y','15-19y','20-39y','40-59y','60-80y'};
    set(ax_hk, 'XTick', unique_ages_hk, 'XTickLabel', xticks_labels_hk, 'FontSize', 6);
    xtickangle(45); xlim([-0.5, max(unique_ages_hk)*1.05]);
    grid off; box off;
    title('Hong Kong, 2020', 'FontSize', 9);

    % --- Panel g: Beijing (meta-analysis) ---
    uniquePMIDs = unique(seroprevDataMeta.PMID);
    currentPMID = uniquePMIDs(3);
    pmidIndices = find(seroprevDataMeta.PMID == currentPMID);

    ax_bj = subplot(5, 2, 4);
    hold on;

    yyaxis left;
    hModel = errorbar((1:length(pmidIndices))-0.05, mcRecSerologyMetaPrctile(pmidIndices,1), ...
        mcRecSerologyMetaPrctile(pmidIndices,1) - mcRecSerologyMetaPrctile(pmidIndices,2), ...
        mcRecSerologyMetaPrctile(pmidIndices,3) - mcRecSerologyMetaPrctile(pmidIndices,1), ...
        '^-', 'Color', modelColor, 'LineWidth', 0.75, 'MarkerSize', 3, 'CapSize', 3, 'MarkerFaceColor', modelColor);
    ylabel('Model estimates', 'Color', modelColor, 'FontSize', 8);
    ax_bj.YColor = modelColor; ylim([0, 1]);

    yyaxis right;
    hObs = errorbar((1:length(pmidIndices))+0.05, dataSerologyMetaMean(pmidIndices), ...
        dataSerologyMetaMean(pmidIndices) - dataSerologyMetaCI(pmidIndices,1), ...
        dataSerologyMetaCI(pmidIndices,2) - dataSerologyMetaMean(pmidIndices), ...
        'o-', 'Color', observedColor, 'LineWidth', 0.75, 'MarkerSize', 3, 'CapSize', 3, 'MarkerFaceColor', observedColor);
    ylabel('Observed seroprevalence', 'Color', observedColor, 'FontSize', 8);
    ax_bj.YColor = observedColor; ylim([0, 1]);

    % X-axis labels with age ranges
    xticks(1:length(pmidIndices));
    ageLabels_bj = cell(length(pmidIndices), 1);
    for jj = 1:length(pmidIndices)
        idx = pmidIndices(jj);
        startMonth = round(seroprevDataMeta.ageStart(idx) * 12);
        endMonth = round(seroprevDataMeta.ageEnd(idx) * 12);
        if startMonth == endMonth
            if startMonth < 24
                ageLabels_bj{jj} = sprintf('%dm', startMonth);
            else
                ageLabels_bj{jj} = sprintf('%dy', startMonth/12);
            end
        elseif endMonth < 24
            ageLabels_bj{jj} = sprintf('%d-%dm', startMonth, endMonth);
        else
            if startMonth >= 60 && endMonth >= 60
                ageLabels_bj{jj} = sprintf('%d-%dy', round(startMonth/12), round(endMonth/12));
            else
                startIsCleanYear = mod(startMonth, 12) == 0;
                endIsCleanYear = mod(endMonth, 12) == 0;
                if startIsCleanYear && endIsCleanYear
                    ageLabels_bj{jj} = sprintf('%d-%dy', startMonth/12, endMonth/12);
                else
                    ageLabels_bj{jj} = sprintf('%d-%dm', startMonth, endMonth);
                end
            end
        end
    end
    xticklabels(ageLabels_bj);
    xtickangle(45);
    set(ax_bj, 'FontSize', 6);
    xlim([0.5, length(pmidIndices)+0.5]);
    grid off; box off;

    studyCountry = seroprevDataMeta.study_country{pmidIndices(1)};
    studyYear = seroprevDataMeta.study_year{pmidIndices(1)};
    title(sprintf('%s, %s', studyCountry, studyYear), 'FontSize', 9);

    % --- Panel h: Thailand seroprevalence ---
    ax_th = subplot(5, 2, 6);
    hold on;
    seroprevData.age_by_year(1) = -1;

    yyaxis left;
    errorbar(seroprevData.age_by_year - 0.05, mcRecSerologyPrctile(:,1), ...
        mcRecSerologyPrctile(:,1) - mcRecSerologyPrctile(:,2), ...
        mcRecSerologyPrctile(:,3) - mcRecSerologyPrctile(:,1), ...
        '^-', 'Color', modelColor, 'LineWidth', 0.75, 'MarkerSize', 3, 'CapSize', 3, 'MarkerFaceColor', modelColor);
    ylabel('Model estimates', 'Color', modelColor, 'FontSize', 8);
    ax_th.YColor = modelColor; ylim([0, 1]);

    yyaxis right;
    errorbar(seroprevData.age_by_year + 0.05, dataSerologyMean, ...
        dataSerologyMean - dataSerologyCI(:,1), ...
        dataSerologyCI(:,2) - dataSerologyMean, ...
        'o-', 'Color', observedColor, 'LineWidth', 0.75, 'MarkerSize', 3, 'CapSize', 3, 'MarkerFaceColor', observedColor);
    ylabel('Observed seroprevalence', 'Color', observedColor, 'FontSize', 8);
    ax_th.YColor = observedColor; ylim([0, 1]);

    unique_ages_th = unique(round(seroprevData.age_by_year));
    xticks_vals_th = unique_ages_th;
    xticks_labs_th = cell(size(xticks_vals_th));
    xticks_labs_th{1} = 'M';
    for ii = 2:length(xticks_vals_th)
        age_months = round(seroprevData.age_by_month(ii));
        if age_months < 24
            xticks_labs_th{ii} = sprintf('%dm', age_months);
        else
            xticks_labs_th{ii} = sprintf('%dy', unique_ages_th(ii));
        end
    end
    set(ax_th, 'XTick', xticks_vals_th, 'XTickLabel', xticks_labs_th, 'FontSize', 6);
    xtickangle(45);
    xlim([-1.5, max(seroprevData.age_by_year)*1.05]);
    grid off; box off;
    title('Thailand, 2015-2021', 'FontSize', 9);

    % =================================================================
    % RIGHT COLUMN, bottom: Average yearly RSV rates (panel i)
    % Use a subplot spanning rows 4-5 in column 2
    % =================================================================
    % We use subplot positions 8 and 10 (right column, rows 4 and 5)
    % by creating a single axes covering that area
    pos8  = getSubplotPos(5, 2, 8);
    pos10 = getSubplotPos(5, 2, 10);
    % Merge: left = same, bottom of pos10 to top of pos8
    merged_pos = [pos8(1), pos10(2), pos8(3), (pos8(2) + pos8(4)) - pos10(2)];
    ax_yr = axes('Position', merged_pos);
    hold(ax_yr, 'on');

    age_labels_yearly = {'0-4y', '5-19y', '20-49y', '50-64y', '\geq65y'};

    % Grouped bar: [Observed, Model]
    groupedData = [avg_obs', avg_med'];
    b = bar(ax_yr, 1:numAgeGroups, groupedData, 'grouped');
    b(1).FaceColor = observedColor; b(1).EdgeColor = 'none'; b(1).FaceAlpha = 0.7;
    b(2).FaceColor = modelColor;    b(2).EdgeColor = 'none'; b(2).FaceAlpha = 0.7;

    % Error bars on model bars
    err_lo = avg_med - avg_lo;
    err_hi = avg_hi - avg_med;
    xCenters = b(2).XEndPoints;
    errorbar(ax_yr, xCenters, avg_med, err_lo, err_hi, ...
        'k', 'linestyle', 'none', 'LineWidth', 0.6, 'CapSize', 3);

    set(ax_yr, 'XTick', 1:numAgeGroups, 'XTickLabel', age_labels_yearly, 'FontSize', 8);
    ylabel(ax_yr, 'Cases per 100,000', 'FontSize', 8);
    xlabel(ax_yr, 'Age group', 'FontSize', 8);
    title(ax_yr, 'Average yearly RSV hospitalisations (2015-2019)', 'FontSize', 9);
    lgd = legend(ax_yr, {'Observed', 'Model estimate'}, 'FontSize', 7, 'Location', 'northeast');
    lgd.Box = 'off';
    box(ax_yr, 'off');
    ax_yr.TickDir = 'out';

    % =================================================================
    % Panel letters
    % =================================================================
    allAxes = findobj(fig_handle, 'Type', 'axes');
    % Sort by position: first by column (x), then by row (top to bottom = decreasing y)
    positions = cell2mat(get(allAxes, 'Position'));
    % Separate left column (x < 0.5) from right column
    leftIdx  = find(positions(:,1) < 0.5);
    rightIdx = find(positions(:,1) >= 0.5);
    % Sort left column top-to-bottom
    [~, sortL] = sort(positions(leftIdx, 2), 'descend');
    leftAxes = allAxes(leftIdx(sortL));
    % Sort right column top-to-bottom
    [~, sortR] = sort(positions(rightIdx, 2), 'descend');
    rightAxes = allAxes(rightIdx(sortR));
    orderedAxes = [leftAxes; rightAxes];
    letters = {'a','b','c','d','e','f','g','h','i'};

    % Filter out invisible axes
    visAxes = orderedAxes(arrayfun(@(a) strcmp(a.Visible,'on'), orderedAxes));
    nLetters = min(length(letters), length(visAxes));
    for k = 1:nLetters
        pos = visAxes(k).Position;
        annotation(fig_handle, 'textbox', ...
            [pos(1)-0.04, pos(2)+pos(4)-0.01, 0.03, 0.03], ...
            'String', letters{k}, 'FontSize', 11, 'FontWeight', 'bold', ...
            'EdgeColor', 'none', 'HorizontalAlignment', 'center');
    end

    out = fig_handle;
end

% =========================================================================
function pos = getSubplotPos(nrows, ncols, idx)
% Return the default position of subplot(nrows, ncols, idx) without creating it
    ax_tmp = subplot(nrows, ncols, idx);
    pos = ax_tmp.Position;
    delete(ax_tmp);
end
