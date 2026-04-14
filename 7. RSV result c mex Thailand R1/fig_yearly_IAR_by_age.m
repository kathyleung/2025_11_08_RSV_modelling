function fig = fig_yearly_IAR_by_age(yearlyAgeSpecificIARPrctile)
    % Create figure
    % fig = figure('Position', [100, 100, 1200, 600]);
    
    figure(7);

    % Define age group labels
    ageGroupLabels = {
        '0-5m', '6-11m', '1-4y', '5-64y', '65-74y', '75+y'
        };
    
    % Define years
    years = 2014:2019;
    
    % Prepare data - transpose to group by age
    medianValues = yearlyAgeSpecificIARPrctile(:,:,1)';
    lowerError = medianValues - yearlyAgeSpecificIARPrctile(:,:,2)';
    upperError = yearlyAgeSpecificIARPrctile(:,:,3)' - medianValues;
    
    % Create bar plot with age groups as categories
    hb = bar(medianValues, 'grouped');
    hold on;
    
    % Calculate x positions for error bars
    xpos = zeros(size(medianValues));
    for i = 1:length(hb)
        xpos(:,i) = hb(i).XEndPoints;
    end
    
    % Add error bars
    for i = 1:size(medianValues,2)
        errorbar(xpos(:,i), medianValues(:,i), lowerError(:,i), upperError(:,i), ...
                'k.', 'LineWidth', 1, 'CapSize', 0);
    end
    
    % Format plot to match fig_weekly_rsv style
    xlabel('Age Group', 'FontSize', 14);
    ylabel('Infection Attack Rate', 'FontSize', 14);
    title('Yearly RSV Infection Attack Rates (2014-2019)', 'FontSize', 16);
    
    % Set y-axis limits and ticks
    ylim([0 1]);
    yticks(0:0.2:1);
    yticklabels({'0', '0.2', '0.4', '0.6', '0.8', '1.0'});
    
    % Custom legend without box - moved inside figure
    leg = legend(arrayfun(@num2str, years, 'UniformOutput', false), ...
                'Location', 'northeast', 'FontSize', 12);
    set(leg, 'Box', 'off');
    
    % Format axes
    ax = gca;
    set(ax, 'FontSize', 12, 'LineWidth', 1);
    ax.XAxis.TickDirection = 'out';
    ax.YAxis.TickDirection = 'out';
    ax.Box = 'off';
    
    % Set y-axis limits to 0-1
    ylim([0 1]);
    
    % Set x-axis ticks and labels
    xticks(1:length(ageGroupLabels));
    xticklabels(ageGroupLabels);
    
    % Match colors to fig_weekly_rsv style
    colors = [
        0    0.4470    0.7410  % blue
        0.8500    0.3250    0.0980  % orange
        0.9290    0.6940    0.1250  % yellow
        0.4940    0.1840    0.5560  % purple
        0.4660    0.6740    0.1880  % green
        0.3010    0.7450    0.9330  % light blue
        ];
    
    % Apply colors to bars
    for i = 1:length(hb)
        hb(i).FaceColor = colors(i,:);
    end
    fig = gcf;
end