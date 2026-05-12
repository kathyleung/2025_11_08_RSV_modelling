function [stateM,...
    stateS0, stateS1, stateS2, stateS3,...
    stateE0, stateE1, stateE2, stateE3,...
    stateI0, stateI1, stateI2, stateI3,...
    stateA0, stateA1, stateA2, stateA3,...
    stateR0, stateR1, stateR2, stateR3,pAsym_arr] = age_SEIR_initial_conditions(...
    stateM,...
    stateS0, stateS1, stateS2, stateS3,...
    stateE0, stateE1, stateE2, stateE3,...
    stateI0, stateI1, stateI2, stateI3,...
    stateA0, stateA1, stateA2, stateA3,...
    stateR0, stateR1, stateR2, stateR3,...
    totalPopulation, ageGroupDefRangeAll,...
    iniInfectiousL1, iniRecoveredL2,...
    xiMaternalImmunity, sigmaExposure,...
    gammaZeroPrimaryInfection, g1ReductionInfectiousDuration, g2ReductionInfectiousDuration,...
    delta1RelSuscep, delta2RelSuscep, delta3RelSuscep,...
    pAsym)

numAgeGroups = length(ageGroupDefRangeAll)-1;
susceptible_non_infected = 0;
infected = 0;
non_infected = 0;

% Precompute pa_xi, pa0, pa1, pa2, pa3 for each age group
pa_xi_a = zeros(1, numAgeGroups);
pa0 = zeros(1, numAgeGroups);
pa1 = zeros(1, numAgeGroups);
pa2 = zeros(1, numAgeGroups);
pa3 = zeros(1, numAgeGroups);
pAsym_arr = zeros(1, numAgeGroups);

for iiAge = 1:numAgeGroups
    lower = ageGroupDefRangeAll(iiAge);
    upper = ageGroupDefRangeAll(iiAge+1);
    length_a = upper - lower;

    % Compute pa_xi (proportion with maternal protection)
    numerator = exp(-365 * xiMaternalImmunity * lower) - exp(-365 * xiMaternalImmunity * upper);
    pa_xi_a(iiAge) = numerator / (365 * xiMaternalImmunity * length_a);

    % Compute pa0, pa1, pa2, pa3 (proportions with previous infections)
    exp_lower = exp(-lower);
    exp_upper = exp(-upper);

    % Poisson integration by parts, summarized
    pa0(iiAge) = (exp_lower - exp_upper) / length_a;
    pa1(iiAge) = (exp_lower * (lower + 1) - exp_upper * (upper + 1)) / length_a;
    pa2(iiAge) = (exp_lower * (lower^2 + 2*lower + 2) - exp_upper * (upper^2 + 2*upper + 2)) / (2 * length_a);
    pa3(iiAge) = 1 - pa0(iiAge) - pa1(iiAge) - pa2(iiAge);
end

% Assign initial conditions to state variables
for iiAge = 1:numAgeGroups
    Na = totalPopulation(iiAge);
    lower = ageGroupDefRangeAll(iiAge);

    % Determine pAsym index based on age group
    if lower < 1
        pa_idx = 1;
    elseif lower >= 1 && lower < 5
        pa_idx = 2;
    elseif lower >= 5 && lower < 15
        pa_idx = 3;
    else
        pa_idx = 4;
    end

    % Get current parameters for age group a
    pa_xi = pa_xi_a(iiAge);
    current_pa = [pa0(iiAge), pa1(iiAge), pa2(iiAge), pa3(iiAge)];

    % Initial conditions for each exposure level (i=0 to 3)
    for iiExposure = 0:3
        switch iiExposure
            case 0
                current_pa = pa0(iiAge);
                non_infected = (1 - iniInfectiousL1(iiAge));
                susceptible_non_infected = (1 - iniRecoveredL2(iiAge)) * non_infected;
                infected = iniInfectiousL1(iiAge);
            case 1
                current_pa = pa1(iiAge);
                non_infected = (1 - delta1RelSuscep*iniInfectiousL1(iiAge));
                susceptible_non_infected = (1 - iniRecoveredL2(iiAge)) * non_infected;
                infected = delta1RelSuscep*iniInfectiousL1(iiAge);
            case 2
                current_pa = pa2(iiAge);
                non_infected = (1 - delta2RelSuscep*delta1RelSuscep*iniInfectiousL1(iiAge));
                susceptible_non_infected = (1 - iniRecoveredL2(iiAge)) * non_infected;
                infected = delta2RelSuscep*delta1RelSuscep*iniInfectiousL1(iiAge);
            case 3
                current_pa = pa3(iiAge);
                non_infected = (1 - delta3RelSuscep*delta2RelSuscep*delta1RelSuscep*iniInfectiousL1(iiAge));
                susceptible_non_infected = (1 - iniRecoveredL2(iiAge)) * non_infected;
                infected = delta3RelSuscep*delta2RelSuscep*delta1RelSuscep*iniInfectiousL1(iiAge);
        end

        % Calculate gamma for current exposure level
        if iiExposure == 0
            gamma_i = gammaZeroPrimaryInfection;
        elseif iiExposure == 1
            gamma_i = gammaZeroPrimaryInfection / g1ReductionInfectiousDuration;
        else
            gamma_i = gammaZeroPrimaryInfection / g1ReductionInfectiousDuration / g2ReductionInfectiousDuration;
        end

        % Compute values
        recovery_prob = gamma_i / (sigmaExposure + gamma_i);

        S_val = Na * (1 - pa_xi) * current_pa * susceptible_non_infected;
        E_val = Na * (1 - pa_xi) * current_pa * (sigmaExposure / (sigmaExposure + gamma_i)) * infected;
        A_val = Na * (1 - pa_xi) * current_pa * recovery_prob * pAsym(pa_idx) * infected;
        I_val = Na * (1 - pa_xi) * current_pa * recovery_prob * (1 - pAsym(pa_idx)) * infected;
        R_val = Na * (1 - pa_xi) * current_pa * iniRecoveredL2(iiAge) * non_infected;

        % Assign to state variables
        if iiExposure == 0
            stateS0(1,iiAge) = S_val;
            stateE0(1,iiAge) = E_val;
            stateA0(1,iiAge) = A_val;
            stateI0(1,iiAge) = I_val;
            stateR0(1,iiAge) = R_val;
        else 
            if iiExposure == 1
                stateS1(1,iiAge) = S_val;
                stateE1(1,iiAge) = E_val;
                stateA1(1,iiAge) = A_val;
                stateI1(1,iiAge) = I_val;
                stateR1(1,iiAge) = R_val;
            else
                if iiExposure == 2
                    stateS2(1,iiAge) = S_val;
                    stateE2(1,iiAge) = E_val;
                    stateA2(1,iiAge) = A_val;
                    stateI2(1,iiAge) = I_val;
                    stateR2(1,iiAge) = R_val;
                else
                    if iiExposure == 3
                        stateS3(1,iiAge) = S_val;
                        stateE3(1,iiAge) = E_val;
                        stateA3(1,iiAge) = A_val;
                        stateI3(1,iiAge) = I_val;
                        stateR3(1,iiAge) = R_val;
                    end
                end
            end
        end
    end

    % Additional initial conditions
    stateM(1,iiAge) = Na * pa_xi;
    pAsym_arr(iiAge) = pAsym(pa_idx);
end

end