function out = fig_period_rsv_by_age_groups(mcRecMonthlyByAgePrctile, periodCaseRSV, dateZero, cutoffCOVID)
    % Create a single figure with 6 subplots, one for each age group
    % Each subplot shows grouped bars for yearly average model estimates (with error bars) 
    % and observed data (simple bars) for the years present in the data (assumed 2015-2019).
    
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

    % Define age group labels
    age_labels = {'0-11 months', '12-23 months', '2-4 years', '5-17 years', '18-59 years', '\geq 60 years'};
    
    % Define colors
    modelColor = [0, 0.4470, 0.7410]; % Blue
    observedColor = [0.8500, 0.3250, 0.0980]; % Red

    % Create a large figure
    fig_handle = figure(5);
    clf; % Clear figure before plotting
    
    maxYValAllSubplots = 0; % To synchronize y-axis limits later
    
    % Variable to store the handle to the first subplot with data
    firstSubplotWithData = [];

    % --- Loop through age groups --- 
    for ageGroup = 1:6
        ax = subplot(3, 2, ageGroup);
        hold(ax, 'on');

        % Find indices corresponding to the current age group in the data
        currentAgeGroupIdx = find(periodCaseRSV.age_group_index == ageGroup);
        
        if isempty(currentAgeGroupIdx)
            % Handle cases where an age group might have no data
            title(ax, age_labels{ageGroup}, 'FontSize', 10);
            xticks(ax, targetYears);
            xticklabels(ax, cellstr(num2str(targetYears(:))));
            xlim(ax, [minYear-0.5, maxYear+0.5]);
            ylim(ax, [0, 1]); % Set a default ylim
            box(ax, 'off');
            grid(ax, 'off');
            if ageGroup > 4
                xlabel(ax, 'Year', 'FontSize', 10);
            end
            continue; % Skip to the next age group
        end

        % Store the first subplot that has data
        if isempty(firstSubplotWithData)
            firstSubplotWithData = ax;
        end

        % Extract relevant data for the current age group
        years_ageGroup = periodCaseRSV.Year(currentAgeGroupIdx);
        year_indices_relative = years_ageGroup - minYear + 1;
        
        % Model Estimates Data
        model_median_ageGroup = mcRecMonthlyByAgePrctile(currentAgeGroupIdx, ageGroup, 1);
        model_lowerCI_ageGroup = mcRecMonthlyByAgePrctile(currentAgeGroupIdx, ageGroup, 2);
        model_upperCI_ageGroup = mcRecMonthlyByAgePrctile(currentAgeGroupIdx, ageGroup, 3);
        
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
        % This is the key fix - we need to use the XEndPoints property which gives the exact center of each bar
        xCenters = b(2).XEndPoints;
        
        % Filter out NaN values for error bars
        valid_err_idx = ~isnan(yearly_mean_model_median) & ~isnan(err_lower) & ~isnan(err_upper);

        % Add error bars centered on the blue bars (model estimates) using the calculated xCenters
        errorbar(ax, xCenters(valid_err_idx), yearly_mean_model_median(valid_err_idx), ...
                 err_lower(valid_err_idx), err_upper(valid_err_idx), ...
                 'k', 'linestyle', 'none', 'LineWidth', 0.5, 'CapSize', 3);

        % --- Axes Formatting ---
        title(ax, age_labels{ageGroup}, 'FontSize', 10);
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

        % Add legend to the first subplot instead of at the bottom
        if ageGroup == 1 
            lgd = legend({'Observed Data', 'Model Estimate'}, 'FontSize', 8);
            lgd.Box = 'off';
            % Position the legend in the top-right corner of the subplot
            lgd.Location = 'northeast';
        end

        % Add X label only to bottom plots
        if ageGroup > 4
            xlabel(ax, 'Year', 'FontSize', 10);
        else
            xticklabels(ax, {}); % Hide x-tick labels for upper/middle plots
        end
        
        % Add Y label only to left-most plots
        if mod(ageGroup, 2) == 1
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
    
    % Adjust layout (optional)
    % Consider using tight_subplot if spacing is an issue

    out = fig_handle;
end