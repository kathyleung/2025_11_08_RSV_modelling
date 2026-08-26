function out = logPriorDistribution(params)
    % Parameter order follows x0 in main_HK.m and unpacking in logLikelihood_RSV.m:
    % 1. omegaInfectionImmunity
    % 2. sigmaExposure
    % 3. gammaZeroPrimaryInfection
    % 4. g1ReductionInfectiousDuration
    % 5. g2ReductionInfectiousDuration
    % 6. delta1RelSuscep
    % 7. delta2RelSuscep
    % 8. delta3RelSuscep
    % 9. pAsymLessThan1
    % 10. pAsym1To4
    % 11. pAsym5To14
    % 12. pAsym15Plus
    % 13. alphaReductionInfectiousness
    % 14. qTransmissPhysical
    % 15. b1AmpTransmissPeak
    % 16. phiSeasonalShift
    % 17. psiSeasonalWavelength
    % 18. iniInfectiousProp
    % 19. iniRecoveredProp
    % 20. expReportIntercept
    % 21. expReportSlope
    % 22. epsilonReport17
    % 23. epsilonReport18
    % 24. epsilonReport19
    % 25. probSeropos
    % 26. linDispWeeklyLab
    % xiMaternalImmunity and qTransmissConversation are fixed elsewhere and
    % are not included in params.
    
    log_prior = zeros(1,length(params));
    
    % 1. omegaInfectionImmunity: D_immunity = 1/omega ~ Normal(135, 35)
    omegaInfectionImmunity = params(1);
    if omegaInfectionImmunity <= 0
        log_p = -1e9;
    else
        D_immunity = 1 / omegaInfectionImmunity;
        log_p = log(normpdf(D_immunity, 135, 35));
        if isinf(log_p) && log_p < 0
            log_p = -1e9;
        else
            log_p = log_p - 2*log(omegaInfectionImmunity);
        end
    end
    log_prior(1) = log_p;
    
    % 2. sigmaExposure: D_exposure = 1/sigma ~ Gamma(2, 1)
    sigmaExposure = params(2);
    if sigmaExposure <= 0
        log_p = -1e9;
    else
        D_exposure = 1 / sigmaExposure;
        log_p = log(gampdf(D_exposure, 2, 1));
        if isinf(log_p) && log_p < 0
            log_p = -1e9; 
        else
            log_p =  log_p - 2*log(sigmaExposure);
        end
    end
    log_prior(2) = log_p;
    
    % 3. gammaZeroPrimaryInfection: D_primary = 1/gamma0 ~ Weibull(shape=4, scale=2)
    gammaZeroPrimaryInfection = params(3);
    if gammaZeroPrimaryInfection <= 0
        log_p = -1e9;
    else
        D_primary = 1 / gammaZeroPrimaryInfection;
        log_p = log(wblpdf(D_primary, 4, 2)); % scale, shape in MATLAB
        if isinf(log_p) && log_p < 0
            log_p = -1e9;
        else
            log_p = log_p - 2*log(gammaZeroPrimaryInfection);
        end
    end
    log_prior(3) = log_p;
    
    % 4. g1ReductionInfectiousDuration ~ Weibull(shape=34.224, scale=0.879)
    g1ReductionInfectiousDuration = params(4);
    if g1ReductionInfectiousDuration <= 0
        log_p = -1e9;
    else
        log_p = log(wblpdf(g1ReductionInfectiousDuration, 0.879, 34.224)); % scale, shape
        if isinf(log_p) && log_p < 0
            log_p = -1e9; 
        end
    end
    log_prior(4) = log_p;
        
    % 5. g2ReductionInfectiousDuration ~ Lognormal(mu=-0.561, sigma=0.163)
    g2ReductionInfectiousDuration = params(5);
    if g2ReductionInfectiousDuration <= 0
        log_p = -1e9; 
    else
        log_p = log(lognpdf(g2ReductionInfectiousDuration, -0.561, 0.163));
        if isinf(log_p) && log_p < 0
            log_p = -1e9; 
        end
    end
    log_prior(5) = log_p;
    
    % Parameters 6-12. Beta-distributed parameters
    % delta1RelSuscep
    % delta2RelSuscep
    % delta3RelSuscep
    % pAsym
    beta_params = [
        35.583, 11.417;    % delta1
        22.829, 3.171;     % delta2
        6.117, 12.882;     % delta3
        3.003, 29.997;     % pAsym<1
        8.996, 43.004;     % pAsym1-4
        38.033, 34.967;    % pAsym5-14
        35.955, 11.045     % pAsym15+
    ];
    for iiBeta = 6:12
        val = params(iiBeta);
        if val < 0 || val > 1
            log_prior = -1e9; 
        end
        a = beta_params(iiBeta-5, 1);
        b = beta_params(iiBeta-5, 2);
        log_prior(iiBeta) = log(betapdf(val, a, b));
    end
    
    % Parameter 13. alphaReductionInfectiousness ~ Uniform(0,1)
    for iiUniform = 13
        val = params(iiUniform);
        if val < 0 || val > 1
            log_prior(iiUniform) = -1e9;
        else
            log_prior(iiUniform) = 0;
        end
    end

    % Parameter 14. qTransmissPhysical uses a flat prior within bounds.
    val = params(14);
    if val < 0 || val > 1
        log_prior(14) = -1e9;
    else
        log_prior(14) = log(normpdf(0.1,0.1));
    end

    % Parameter 15. b1AmpTransmissPeak uses a truncated exponential prior
    % so very large seasonal amplification is discouraged unless it is
    % clearly supported by the data.
    val = params(15);
    lowerBoundAmp = 0;
    upperBoundAmp = 500;
    expRateAmp = 1/100; % Mean 100 before truncation.
    if val < lowerBoundAmp || val > upperBoundAmp
        log_prior(15) = -1e9;
    else
        truncNorm = exp(-expRateAmp*lowerBoundAmp) - exp(-expRateAmp*upperBoundAmp);
        log_prior(15) = log(expRateAmp) - expRateAmp*val - log(truncNorm);
    end

    % Parameters 16-19. Uniform(0,1) parameters
    % phiSeasonalShift
    % psiSeasonalWavelength
    % iniInfectiousProp
    % iniRecoveredProp
    for iiUniform = 16:19
        val = params(iiUniform);
        if val < 0 || val > 1
            log_prior(iiUniform)  = -1e9;
        else
            log_prior(iiUniform)  = 0;
        end
    end

    % Parameters 20-21. expReport coefficients use the implicit flat prior
    % from the default zero entries in log_prior, together with bounds set
    % in main_HK.m.

    % Parameters 22-24. Age-specific reporting probabilities.
    for iiUniform = 22:24
        val = params(iiUniform);
        if val < 0 || val > 1
            log_prior(iiUniform)  = -1e9;
        else
            log_prior(iiUniform)  = log(normpdf(val,0.02,0.02));
        end
    end

    % Parameter 25. probSeropos uses the implicit flat prior from the
    % default zero entry in log_prior, together with bounds set in main_HK.m.

    % Parameter 26. Linear overdispersion parameter for weekly lab counts
    % under Var(Y) = mu * (1 + linDispWeeklyLab).
    % Use a truncated exponential prior to keep Hong Kong close to Poisson
    % unless the data support appreciable extra-Poisson variation.
    val = params(26);
    lowerBoundDisp = 1e-9;
    upperBoundDisp = 100;
    expRateDisp = 20; % Mean 0.05 before truncation.
    if val < lowerBoundDisp || val > upperBoundDisp
        log_prior(26) = -1e9;
    else
        truncNorm = exp(-expRateDisp*lowerBoundDisp) - exp(-expRateDisp*upperBoundDisp);
        log_prior(26) = log(expRateDisp) - expRateDisp*val - log(truncNorm);
    end

    out = sum(log_prior);

end
