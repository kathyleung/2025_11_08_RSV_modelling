function out = logPriorDistribution(params)
    % Parameter order follows x0 in main_Thailand.m and unpacking in
    % logLikelihood_RSV.m:
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
    % 25. epsilonReport20
    % 26. epsilonReport21
    % 27. probSeropos
    % 28. linDispMonthlyReport

    if numel(params) ~= 28
        error('logPriorDistribution expects a 28-parameter vector.');
    end
    
    log_prior = zeros(1,length(params));
    
    % Parameter 1. omegaInfectionImmunity: D_immunity = 1/omega ~
    % Normal(135, 35)
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
    
    % Parameter 2. sigmaExposure: D_exposure = 1/sigma ~ Gamma(2, 1)
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
    
    % Parameter 3. gammaZeroPrimaryInfection: D_primary = 1/gamma0 ~
    % Weibull(shape=4, scale=2)
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
    
    % Parameter 4. g1ReductionInfectiousDuration ~ Weibull(scale=0.879,
    % shape=34.224)
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
        
    % Parameter 5. g2ReductionInfectiousDuration ~ Lognormal(mu=-0.561,
    % sigma=0.163)
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
            log_prior(iiBeta) = -1e9;
        else
            a = beta_params(iiBeta-5, 1);
            b = beta_params(iiBeta-5, 2);
            log_prior(iiBeta) = log(betapdf(val, a, b));
        end
    end
    
    % Parameter 13. alphaReductionInfectiousness ~ Beta(8,2)
    % RSV clinical studies suggest asymptomatic individuals shed roughly
    % 50-90% less virus, placing alpha in the 0.6-0.9 range. Beta(8,2)
    % has mean 0.80, mode 0.875, 95% CI ~[0.55, 0.96].
    val = params(13);
    if val < 0 || val > 1
        log_prior(13) = -1e9;
    else
        log_prior(13) = log(betapdf(val, 8, 2));
    end

    % Parameter 14. qTransmissPhysical uses a flat prior within bounds.
    val = params(14);
    if val < 0 || val > 1
        log_prior(14) = -1e9;
    else
        log_prior(14) = log(normpdf(0.1,0.1));
    end

    % Parameter 15. b1AmpTransmissPeak uses a truncated exponential prior
    % to regularize the weakly identified transmission-amplitude ridge.
    % Tighter regularization: large peak amplitudes (>10) are epidemiologically
    % implausible for a seasonal respiratory virus, so the prior concentrates
    % mass in the low single digits and rejects values above 20 outright.
    val = params(15);
    lowerBoundAmp = 0;
    upperBoundAmp = 20;
    expRateAmp = 1/3; % Mean 3 before truncation; ~4% of prior mass above 10.
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
    % in main_Thailand.m.

    % Parameters 22-26. Age-specific reporting probabilities use the
    % implicit flat prior from the default zero entries in log_prior,
    % together with bounds set in main_Thailand.m.

    % Parameter 27. probSeropos uses the implicit flat prior from the
    % default zero entry in log_prior, together with bounds set in
    % main_Thailand.m.

    % Parameter 28. Linear overdispersion parameter for monthly case
    % counts under Var(Y) = mu * (1 + linDispMonthlyReport).
    % Use a truncated exponential prior to keep Thailand close to Poisson
    % unless the data support appreciable extra-Poisson variation.
    val = params(28);
    lowerBoundDisp = 1e-9;
    upperBoundDisp = 100;
    expRateDisp = 20; % Mean 0.05 before truncation.
    if val < lowerBoundDisp || val > upperBoundDisp
        log_prior(28) = -1e9;
    else
        truncNorm = exp(-expRateDisp*lowerBoundDisp) - exp(-expRateDisp*upperBoundDisp);
        log_prior(28) = log(expRateDisp) - expRateDisp*val - log(truncNorm);
    end

    out = sum(log_prior);

end
