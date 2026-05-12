function out = fig_period_rsv_by_4age_groups(mcRecMonthlyByAgePrctile, periodCaseRSV, dateZero, cutoffCOVID)
    % Create a single figure with 4 subplots, one for each age group
    % Each subplot shows grouped bars for yearly average model estimates (with error bars) 
    % and observed data (simple bars) for the years present in the data (assumed 2015-2019).
    % Age groups: 0-4 years, 5-17 years, 18-59 years, and ≥60 years
    
    % Cut off data at COVID (if cutoffCOVID is within the 2015-2019 range)
    periodCaseRSV = periodCaseRSV(periodCaseRSV.month_start < cutoffCOVID,:);

    % Add year column to periodCaseRSV
    periodCaseRSV.Year = year(dateZero + periodCaseRSV.month_start);
    
    % Determine the unique years present in the data
    targetYears = unique(periodCaseRSV.Year);
    if isempty(targetYears)
        error('No data available in periodCaseRSV after applying cutoffCOVID.');
    end
    minYear = min(targetYears);
    maxYear = max(targetYears);
    numYears = length(targetYears);

    % Define age group labels for the 4 age groups
    age_labels = {'0-4 years', '5-17 years', '18-59 years', '\geq 60 years'};
    
    % Define colors
    modelColor = [0, 0.4470, 0.7410]; % Blue
    observedColor = [0.8500, 0.3250, 0.0980]; % Red

    % Create a large figure
    fig_handle = figure(6); % Use a different figure number
    clf; % Clear figure before plotting
    
    maxYValAllSubplots = 0; % To synchronize y-axis limits later

    % --- Loop through the 4 age groups --- 
    for ageGroupIdx = 1:4
        % Map the new age group index to the original age group indices
        if ageGroupIdx == 1
            % 0-4 years combines original age groups 1, 2, and 3
            originalAgeGroups = [1, 2, 3];
        else
            % Other age groups map directly (with offset)
            originalAgeGroups = ageGroupIdx + 2;
        end
        
        % Create 2x2 subplot layout
        ax = subplot(2, 2, ageGroupIdx);
        hold(ax, 'on');

        % Find indices corresponding to the current combined age group in the data
        currentAgeGroupIdx = find(ismember(periodCaseRSV.age_group_index, originalAgeGroups));
        
        if isempty(currentAgeGroupIdx)
            % Handle cases where an age group might have no data
            title(ax, age_labels{ageGroupIdx}, 'FontSize', 10);
            xticks(ax, targetYears);
            xticklabels(ax, cellstr(num2str(targetYears(:))));
            xlim(ax, [minYear-0.5, maxYear+0.5]);
            ylim(ax, [0, 1]); % Set a default ylim
            box(ax, 'off');
            grid(ax, 'off');
            if ageGroupIdx > 2
                xlabel(ax, 'Year', 'FontSize', 10);
            end
            continue; % Skip to the next age group
        end

        % Extract relevant data for the current age group
        years_ageGroup = periodCaseRSV.Year(currentAgeGroupIdx);
        year_indices_relative = years_ageGroup - minYear + 1;
        
        % For the first age group (0-4 years), we need to combine data from original age groups 1, 2, and 3
        if ageGroupIdx == 1
            % Initialize arrays to store combined data
            model_median_combined = zeros(size(currentAgeGroupIdx));
            model_lowerCI_combined = zeros(size(currentAgeGroupIdx));
            model_upperCI_combined = zeros(size(currentAgeGroupIdx));
            
            % Get the age group index for each data point
            age_indices = periodCaseRSV.age_group_index(currentAgeGroupIdx);
            
            % Combine data from the three age groups
            for i = 1:length(currentAgeGroupIdx)
                % Get the original age group for this data point
                orig_age = age_indices(i);
                
                % Extract data for this specific point
                model_median_combined(i) = mcRecMonthlyByAgePrctile(currentAgeGroupIdx(i), orig_age, 1);
                model_lowerCI_combined(i) = mcRecMonthlyByAgePrctile(currentAgeGroupIdx(i), orig_age, 2);
                model_upperCI_combined(i) = mcRecMonthlyByAgePrctile(currentAgeGroupIdx(i), orig_age, 3);
            end
            
            % Use the combined data
            model_median_ageGroup = model_median_combined;
            model_lowerCI_ageGroup = model_lowerCI_combined;
            model_upperCI_ageGroup = model_upperCI_combined;
        else
            % For other age groups, use the data directly
            orig_age = originalAgeGroups; % This is a single value for age groups 2, 3, 4
            model_median_ageGroup = mcRecMonthlyByAgePrctile(currentAgeGroupIdx, orig_age, 1);
            model_lowerCI_ageGroup = mcRecMonthlyByAgePrctile(currentAgeGroupIdx, orig_age, 2);
            model_upperCI_ageGroup = mcRecMonthlyByAgePrctile(currentAgeGroupIdx, orig_age, 3);
        end
        
        % Observed Data
        observed_data_ageGroup = periodCaseRSV.num_RSV_pos(currentAgeGroupIdx);

        % Calculate yearly means using accumarray
        yearly_mean_model_median = accumarray(year_indices_relative, model_median_ageGroup, [numYears 1], @mean, NaN);
        yearly_mean_model_lowerCI = accumarray(year_indices_relative, model_lowerCI_ageGroup, [numYears 1], @mean, NaN);
        yearly_mean_model_upperCI = accumarray(year_indices_relative, model_upperCI_ageGroup, [numYears 1], @mean, NaN);
        yearly_mean_observed = accumarray(year_indices_relative, observed_data_ageGroup, [numYears 1], @mean, NaN);

        % Combine data for grouped bar chart (Observed first, then Model)
        groupedBarData = [yearly_mean_observed, yearly_mean_model_median];

        % Plot grouped bars
        b = bar(ax, targetYears, groupedBarData, 'grouped');
        % Style Observed Data bars (first series)
        b(1).FaceColor = observedColor;
        b(1).EdgeColor = 'none';
        b(1).FaceAlpha = 0.7;
        % Style Model Estimate bars (second series)
        b(2).FaceColor = modelColor;
        b(2).EdgeColor = 'none';
        b(2).FaceAlpha = 0.7;

        % Calculate error bar lengths for the model estimate bars (now the second group)
        err_lower = yearly_mean_model_median - yearly_mean_model_lowerCI;
        err_upper = yearly_mean_model_upperCI - yearly_mean_model_median;
        
        % --- Corrected Error Bar Positioning ---
        % Get the exact x-coordinates of the centers of the second bar series (blue bars - model)
        xCenters = b(2).XEndPoints;
        
        % Filter out NaN values for error bars
        valid_err_idx = ~isnan(yearly_mean_model_median) & ~isnan(err_lower) & ~isnan(err_upper);

        % Add error bars centered on the blue bars (model estimates) using the calculated xCenters
        errorbar(ax, xCenters(valid_err_idx), yearly_mean_model_median(valid_err_idx), ...
                 err_lower(valid_err_idx), err_upper(valid_err_idx), ...
                 'k', 'linestyle', 'none', 'LineWidth', 0.5, 'CapSize', 3);

        % --- Axes Formatting ---
        title(ax, age_labels{ageGroupIdx}, 'FontSize', 10);
        set(ax, 'XTick', targetYears);
        xticklabels(ax, cellstr(num2str(targetYears(:))));
        xlim(ax, [minYear-0.5, maxYear+0.5]);
        box(ax, 'off');
        grid(ax, 'off');
        ax.TickDir = 'out';

        % Determine max y value for this subplot to sync axes later
        % currentMaxY = max([yearly_mean_model_upperCI; yearly_mean_observed]) * 1.1;
        currentMaxY = 120;
        if ~isnan(currentMaxY) && currentMaxY > maxYValAllSubplots
            maxYValAllSubplots = currentMaxY;
        end
        
        % Set preliminary Y limit (will be adjusted later)
        if isnan(currentMaxY) || currentMaxY <= 0
             ylim(ax, [0, 1]);
        else
             ylim(ax, [0, currentMaxY]);
        end

        % Add legend to the first subplot
        if ageGroupIdx == 1 
            lgd = legend({'Observed Data', 'Model Estimate'}, 'FontSize', 8);
            lgd.Box = 'off';
            % Position the legend in the top-right corner of the subplot
            lgd.Location = 'northeast';
        end

        % Add X label only to bottom plots
        if ageGroupIdx > 2
            xlabel(ax, 'Year', 'FontSize', 10);
        else
            xticklabels(ax, {}); % Hide x-tick labels for upper plots
        end
        
        % Add Y label only to left-most plots
        if mod(ageGroupIdx, 2) == 1
             ylabel(ax, 'Avg. Monthly Cases', 'FontSize', 10);
        end
        
        hold(ax, 'off');
    end
    
    % --- Post-loop Adjustments ---

    % Synchronize Y-axis limits across all subplots
    if maxYValAllSubplots <= 0 % Handle case where all data might be zero or NaN
        maxYValAllSubplots = 1;
    end
    allAxes = findobj(fig_handle, 'Type', 'Axes');
    for k = 1:length(allAxes)
        ylim(allAxes(k), [0, maxYValAllSubplots]);
    end

    % Add a main title for the whole figure
    sgtitle(sprintf('Yearly RSV Cases by Age Group (%d-%d)', minYear, maxYear), 'FontSize', 12, 'FontWeight', 'bold');
    
    % Adjust layout for better spacing
    % set(fig_handle, 'Position', [100, 100, 800, 600]);

    out = fig_handle;
end