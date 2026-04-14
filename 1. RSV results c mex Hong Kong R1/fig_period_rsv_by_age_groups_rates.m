function [out,rec] = fig_period_rsv_by_age_groups_rates(mcRecMonthlyByAgePrctile, monthlyCaseRSV, populationAgeGroup, dateZero, cutoffCOVID)
    % Age distribution of reported RSV cases per 100,000 for 2015-2019
    % Grouped bar plot: observed vs model estimate (with 95% CI) by age group
    
    % Population denominator (mean across MCMC iterations)
    populationAgeGroupMean = mean(populationAgeGroup, 1);
    
    % Convert model estimates to rates per 100,000
    mtrSize = size(mcRecMonthlyByAgePrctile);
    mcRates = mcRecMonthlyByAgePrctile ./ repmat(populationAgeGroupMean, mtrSize(1), 1, mtrSize(3)) * 100000;
    
    % Cut off data at COVID
    monthlyCaseRSV = monthlyCaseRSV(monthlyCaseRSV.month_start < cutoffCOVID, :);
    
    % Add year column
    monthlyCaseRSV.Year = year(dateZero + monthlyCaseRSV.month_start);
    
    % Filter to 2015-2019
    targetYears = 2015:2019;
    yearMask = ismember(monthlyCaseRSV.Year, targetYears);
    monthlyCaseRSV = monthlyCaseRSV(yearMask, :);
    mcRates = mcRates(yearMask, :, :);
    
    if isempty(monthlyCaseRSV)
        error('No data available for 2015-2019.');
    end
    
    % Age group labels (matching monthlyCaseRSV columns 4-9)
    age_labels = {'0-5 months', '6-11 months', '1-4 years', '5-64 years', '65-74 years', '75+ years'};
    
    % Colors
    modelColor = [0, 0.4470, 0.7410];        % Blue
    observedColor = [0.8500, 0.3250, 0.0980]; % Red/Orange
    
    % Compute average yearly rates per 100,000 for each age group
    numAgeGroups = 6;
    obs_rate = zeros(numAgeGroups, 1);
    model_median_rate = zeros(numAgeGroups, 1);
    model_lower_rate = zeros(numAgeGroups, 1);
    model_upper_rate = zeros(numAgeGroups, 1);
    
    uniqueYears = unique(monthlyCaseRSV.Year);
    numYears = length(uniqueYears);
    
    for ag = 1:numAgeGroups
        data_col = ag + 3;  % Columns 4-9 hold the 6 age group counts
        
        % Sum monthly counts into yearly totals
        yearly_obs = zeros(numYears, 1);
        yearly_med = zeros(numYears, 1);
        yearly_lo  = zeros(numYears, 1);
        yearly_hi  = zeros(numYears, 1);
        
        for yy = 1:numYears
            yidx = monthlyCaseRSV.Year == uniqueYears(yy);
            yearly_obs(yy) = sum(monthlyCaseRSV{yidx, data_col});
            yearly_med(yy) = sum(mcRates(yidx, ag, 1));
            yearly_lo(yy)  = sum(mcRates(yidx, ag, 2));
            yearly_hi(yy)  = sum(mcRates(yidx, ag, 3));
        end
        
        % Average across years, then convert observed counts to rate
        obs_rate(ag) = mean(yearly_obs) / populationAgeGroupMean(ag) * 100000;
        model_median_rate(ag) = mean(yearly_med);
        model_lower_rate(ag)  = mean(yearly_lo);
        model_upper_rate(ag)  = mean(yearly_hi);
    end
    
    rec = [model_median_rate, model_lower_rate, model_upper_rate];
    
    % --- Create figure ---
    fig_handle = figure(12);
    clf;
    
    % Grouped bar data: [Observed, Model Estimate]
    groupedBarData = [obs_rate, model_median_rate];
    
    b = bar(1:numAgeGroups, groupedBarData, 'grouped');
    hold on;
    
    % Style bars
    b(1).FaceColor = observedColor;
    b(1).EdgeColor = 'none';
    b(1).FaceAlpha = 0.7;
    b(2).FaceColor = modelColor;
    b(2).EdgeColor = 'none';
    b(2).FaceAlpha = 0.7;
    
    % Error bars on model estimate bars (95% CI)
    err_lower = model_median_rate - model_lower_rate;
    err_upper = model_upper_rate - model_median_rate;
    xCenters = b(2).XEndPoints;
    valid = ~isnan(model_median_rate);
    errorbar(xCenters(valid), model_median_rate(valid), err_lower(valid), err_upper(valid), ...
        'k', 'linestyle', 'none', 'LineWidth', 0.8, 'CapSize', 4);
    
    % Formatting
    set(gca, 'XTick', 1:numAgeGroups, 'XTickLabel', age_labels);
    xlabel('Age group', 'FontSize', 11);
    ylabel('Cases per 100,000', 'FontSize', 11);
    title(sprintf('Average Yearly Reported RSV Cases per 100,000 (%d-%d)', ...
        min(targetYears), max(targetYears)), 'FontSize', 12, 'FontWeight', 'bold');
    lgd = legend({'Observed', 'Model Estimate'}, 'FontSize', 9, 'Location', 'northeast');
    lgd.Box = 'off';
    box off;
    ax = gca;
    ax.TickDir = 'out';
    hold off;
    
    out = fig_handle;
end