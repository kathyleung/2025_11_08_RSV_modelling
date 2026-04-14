function out = logPriorDistribution(params)
    % Parameters are assumed to be in the order:
    % 1. xi (maternal immunity rate)
    % 2. omega (post-infection immunity rate)
    % 3. sigma (exposure rate)
    % 4. gamma0 (primary infection rate)
    % 5. g1 (Weibull shape=34.224, scale=0.879)
    % 6. g2 (Lognormal mu=-0.561, sigma=0.163)
    % 7. delta1 (Beta(35.583, 11.417))
    % 8. delta2 (Beta(22.829, 3.171))
    % 9. delta3 (Beta(6.117, 12.882))
    % 10. pAsym<1 (Beta(3.003, 29.997))
    % 11. pAsym1-4 (Beta(8.996, 43.004))
    % 12. pAsym5-14 (Beta(38.033, 34.967))
    % 13. pAsym15+ (Beta(35.955, 11.045))
    % 14. alpha (Uniform(0,1))
    % 15. q_p (Uniform(0,1))
    % 16. q_c (Uniform(0,1))
    % 17. b1 (Uniform(0,5))
    % 18. phi (Uniform(0,1))
    % 19. psi (Uniform(0,1))
    % 20. l1 (Uniform(0,1))
    % 21. l2 (Uniform(0,1))
    
    log_prior = zeros(1,28);
    
    % 1. xi: D_maternal = 1/xi ~ Uniform(14, 365*5)
    xiMaternalImmunity = params(1);
    if xiMaternalImmunity <= 0
        log_p = -1e9;
    else
        D_maternal = 1 / xiMaternalImmunity;
        if D_maternal < 14 || D_maternal > 365*5
            log_p = -1e9;
        else
            log_p = log(1/(365*5-14)) - 2*log(xiMaternalImmunity);
        end
    end
    log_prior(1) = log_p;
    
    % 2. omega: D_immunity = 1/omega ~ Normal(135, 35)
    omegaInfectionImmunity = params(2);
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
    log_prior(2) = log_p;
    
    % 3. sigma: D_exposure = 1/sigma ~ Gamma(2, 1)
    sigmaExposure = params(3);
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
    log_prior(3) = log_p;
    
    % 4. gamma0: D_primary = 1/gamma0 ~ Weibull(shape=4, scale=2)
    gammaZeroPrimaryInfection = params(4);
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
    log_prior(4) = log_p;
    
    % 5. g1 ~ Weibull(shape=34.224, scale=0.879)
    g1ReductionInfectiousDuration = params(5);
    if g1ReductionInfectiousDuration <= 0
        log_p = -1e9;
    else
        log_p = log(wblpdf(g1ReductionInfectiousDuration, 0.879, 34.224)); % scale, shape
        if isinf(log_p) && log_p < 0
            log_p = -1e9; 
        end
    end
    log_prior(5) = log_p;
        
    % 6. g2 ~ Lognormal(mu=-0.561, sigma=0.163)
    g2ReductionInfectiousDuration = params(6);
    if g2ReductionInfectiousDuration <= 0
        log_p = -1e9; 
    else
        log_p = log(lognpdf(g2ReductionInfectiousDuration, -0.561, 0.163));
        if isinf(log_p) && log_p < 0
            log_p = -1e9; 
        end
    end
    log_prior(6) = log_p;
    
    % Parameter 7-13. Beta distributed parameters
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
    for iiBeta = 7:13
        val = params(iiBeta);
        if val < 0 || val > 1
            log_prior = -1e9; 
        end
        a = beta_params(iiBeta-6, 1);
        b = beta_params(iiBeta-6, 2);
        log_prior(iiBeta) = log(betapdf(val, a, b));
    end
    
    % Parameter 14-16. Uniform(0,1) parameters
    % alphaReductionInfectiousness
    % qTransmissPhysical
    % qTransmissConversation
    for iiUniform = 14
        val = params(iiUniform);
        if val < 0 || val > 1
            log_prior(iiUniform) = -1e9;
        else
            log_prior(iiUniform) = 0;
        end
    end
    val = params(15);
    if val < 0 || val > 1
        log_prior(15) = -1e9;
    else
        log_prior(15) = log(normpdf(0.1,0.1));
    end

    % 17. b1AmpTransmissPeak - uniform distribution
    val = params(16);
    if val < 0 || val > 500
        log_prior(16) = -1e9;
    else
        log_prior(16) = log(1/500);
    end

    % Parameter 17-20. Uniform(0,1) parameters
    % phiSeasonalShift
    % psiSeasonalWavelength
    % iniInfectiousProp
    % iniRecoveredProp
    for iiUniform = 17:20
        val = params(iiUniform);
        if val < 0 || val > 1
            log_prior(iiUniform)  = -1e9;
        else
            log_prior(iiUniform)  = 0;
        end
    end

    % Parameter 24-26. Reporting rate parameters
    for iiUniform = 23:25
        val = params(iiUniform);
        if val < 0 || val > 1
            log_prior(iiUniform)  = -1e9;
        else
            log_prior(iiUniform)  = log(normpdf(val,0.02,0.02));
        end
    end

    out = sum(log_prior);

end