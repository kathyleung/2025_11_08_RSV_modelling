function out = fig_serology_meta(mcRecSerologyMetaPrctile, seroprevDataMeta, dataSerologyMetaMean, dataSerologyMetaCI)
% FIG_SEROLOGY_META Plots estimated seroprevalence against meta-analysis data
%
% Inputs:
%   mcRecSerologyMetaPrctile - Matrix with median (col 1) and 95% CI (cols 2-3)
%   seroprevDataMeta - Table with meta-analysis data including PMID
%   dataSerologyMetaMean - Vector of mean seroprevalence values
%   dataSerologyMetaCI - Matrix with lower and upper CI bounds
%
% Output:
%   fig - Figure handle

% Get unique PMIDs
uniquePMIDs = unique(seroprevDataMeta.PMID);

% Create figure
fig_handle = figure(10);
% set(gcf, 'Position',[100, 100, 1200, 800]);

% Number of PMIDs
numPMIDs = length(uniquePMIDs);

% Calculate subplot layout
rows = ceil(sqrt(numPMIDs));
cols = ceil(numPMIDs/rows);

% Loop through each PMID
for ii = 1:numPMIDs
    % Get current PMID
    currentPMID = uniquePMIDs(ii);
    
    % Find indices for this PMID
    pmidIndices = find(seroprevDataMeta.PMID == currentPMID);
    
    % Create subplot for this PMID
    subplot(rows, cols, ii);
    hold on;
    
    % Create left y-axis for model predictions (blue)
    yyaxis left;
    
    % Plot model predictions as error bars (blue) with slight x-offset to the left
    errorbar((1:length(pmidIndices))-0.05, mcRecSerologyMetaPrctile(pmidIndices,1), ...
        mcRecSerologyMetaPrctile(pmidIndices,1) - mcRecSerologyMetaPrctile(pmidIndices,2), ...
        mcRecSerologyMetaPrctile(pmidIndices,3) - mcRecSerologyMetaPrctile(pmidIndices,1), ...
        'o-', 'Color', [0, 0.4470, 0.7410], 'LineWidth', 0.75, 'MarkerSize', 4, 'CapSize', 4, 'MarkerFaceColor',[0, 0.4470, 0.7410]);
    
    % Format left y-axis (model predictions)
    ylabel('Model estimates', 'Color', [0, 0.4470, 0.7410], 'FontSize', 10);
    ax_left = gca;
    ax_left.YColor = [0, 0.4470, 0.7410];
    
    % Set y-axis limits for model estimates
    ylim([0, 1]);
    
    % Create right y-axis for observed data (red)
    yyaxis right;
    
    % Plot observed data with error bars (red) with slight x-offset to the right
    errorbar((1:length(pmidIndices))+0.05, dataSerologyMetaMean(pmidIndices), ...
        dataSerologyMetaMean(pmidIndices) - dataSerologyMetaCI(pmidIndices,1), ...
        dataSerologyMetaCI(pmidIndices,2) - dataSerologyMetaMean(pmidIndices), ...
        'o-', 'Color', [0.8500, 0.3250, 0.0980], 'LineWidth', 0.75, 'MarkerSize', 4, 'CapSize', 4, 'MarkerFaceColor',[0.8500, 0.3250, 0.0980]);
    
    % Format right y-axis (observed data)
    ylabel('Observed (meta-analysis)', 'Color', [0.8500, 0.3250, 0.0980], 'FontSize', 10);
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
                % cleanYear = mod(startMonth, 12) == 0;
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
    studyCountry = seroprevDataMeta.study_country{pmidIndices(1)};  % Use curly braces to extract from cell array
    studyYear = seroprevDataMeta.study_year{pmidIndices(1)};        % Use curly braces to extract from cell array
    
    % Add title for this subplot with country and year (without PMID)
    % Handle the year as a string to accommodate formats like "2017-2021"
    title(sprintf('%s, %s', studyCountry, studyYear), 'FontSize', 10);
    
    % Add x-label only for bottom row subplots
    row_num = ceil(ii / cols);
    if row_num == rows
        xlabel('Age', 'FontSize', 10);
    else
        xlabel('');
    end
    
    % Remove grid
    grid off;
    
    % Turn off box
    box off;
end

% Add a main title for the whole figure
sgtitle('RSV Seroprevalence by age, country and year', 'FontSize', 10, 'FontWeight', 'bold');

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