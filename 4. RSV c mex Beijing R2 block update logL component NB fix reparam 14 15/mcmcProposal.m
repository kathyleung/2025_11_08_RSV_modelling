function [parameters_new,logProposalCorrection] = mcmcProposal(parameters_c,...
    parameterSteps,lowerRange,upperRange,proposalCov1415)

parameters_new = parameters_c;
logProposalCorrection = zeros(size(parameters_c));
numPars = length(parameters_c);

for numWhileLoop = 1:1000
    proposal = parameters_c + parameterSteps.*(rand(1,numPars)-0.5)*2;
    transformedMask = false(size(parameters_c));

    if numPars >= 15
        if rand < 0.85
            [proposal1415, usedTransformedProposal] = proposePair1415(parameters_c(14:15),...
                parameterSteps(14:15),proposalCov1415);
            if usedTransformedProposal
                proposal(14:15) = proposal1415;
                transformedMask(14:15) = true;
            else
                rho1415 = -0.65;
                sharedDraw = (rand-0.5)*2;
                orthDraw = (rand-0.5)*2;
                proposal(14) = parameters_c(14) + parameterSteps(14)*sharedDraw;
                proposal(15) = parameters_c(15) + ...
                    parameterSteps(15)*(rho1415*sharedDraw + sqrt(1-rho1415^2)*orthDraw);
            end
        end
    end

    if numPars >= 21
        if rand < 0.85
            rho2021 = -0.85;
            sharedDraw = (rand-0.5)*2;
            orthDraw = (rand-0.5)*2;
            proposal(20) = parameters_c(20) + parameterSteps(20)*sharedDraw;
            proposal(21) = parameters_c(21) + parameterSteps(21)*(rho2021*sharedDraw + sqrt(1-rho2021^2)*orthDraw);
        end
    end

    if numPars >= 26
        if rand < 0.85
            sharedDraw = (rand-0.5)*2;
            orthDraw25 = (rand-0.5)*2;
            orthDraw26 = (rand-0.5)*2;
            proposal(24) = parameters_c(24) + parameterSteps(24)*sharedDraw;
            proposal(25) = parameters_c(25) + ...
                parameterSteps(25)*(-0.70*sharedDraw + sqrt(1-0.70^2)*orthDraw25);
            proposal(26) = parameters_c(26) + ...
                parameterSteps(26)*(0.92*sharedDraw + sqrt(1-0.92^2)*orthDraw26);
        end
    end

    rawMask = ~transformedMask;
    proposal(rawMask & proposal<lowerRange) = lowerRange(rawMask & proposal<lowerRange)+...
        (lowerRange(rawMask & proposal<lowerRange)-proposal(rawMask & proposal<lowerRange));
    proposal(rawMask & proposal>upperRange) = upperRange(rawMask & proposal>upperRange)-...
        (proposal(rawMask & proposal>upperRange)-upperRange(rawMask & proposal>upperRange));

    if any(~isfinite(proposal))
        continue;
    end

    parameters_new = proposal;
    logProposalCorrection = calcTransformedProposalCorrection(parameters_c,proposal,...
        lowerRange,upperRange,transformedMask);
    return;
end

end

