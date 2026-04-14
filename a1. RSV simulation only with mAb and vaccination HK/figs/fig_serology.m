function out = fig_serology(mcRecSerologyPrctile,seroprevData,dataSerologyMean,dataSerologyCI)

    seroprevData.age_by_year(1) = -1;
    
    % Create figure for seroprevalence data
    % figure(8); 
    % set(gcf, 'Position', [100, 100, 800, 600]);
    
    % Create left y-axis for model predictions (blue)
    yyaxis left;
    
    % Plot model results - blue filled dots with error bars (shifted slightly left)
    hModel = errorbar(seroprevData.age_by_year - 0.05, mcRecSerologyPrctile(:,1), ...
        mcRecSerologyPrctile(:,1) - mcRecSerologyPrctile(:,2), ...
        mcRecSerologyPrctile(:,3) - mcRecSerologyPrctile(:,1), ...
        '^-', 'Color', [0, 0.4470, 0.7410], 'LineWidth', 0.75, 'MarkerSize', 4, 'CapSize', 4, 'MarkerFaceColor', [0, 0.4470, 0.7410]);
    
    % Format left y-axis (model predictions)
    ylabel('Model estimates', 'Color', [0, 0.4470, 0.7410], 'FontSize', 10);
    ax_left = gca;
    ax_left.YColor = [0, 0.4470, 0.7410];
    
    % Set y-axis limits for model estimates
    ylim([0, 1]);
    
    % Create right y-axis for observed data (red)
    yyaxis right;
    
    % Plot observed data - red filled dots with error bars (shifted slightly right)
    hObs = errorbar(seroprevData.age_by_year + 0.05, dataSerologyMean, ...
        dataSerologyMean - dataSerologyCI(:,1), ...
        dataSerologyCI(:,2) - dataSerologyMean, ...
        'o-', 'Color', [0.8500, 0.3250, 0.0980], 'LineWidth', 0.75, 'MarkerSize', 4, 'CapSize', 4, 'MarkerFaceColor', [0.8500, 0.3250, 0.0980]);
    
    % Format right y-axis (observed data)
    ylabel('Observed (data)', 'Color', [0.8500, 0.3250, 0.0980], 'FontSize', 10);
    ax_right = gca;
    ax_right.YColor = [0.8500, 0.3250, 0.0980];
    
    % Set y-axis limits for observed data
    ylim([0, 1]);
    
    % Add title
    title(sprintf('%s, %s', 'Thailand', '2015-2021'), 'FontSize', 10);
    
    % Add x-axis label
    xlabel('Age', 'FontSize', 10);
    
    % Remove grid
    grid off;
    
    % Turn off box
    box off;
    
    % Custom x-tick labels - replace -1 with "Maternal" and use all age years
    % Get unique ages, maintain order, and ensure -1 is first
    unique_ages = unique(round(seroprevData.age_by_year));
    xticks_values = unique_ages;
    xticks_labels = cell(size(xticks_values));
    
    % Label the first tick (-1) as "Maternal"
    xticks_labels{1} = 'Maternal';
    
    % Label all other ticks with their respective ages
    for ii = 2:length(xticks_values)
        age_months = round(seroprevData.age_by_month(ii));
        if age_months < 24
            xticks_labels{ii} = sprintf('%dm', age_months);
        else
            xticks_labels{ii} = sprintf('%dy', unique_ages(ii));
        end
    end
    
    % Apply the custom tick labels
    set(gca, 'XTick', xticks_values, 'XTickLabel', xticks_labels, 'FontSize', 8);
    xtickangle(45);
    
    % Adjust axis limits to better display the data
    xlim([-1.5, max(seroprevData.age_by_year)*1.05]);
    
    out = gcf;
end