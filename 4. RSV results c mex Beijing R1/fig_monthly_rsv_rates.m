function out = fig_monthly_rsv_rates(mcRecMonthlyPrctile, monthlyILICaseRSV,populationAgeGroup,dateZero,cutoffCOVID)

    % Rates 
    mtrSize = size(mcRecMonthlyPrctile);
    mcRecMonthlyPrctile = mcRecMonthlyPrctile./repmat(mean(sum(populationAgeGroup,2)),mtrSize(1),1)*100000;

    monthlyILICaseRSV = monthlyILICaseRSV(monthlyILICaseRSV.month_start<cutoffCOVID,:);
    

    % Calculate mid points of weeks for x-axis
    monthMidPoints = (monthlyILICaseRSV.month_start + monthlyILICaseRSV.month_end) / 2;
    
    % Create figure for weekly RSV data
    figure(3); 
    % set(gcf, 'Position', [100, 100, 800, 600]);
    
    % Create a filled area for the confidence intervals (shaded region)
    % First ensure x and y are properly formatted for fill
    x_coords = [monthMidPoints; flipud(monthMidPoints)];
    y_coords = [mcRecMonthlyPrctile(:,2); flipud(mcRecMonthlyPrctile(:,3))];
    
    % Fill command expects row vectors, not column vectors
    fill(x_coords(:)', y_coords(:)', [0, 0.4470, 0.7410], 'FaceAlpha', 0.3, 'EdgeColor', 'none');
    hold on;
    
    % Plot model median prediction (blue line)
    plot(monthMidPoints, mcRecMonthlyPrctile(:,1), '-', 'Color', [0, 0.4470, 0.7410], 'LineWidth', 1);
    
    % Plot observed data (red line)
    plot(monthMidPoints, smooth(monthlyILICaseRSV.num_monthly_RSV_pos/mean(sum(populationAgeGroup,2))*100000,1), '-', 'Color', [0.8500, 0.3250, 0.0980], 'LineWidth', 1);
    
    % Add labels and title
    xlabel('', 'FontSize', 14); % Empty label as we'll handle this with custom text
    ylabel('Number of RSV cases per 100,000 population', 'FontSize', 14);
    title('Monthly RSV laboratory detections', 'FontSize', 16);
    
    % Remove grid
    grid off;
    
    % Create custom legend without box
    leg = legend('95% CI', 'Model estimate', 'Observed RSV', 'Location', 'northeast', 'FontSize', 12);
    set(leg, 'Box', 'off');
    
    % Format x-axis as dates
    ax = gca;
    set(ax, 'FontSize', 12, 'LineWidth', 1, 'Box', 'on');
    
    % Turn off the top and right axes lines
    ax.XAxis.TickDirection = 'out';
    ax.YAxis.TickDirection = 'out';
    ax.Box = 'off';
    
    % Create date-based tick marks for months 3,6,9,12 of each year
    tick_months = [3, 6, 9, 12];
    month_names = {'Mar', 'Jun', 'Sep', 'Dec'};
    
    % First determine the date range from the data
    start_date = dateZero + min(monthMidPoints);
    end_date = dateZero + max(monthMidPoints);
    
    % Create a vector of all years in the range
    start_year = year(start_date);
    end_year = year(end_date);
    years = start_year:end_year;
    
    % Pre-allocate arrays for tick positions and labels
    % Maximum possible number of ticks = number of years * number of months
    max_ticks = length(years) * length(tick_months);
    tick_positions = zeros(1, max_ticks);
    tick_labels = cell(1, max_ticks);
    
    % Pre-allocate array for year positions
    % Maximum number of year positions = number of years
    year_positions = zeros(length(years), 2);
    
    % Counter variables to keep track of actual number of elements used
    tick_count = 0;
    year_count = 0;
    
    % Generate all month tick positions and labels
    for y = years
        for m_idx = 1:length(tick_months)
            m = tick_months(m_idx);
            % Create date for 1st of the month
            tick_date = datetime(y, m, 1);
            
            % Only include if within the plot range
            if tick_date >= start_date && tick_date <= end_date
                % Calculate days since dateZero
                tick_position = days(tick_date - dateZero);
                
                % Increment counter and store values
                tick_count = tick_count + 1;
                tick_positions(tick_count) = tick_position;
                
                % Show month name only for each month
                tick_labels{tick_count} = month_names{m_idx};
                
                % Save position for year labels (between Jun and Sep)
                if m == 9
                    % Calculate position between June and September
                    year_count = year_count + 1;
                    year_positions(year_count, :) = [tick_position, y];
                end
            end
        end
    end
    
    % Trim arrays to actual size used
    tick_positions = tick_positions(1:tick_count);
    tick_labels = tick_labels(1:tick_count);
    year_positions = year_positions(1:year_count, :);
    
    % Apply the custom tick marks for months
    set(ax, 'XTick', tick_positions, 'XTickLabel', tick_labels);
    
    % Adjust tick label rotation for better readability
    xtickangle(45);

    % Set x-axis limits
    xlim([monthMidPoints(1), monthMidPoints(end)]);
    
    % Adjust the position of the axes to make room for second row of labels
    pos = get(ax, 'Position');
    pos(2) = pos(2) + 0.07; % Move up more to make room
    pos(4) = pos(4) - 0.07; % Reduce height accordingly
    set(ax, 'Position', pos);
    
    % Add year labels in the second row - use data coordinates instead of normalized
    for i = 1:size(year_positions, 1)
        % Get position of current year
        year_pos = year_positions(i, 1);
        year_val = year_positions(i, 2);
        
        % Find position for September of the same year
        sep_date = datetime(year_val, 9, 1);
        
        if sep_date >= start_date && sep_date <= end_date
            % Calculate position between June and September
            sep_pos = days(sep_date - dateZero);
            mid_pos = (year_pos + sep_pos) / 2;
        else
            % If September is out of range, use July 15th as approximation
            mid_pos = days(datetime(year_val, 7, 15) - dateZero);
        end
        
        % Add year label below the month names using data coordinates
        % Increase the multiplier (e.g., 0.18) to push the label further down
        text(mid_pos, -max(monthlyILICaseRSV.num_monthly_RSV_pos/mean(sum(populationAgeGroup,2))*100000)*0.18, num2str(year_val), ... 
             'HorizontalAlignment', 'center', ...
             'VerticalAlignment', 'top', ...
             'FontSize', 12);
    end
    
    % Add a "Date" label below the years
    % xlabel('Date', 'FontSize', 14, 'FontWeight', 'bold');
    
    % Adjust y-axis limits to allow some space at the top
    % y_max = max([max(mcRecMonthlyPrctile(:,3)), max(monthlyILICaseRSV.num_RSV)]);
    ylim([0, 0.4]);
    
    out = gcf;
end