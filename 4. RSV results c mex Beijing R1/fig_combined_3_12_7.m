function [out, tabRec] = fig_combined_3_12_7(...
    mcRecMonthlyPrctile, monthlyILICaseRSV, populationAgeGroup, dateZero, cutoffCOVID, ...
    mcRecMonthlyByAgePrctile, periodCaseRSV, ...
    mcRecSerologyPrctile, seroprevData, dataSerologyMean, dataSerologyCI, ...
    mcRecSerologyMetaPrctile, seroprevDataMeta, dataSerologyMetaMean, dataSerologyMetaCI, ...
    mcRecSerologyHKPrctile, seroprevDataHKRec, dataSerologyHKMean, dataSerologyHKCI)
% FIG_COMBINED_3_12_7  Combined figure: monthly RSV rates, yearly RSV by
%   age group rates, and seroprevalence validation.
%
%   Layout (5 rows x 6 columns):
%     Row 1:     Panel (a)       Monthly RSV rate time series
%     Rows 2-4:  Panels (b)-(g)  Yearly RSV by age group (bar charts)
%     Row 5:     Panels (h)-(j)  Seroprevalence by location

    fig_handle = figure('Units', 'centimeters', 'Position', [2, 1, 18, 28]);
    clf;
    set(fig_handle, 'Color', 'white');

    modelColor    = [0, 0.4470, 0.7410];
    observedColor = [0.8500, 0.3250, 0.0980];

    % ===================================================================
    %  Panel (a): Monthly RSV laboratory detection rates
    % ===================================================================
    mtrSize = size(mcRecMonthlyPrctile);
    mcRates = mcRecMonthlyPrctile ./ ...
        repmat(mean(sum(populationAgeGroup, 2)), mtrSize(1), 1) * 100000;

    monthlyData = monthlyILICaseRSV(monthlyILICaseRSV.month_start < cutoffCOVID, :);
    monthMid = (monthlyData.month_start + monthlyData.month_end) / 2;
    obsRates = monthlyData.num_monthly_RSV_pos / ...
        mean(sum(populationAgeGroup, 2)) * 100000;

    ax_a = subplot(5, 6, 1:6);
    hold(ax_a, 'on');

    fill(ax_a, [monthMid; flipud(monthMid)]', ...
         [mcRates(:,2); flipud(mcRates(:,3))]', ...
         modelColor, 'FaceAlpha', 0.3, 'EdgeColor', 'none');
    plot(ax_a, monthMid, mcRates(:,1), '-', ...
         'Color', modelColor, 'LineWidth', 1);
    plot(ax_a, monthMid, obsRates, '-', ...
         'Color', observedColor, 'LineWidth', 1);

    ylabel(ax_a, 'Cases per 100,000', 'FontSize', 9);
    leg_a = legend(ax_a, '95% CI', 'Model estimate', 'Observed', ...
                   'Location', 'northeast', 'FontSize', 7);
    set(leg_a, 'Box', 'off');

    % Year-based x-ticks
    startDate = dateZero + min(monthMid);
    endDate   = dateZero + max(monthMid);
    yrs = year(startDate):year(endDate);
    tickPos = []; tickLbl = {};
    for y = yrs
        td = datetime(y, 1, 1);
        if td >= startDate && td <= endDate
            tickPos(end+1) = days(td - dateZero); %#ok<AGROW>
            tickLbl{end+1} = num2str(y); %#ok<AGROW>
        end
    end
    set(ax_a, 'XTick', tickPos, 'XTickLabel', tickLbl, 'FontSize', 8);
    % xtickangle(ax_a, 45);
    xlim(ax_a, [monthMid(1), monthMid(end)]);
    ylim(ax_a, [0, 0.4]);
    set(ax_a, 'Box', 'off', 'TickDir', 'out', 'LineWidth', 0.5);
    grid(ax_a, 'off');
    hold(ax_a, 'off');

    % ===================================================================
    %  Panels (b)-(g): Yearly RSV cases per 100,000 by age group
    % ===================================================================
    popMean  = mean(populationAgeGroup, 1);
    pData    = periodCaseRSV(periodCaseRSV.month_start < cutoffCOVID, :);
    pData.Year = year(dateZero + pData.month_start);
    tgtYears = unique(pData.Year);
    minYr = min(tgtYears);  maxYr = max(tgtYears);  nYrs = length(tgtYears);

    ageLabels = {'0-11 months', '12-23 months', '2-4 years', ...
                 '5-17 years',  '18-59 years',  '\geq 60 years'};
    yLimBar = [50, 30, 25, 1, 1, 6];
    spIdx   = {7:9, 10:12, 13:15, 16:18, 19:21, 22:24};

    tabRec  = [];
    ax_bar  = gobjects(1, 6);

    for ag = 1:6
        ax_bar(ag) = subplot(5, 6, spIdx{ag});
        hold(ax_bar(ag), 'on');

        idx = find(pData.age_group_index == ag);
        if isempty(idx)
            title(ax_bar(ag), ageLabels{ag}, 'FontSize', 9);
            box(ax_bar(ag), 'off');
            continue;
        end

        yrRel = pData.Year(idx) - minYr + 1;

        med = accumarray(yrRel, mcRecMonthlyByAgePrctile(idx,ag,1), ...
              [nYrs 1], @mean, NaN) / popMean(ag) * 1e5;
        lo  = accumarray(yrRel, mcRecMonthlyByAgePrctile(idx,ag,2), ...
              [nYrs 1], @mean, NaN) / popMean(ag) * 1e5;
        hi  = accumarray(yrRel, mcRecMonthlyByAgePrctile(idx,ag,3), ...
              [nYrs 1], @mean, NaN) / popMean(ag) * 1e5;
        obs = accumarray(yrRel, pData.num_RSV_pos(idx), ...
              [nYrs 1], @mean, NaN) / popMean(ag) * 1e5;

        tabRec(:,:,ag) = [med, lo, hi];

        b = bar(ax_bar(ag), tgtYears, [obs, med], 'grouped');
        b(1).FaceColor = observedColor; b(1).EdgeColor = 'none'; b(1).FaceAlpha = 0.7;
        b(2).FaceColor = modelColor;    b(2).EdgeColor = 'none'; b(2).FaceAlpha = 0.7;

        v = ~isnan(med) & ~isnan(lo) & ~isnan(hi);
        errorbar(ax_bar(ag), b(2).XEndPoints(v), med(v), ...
                 med(v)-lo(v), hi(v)-med(v), ...
                 'k', 'LineStyle', 'none', 'LineWidth', 0.5, 'CapSize', 2);

        title(ax_bar(ag), ageLabels{ag}, 'FontSize', 9);
        set(ax_bar(ag), 'XTick', tgtYears, 'FontSize', 7);
        xlim(ax_bar(ag), [minYr-0.5, maxYr+0.5]);
        ylim(ax_bar(ag), [0, yLimBar(ag)]);
        set(ax_bar(ag), 'Box', 'off', 'TickDir', 'out');
        grid(ax_bar(ag), 'off');

        if ag == 1
            lgd = legend(ax_bar(ag), {'Observed', 'Model estimate'}, 'FontSize', 6);
            lgd.Box = 'off';  lgd.Location = 'northeast';
        end
        if ag > 4
            xlabel(ax_bar(ag), 'Year', 'FontSize', 8);
        else
            xticklabels(ax_bar(ag), {});
        end
        if mod(ag, 2) == 1
            ylabel(ax_bar(ag), 'Cases per 100,000', 'FontSize', 8);
        end
        hold(ax_bar(ag), 'off');
    end

    % ===================================================================
    %  Panels (h)-(j): Seroprevalence
    % ===================================================================
    uniquePMIDs = unique(seroprevDataMeta.PMID);
    bjPMID = uniquePMIDs(3);

    % --- Panel (h): Hong Kong ---
    ax_h = subplot(5, 6, 25:26);
    hold(ax_h, 'on');

    xHK = (1:length(seroprevDataHKRec.age_start)) - 1;

    yyaxis(ax_h, 'left');
    errorbar(ax_h, xHK - 0.05, mcRecSerologyHKPrctile(:,1), ...
        mcRecSerologyHKPrctile(:,1) - mcRecSerologyHKPrctile(:,2), ...
        mcRecSerologyHKPrctile(:,3) - mcRecSerologyHKPrctile(:,1), ...
        '^-', 'Color', modelColor, 'LineWidth', 0.75, ...
        'MarkerSize', 3, 'CapSize', 3, 'MarkerFaceColor', modelColor);
    ylabel(ax_h, 'Model', 'Color', modelColor, 'FontSize', 8);
    ax_h.YColor = modelColor;
    ylim(ax_h, [0, 1]);

    yyaxis(ax_h, 'right');
    errorbar(ax_h, xHK + 0.05, dataSerologyHKMean, ...
        dataSerologyHKMean - dataSerologyHKCI(:,1), ...
        dataSerologyHKCI(:,2) - dataSerologyHKMean, ...
        'o-', 'Color', observedColor, 'LineWidth', 0.75, ...
        'MarkerSize', 3, 'CapSize', 3, 'MarkerFaceColor', observedColor);
    % ylabel(ax_h, 'Observed', 'Color', observedColor, 'FontSize', 8);
    ax_h.YColor = observedColor;
    ylim(ax_h, [0, 1]);

    title(ax_h, 'Hong Kong, 2020', 'FontSize', 9);
    hkLbl = {'0-11m','12-23m','2-4y','5-9y','10-14y','15-19y','20-39y','40-59y','60-80y'};
    set(ax_h, 'XTick', xHK, 'XTickLabel', hkLbl, 'FontSize', 6);
    xtickangle(ax_h, 45);
    xlim(ax_h, [-0.5, max(xHK) + 0.5]);
    box(ax_h, 'off');  grid(ax_h, 'off');
    xlabel(ax_h, 'Age', 'FontSize', 8);
    hold(ax_h, 'off');

    % --- Panel (i): Beijing (meta-analysis) ---
    ax_i = subplot(5, 6, 27:28);
    hold(ax_i, 'on');

    pmIdx = find(seroprevDataMeta.PMID == bjPMID);
    xBJ  = 1:length(pmIdx);

    yyaxis(ax_i, 'left');
    errorbar(ax_i, xBJ - 0.05, mcRecSerologyMetaPrctile(pmIdx,1), ...
        mcRecSerologyMetaPrctile(pmIdx,1) - mcRecSerologyMetaPrctile(pmIdx,2), ...
        mcRecSerologyMetaPrctile(pmIdx,3) - mcRecSerologyMetaPrctile(pmIdx,1), ...
        '^-', 'Color', modelColor, 'LineWidth', 0.75, ...
        'MarkerSize', 3, 'CapSize', 3, 'MarkerFaceColor', modelColor);
    % ylabel(ax_i, 'Model', 'Color', modelColor, 'FontSize', 8);
    ax_i.YColor = modelColor;
    ylim(ax_i, [0, 1]);

    yyaxis(ax_i, 'right');
    errorbar(ax_i, xBJ + 0.05, dataSerologyMetaMean(pmIdx), ...
        dataSerologyMetaMean(pmIdx) - dataSerologyMetaCI(pmIdx,1), ...
        dataSerologyMetaCI(pmIdx,2) - dataSerologyMetaMean(pmIdx), ...
        'o-', 'Color', observedColor, 'LineWidth', 0.75, ...
        'MarkerSize', 3, 'CapSize', 3, 'MarkerFaceColor', observedColor);
    % ylabel(ax_i, 'Observed', 'Color', observedColor, 'FontSize', 8);
    ax_i.YColor = observedColor;
    ylim(ax_i, [0, 1]);

    bjLbl = cell(length(pmIdx), 1);
    for jj = 1:length(pmIdx)
        sm = round(seroprevDataMeta.ageStart(pmIdx(jj)) * 12);
        em = round(seroprevDataMeta.ageEnd(pmIdx(jj)) * 12);
        if sm == em
            if sm < 24, bjLbl{jj} = sprintf('%dm', sm);
            else,       bjLbl{jj} = sprintf('%dy', sm/12); end
        elseif em < 24
            bjLbl{jj} = sprintf('%d-%dm', sm, em);
        elseif sm >= 60 && em >= 60
            bjLbl{jj} = sprintf('%d-%dy', round(sm/12), round(em/12));
        elseif mod(sm,12)==0 && mod(em,12)==0
            bjLbl{jj} = sprintf('%d-%dy', sm/12, em/12);
        else
            bjLbl{jj} = sprintf('%d-%dm', sm, em);
        end
    end
    studyC = seroprevDataMeta.study_country{pmIdx(1)};
    studyY = seroprevDataMeta.study_year{pmIdx(1)};
    title(ax_i, sprintf('%s, %s', studyC, studyY), 'FontSize', 9);
    set(ax_i, 'XTick', xBJ, 'XTickLabel', bjLbl, 'FontSize', 6);
    xtickangle(ax_i, 45);
    xlim(ax_i, [0.5, length(pmIdx) + 0.5]);
    box(ax_i, 'off');  grid(ax_i, 'off');
    xlabel(ax_i, 'Age', 'FontSize', 8);
    hold(ax_i, 'off');

    % --- Panel (j): Thailand ---
    ax_j = subplot(5, 6, 29:30);
    hold(ax_j, 'on');

    seroprevData.age_by_year(1) = -1;

    yyaxis(ax_j, 'left');
    errorbar(ax_j, seroprevData.age_by_year - 0.05, mcRecSerologyPrctile(:,1), ...
        mcRecSerologyPrctile(:,1) - mcRecSerologyPrctile(:,2), ...
        mcRecSerologyPrctile(:,3) - mcRecSerologyPrctile(:,1), ...
        '^-', 'Color', modelColor, 'LineWidth', 0.75, ...
        'MarkerSize', 3, 'CapSize', 3, 'MarkerFaceColor', modelColor);
    % ylabel(ax_j, 'Model', 'Color', modelColor, 'FontSize', 8);
    ax_j.YColor = modelColor;
    ylim(ax_j, [0, 1]);

    yyaxis(ax_j, 'right');
    errorbar(ax_j, seroprevData.age_by_year + 0.05, dataSerologyMean, ...
        dataSerologyMean - dataSerologyCI(:,1), ...
        dataSerologyCI(:,2) - dataSerologyMean, ...
        'o-', 'Color', observedColor, 'LineWidth', 0.75, ...
        'MarkerSize', 3, 'CapSize', 3, 'MarkerFaceColor', observedColor);
    ylabel(ax_j, 'Observed', 'Color', observedColor, 'FontSize', 8);
    ax_j.YColor = observedColor;
    ylim(ax_j, [0, 1]);

    title(ax_j, 'Thailand, 2015-2021', 'FontSize', 9);

    uAges = unique(round(seroprevData.age_by_year));
    thLbl = cell(size(uAges));
    thLbl{1} = 'M';
    for ii = 2:length(uAges)
        am = round(seroprevData.age_by_month(ii));
        if am < 24, thLbl{ii} = sprintf('%dm', am);
        else,       thLbl{ii} = sprintf('%dy', uAges(ii)); end
    end
    set(ax_j, 'XTick', uAges, 'XTickLabel', thLbl, 'FontSize', 6);
    xtickangle(ax_j, 45);
    xlim(ax_j, [-1.5, max(seroprevData.age_by_year) * 1.05]);
    box(ax_j, 'off');  grid(ax_j, 'off');
    xlabel(ax_j, 'Age', 'FontSize', 8);
    hold(ax_j, 'off');

    % ===================================================================
    %  Panel labels and final adjustments
    % ===================================================================
    allAxes = {ax_a, ax_bar(1), ax_bar(2), ax_bar(3), ax_bar(4), ...
               ax_bar(5), ax_bar(6), ax_h, ax_i, ax_j};
    AddLetters2Plots(allAxes, {'a','b','c','d','e','f','g','h','i','j'});

    out = fig_handle;
end
