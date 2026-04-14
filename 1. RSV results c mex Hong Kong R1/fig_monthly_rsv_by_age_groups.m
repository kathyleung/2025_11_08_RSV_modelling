function out = fig_monthly_rsv_by_age_groups(mcRecMonthlyByAgePrctile, monthlyCaseRSV, dateZero, cutoffCOVID)
    % Create a single figure with 6 subplots, one for each age group
    % Each subplot has dual y-axes: left (blue) for model predictions and right (red) for observed data
    
    % Cut off data at COVID
    monthlyCaseRSV = monthlyCaseRSV(monthlyCaseRSV.month_start<cutoffCOVID,:);
    
    % Define age group labels
    age_labels = {'0-5 months', '6-11 months', '1-4 years', '5-64 years', '65-74 years', '75+ years'};
    
    % Create a large figure
    fig_handle = figure(3);

    % Y lim
    ylimArr = [300,200,500,300,200,500];
    
    % Use tight subplot to create a grid of subplots with minimal spacing
    for ageGroup = 1:6
        % Create subplot for this age group
        subplot(3, 2, ageGroup);
        hold on;
        
        % Get data column index for this age group in monthlyCaseRSV
        data_col = ageGroup + 3;  % Columns 4-9 have the age group data
        
        % Create left y-axis for model predictions (blue)
        yyaxis left;
        
        % Create a filled area for the confidence intervals (shaded region)
        x_fill = [monthlyCaseRSV.month_start; flipud(monthlyCaseRSV.month_start)];
        y_fill = [mcRecMonthlyByAgePrctile(1:size(monthlyCaseRSV,1),ageGroup,2); flipud(mcRecMonthlyByAgePrctile(1:size(monthlyCaseRSV,1),ageGroup,3))];
        fill(x_fill, y_fill, [0, 0.4470, 0.7410], 'FaceAlpha', 0.3, 'EdgeColor', 'none');
        
        % Plot model median prediction (blue line)
        plot(monthlyCaseRSV.month_start, mcRecMonthlyByAgePrctile(1:size(monthlyCaseRSV,1),ageGroup,1), '-', ...
            'Color', [0, 0.4470, 0.7410], 'LineWidth', 1);
        
        % Format left y-axis (model predictions)
        ylabel('Model estimated cases', 'Color', [0, 0.4470, 0.7410], 'FontSize', 10);
        ax_left = gca;
        ax_left.YColor = [0, 0.4470, 0.7410];
        
        % Set y-axis limits for model estimates
        ylim([0,ylimArr(ageGroup)]);

        % Create right y-axis for observed data (red)
        yyaxis right;
        
        % Plot observed data (red line)
        plot(monthlyCaseRSV.month_start, smooth(monthlyCaseRSV{:,data_col},1), '-', ...
            'Color', [0.8500, 0.3250, 0.0980], 'LineWidth', 1);
        
        % Format right y-axis (observed data)
        ylabel('Observed RSV cases', 'Color', [0.8500, 0.3250, 0.0980], 'FontSize', 10);
        ax_right = gca;
        ax_right.YColor = [0.8500, 0.3250, 0.0980];
        
        % Set y-axis limits for observed data
        ylim([0,ylimArr(ageGroup)]);
        
        % Add title for this subplot
        title(age_labels{ageGroup}, 'FontSize', 10);
        
        % Format x-axis
        % Create tick positions at January of each year
        years = unique(year(dateZero + monthlyCaseRSV.month_start));
        
        % Preallocate arrays for tick positions and labels to fix the warning
        max_years = length(years);
        tick_positions = zeros(max_years, 1);
        tick_labels = cell(max_years, 1);
        num_ticks = 0;
        
        for i = 1:length(years)
            y = years(i);
            % Find position for January 1st of each year
            jan_date = datetime(y, 1, 1);
            jan_pos = days(jan_date - dateZero);
            
            if jan_pos >= min(monthlyCaseRSV.month_start) && jan_pos <= max(monthlyCaseRSV.month_start)
                num_ticks = num_ticks + 1;
                tick_positions(num_ticks) = jan_pos;
                tick_labels{num_ticks} = num2str(y);
            end
        end
        
        % Trim arrays to actual size used
        tick_positions = tick_positions(1:num_ticks);
        tick_labels = tick_labels(1:num_ticks);
        
        % Apply tick labels
        set(gca, 'XTick', tick_positions, 'XTickLabel', tick_labels);
        
        % Only show x-label for bottom subplots
        if ageGroup > 4
            xlabel('Year', 'FontSize', 10);
        end
        
        % Remove grid
        grid off;
        
        % Turn off box
        box off;
        
        % Set x-axis limits
        xlim([min(monthlyCaseRSV.month_start), max(monthlyCaseRSV.month_start)]);
    end
    
    % Add a main title for the whole figure
    sgtitle('Monthly RSV Cases by Age Group: Model vs. Observed', 'FontSize', 10, 'FontWeight', 'bold');
    
    % Adjust spacing between subplots
    set(fig_handle, 'Units', 'normalized');
    han = axes(fig_handle, 'Visible', 'off');
    han.Title.Visible = 'on';
    han.XLabel.Visible = 'off';
    han.YLabel.Visible = 'off';
    set(han, 'Position', [0 0 1 1]);

    out = fig_handle;
end