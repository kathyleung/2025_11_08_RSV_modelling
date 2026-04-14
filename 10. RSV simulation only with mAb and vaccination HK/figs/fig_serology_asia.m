function out = fig_serology_asia(mcRecSerologyPrctile, seroprevData, dataSerologyMean, dataSerologyCI, mcRecSerologyMetaPrctile, seroprevDataMeta, dataSerologyMetaMean, dataSerologyMetaCI)
% FIG_SEROLOGY_ASIA Plots RSV seroprevalence data for Thailand and other Asian countries
%
% Inputs:
%   mcRecSerologyPrctile - Matrix with median and 95% CI for Thailand data
%   seroprevData - Table with Thailand seroprevalence data
%   dataSerologyMean - Vector of mean seroprevalence values for Thailand
%   dataSerologyCI - Matrix with lower and upper CI bounds for Thailand
%   mcRecSerologyMetaPrctile - Matrix with median and 95% CI for meta-analysis data
%   seroprevDataMeta - Table with meta-analysis data including PMID
%   dataSerologyMetaMean - Vector of mean seroprevalence values for meta-analysis
%   dataSerologyMetaCI - Matrix with lower and upper CI bounds for meta-analysis
%
% Output:
%   out - Figure handle

    % Get unique PMIDs for Asian countries
    uniquePMIDs = unique(seroprevDataMeta.PMID);
    uniquePMIDs = uniquePMIDs([2,3,6]);  % Select specific Asian studies
    
    % Create figure
    fig_handle = figure(8);
    
    % First subplot: Thailand data
    subplot(2, 2, 1);
    
    % Set age for pregnant women to -1
    seroprevData.age_by_year(1) = -1;
    
    % Create left y-axis for model predictions (blue)
    yyaxis left;
    
    % Plot model results - blue filled dots with error bars (shifted slightly left)
    errorbar(seroprevData.age_by_year - 0.05, mcRecSerologyPrctile(:,1), ...
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
    errorbar(seroprevData.age_by_year + 0.05, dataSerologyMean, ...
        dataSerologyMean - dataSerologyCI(:,1), ...
        dataSerologyCI(:,2) - dataSerologyMean, ...
        'o-', 'Color', [0.8500, 0.3250, 0.0980], 'LineWidth', 0.75, 'MarkerSize', 4, 'CapSize', 4, 'MarkerFaceColor', [0.8500, 0.3250, 0.0980]);
    
    % Format right y-axis (observed data)
    ylabel('Observed seroprevalence', 'Color', [0.8500, 0.3250, 0.0980], 'FontSize', 10);
    ax_right = gca;
    ax_right.YColor = [0.8500, 0.3250, 0.0980];
    
    % Set y-axis limits for observed data
    ylim([0, 1]);
    
    % Add title
    title(sprintf('%s, %s', 'Thailand', '2015-2021'), 'FontSize', 10);
    
    % Add x-axis label
    % xlabel('Age', 'FontSize', 10);
    
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
    xticks_labels{1} = 'M';
    
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
    
    % Loop through each PMID for meta-analysis data
    for ii = 1:length(uniquePMIDs)
        % Get current PMID
        currentPMID = uniquePMIDs(ii);
        
        % Find indices for this PMID
        pmidIndices = find(seroprevDataMeta.PMID == currentPMID);
        
        % Create subplot for this PMID
        subplot(2, 2, ii+1);
        hold on;
        
        % Create left y-axis for model predictions (blue)
        yyaxis left;
        
        % Plot model predictions as error bars (blue) with slight x-offset to the left
        hModel = errorbar((1:length(pmidIndices))-0.05, mcRecSerologyMetaPrctile(pmidIndices,1), ...
            mcRecSerologyMetaPrctile(pmidIndices,1) - mcRecSerologyMetaPrctile(pmidIndices,2), ...
            mcRecSerologyMetaPrctile(pmidIndices,3) - mcRecSerologyMetaPrctile(pmidIndices,1), ...
            '^-', 'Color', [0, 0.4470, 0.7410], 'LineWidth', 0.75, 'MarkerSize', 4, 'CapSize', 4, 'MarkerFaceColor',[0, 0.4470, 0.7410]);
        
        % Format left y-axis (model predictions)
        ylabel('Model estimates', 'Color', [0, 0.4470, 0.7410], 'FontSize', 10);
        ax_left = gca;
        ax_left.YColor = [0, 0.4470, 0.7410];
        
        % Set y-axis limits for model estimates
        ylim([0, 1]);
        
        % Create right y-axis for observed data (red)
        yyaxis right;
        
        % Plot observed data with error bars (red) with slight x-offset to the right
        hObs = errorbar((1:length(pmidIndices))+0.05, dataSerologyMetaMean(pmidIndices), ...
            dataSerologyMetaMean(pmidIndices) - dataSerologyMetaCI(pmidIndices,1), ...
            dataSerologyMetaCI(pmidIndices,2) - dataSerologyMetaMean(pmidIndices), ...
            'o-', 'Color', [0.8500, 0.3250, 0.0980], 'LineWidth', 0.75, 'MarkerSize', 4, 'CapSize', 4, 'MarkerFaceColor',[0.8500, 0.3250, 0.0980]);
        
        % Format right y-axis (observed data)
        ylabel('Observed seroprevalence', 'Color', [0.8500, 0.3250, 0.0980], 'FontSize', 10);
        ax_right = gca;
        ax_right.YColor = [0.8500, 0.3250, 0.0980];
        
        % Set y-axis limits for observed data
        ylim([0, 1]);
        
        % Set x-axis labels with age ranges
        xticks(1:length(pmidIndices));
        ageLabels = cell(length(pmidIndices), 1);
        for jj = 1:length(pmidIndices)
            idx = pmidIndices(jj);
            
            % Convert ages to months for comparison
            startMonth = round(seroprevDataMeta.ageStart(idx) * 12);
            endMonth = round(seroprevDataMeta.ageEnd(idx) * 12);
            
            % Handle single-value age ranges
            if startMonth == endMonth
                if startMonth < 24
                    ageLabels{jj} = sprintf('%dm', startMonth);
                else
                    ageLabels{jj} = sprintf('%d%s', startMonth/12, 'y');
                end
            % Check if both ages are less than 24 months (2 years)
            elseif endMonth < 24
                % Format all month ranges as X-Ym
                ageLabels{jj} = sprintf('%d-%dm', startMonth, endMonth);
            else
                % For ages > 5 years (60 months), round to integer years
                if startMonth >= 60 && endMonth >= 60
                    startYear = round(startMonth/12);
                    endYear = round(endMonth/12);
                    ageLabels{jj} = sprintf('%d-%dy', startYear, endYear);
                else
                    % Both ages are 2-5 years, check if they're clean years
                    startIsCleanYear = mod(startMonth, 12) == 0;
                    endIsCleanYear = mod(endMonth, 12) == 0;
                    
                    if startIsCleanYear && endIsCleanYear
                        % Both are clean years, show in years
                        ageLabels{jj} = sprintf('%d-%dy', startMonth/12, endMonth/12);
                    else
                        % At least one is not a clean year, show both in months
                        ageLabels{jj} = sprintf('%d-%dm', startMonth, endMonth);
                    end
                end
            end
        end
        xticklabels(ageLabels);
        xtickangle(45);
        set(gca, 'FontSize', 8); % Set smaller font size for tick labels
        
        % Set axis limits
        xlim([0.5, length(pmidIndices)+0.5]);
        
        % Get country and year for this study (using the first occurrence of this PMID)
        studyCountry = seroprevDataMeta.study_country{pmidIndices(1)};
        studyYear = seroprevDataMeta.study_year{pmidIndices(1)};
        
        % Add title for this subplot with country and year
        title(sprintf('%s, %s', studyCountry, studyYear), 'FontSize', 8.5);
        
        if ii == 2
            hLegend = legend([hModel,hObs],{'Model estimates','Observed seroprevalence'});
            set(hLegend,'Location','Southeast','Box','off')
        end
        
        % Remove grid
        grid off;
        
        % Turn off box
        box off;
    end
    
    % Add a main title for the whole figure
    sgtitle('Model fit to RSV seroprevalence in Asia by age, country and year', 'FontSize', 10, 'FontWeight', 'bold');

    AddLetters2Plots(fig_handle, {'a', 'b', 'c','d'})
    
    % Adjust spacing between subplots
    set(fig_handle, 'Units', 'normalized');
    han = axes(fig_handle, 'Visible', 'off');
    han.Title.Visible = 'on';
    han.XLabel.Visible = 'off';
    han.YLabel.Visible = 'off';
    set(han, 'Position', [0 0 1 1]);
    
    % Set figure color to white
    set(fig_handle, 'Color', 'white');
    
    out = fig_handle;
end