function seasonalLogLikelihood = calculateSeasonalLikelihood(b1AmpTransmissPeak, phiSeasonalShift, psiSeasonalWavelength, mergWeekILILab)
    % Extract date information from merged data
    weekDates = mergWeekILILab.week_start_rev;
    observedRSVProxy = mergWeekILILab.RSV_proxy_GP;
    
    % Generate predicted seasonal pattern using the parameters
    baseline = mean(observedRSVProxy);
    predictedPattern = baseline * (1 + b1AmpTransmissPeak * exp((mod(weekDates,365.25)/365.25 - phiSeasonalShift).^2 / (2 * psiSeasonalWavelength^2)));
    
    % Calculate residuals
    residuals = observedRSVProxy - predictedPattern;
    
    % Calculate variance of the residuals
    sigma2 = var(residuals);
    
    % Calculate log-likelihood assuming normally distributed errors
    nn = length(observedRSVProxy);
    logLikelihood = -nn/2 * log(2*pi*sigma2) - sum(residuals.^2)/(2*sigma2);
    
    % Handle extreme values
    if isnan(logLikelihood) || isinf(logLikelihood)
        seasonalLogLikelihood = -1e9;
    else
        seasonalLogLikelihood = logLikelihood;
    end
end