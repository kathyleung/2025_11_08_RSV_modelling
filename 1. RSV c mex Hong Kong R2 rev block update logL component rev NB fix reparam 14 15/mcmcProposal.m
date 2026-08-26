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

    if numPars >= 17
        if rand < 0.8
            proposal = proposeBoundedPair(proposal,parameters_c,parameterSteps,...
                lowerRange,upperRange,16,17,-0.5,0.05);
            transformedMask(16:17) = true;
        end
    end

    if numPars >= 21
        rho2021 = -0.9;
        sharedDraw = (rand-0.5)*2;
        orthDraw = (rand-0.5)*2;
        proposal(20) = parameters_c(20) + parameterSteps(20)*sharedDraw;
        proposal(21) = parameters_c(21) + parameterSteps(21)*(rho2021*sharedDraw + sqrt(1-rho2021^2)*orthDraw);
    end

    if numPars >= 24
        proposal = proposeBoundedPair(proposal,parameters_c,parameterSteps,...
            lowerRange,upperRange,23,24,0.97,0.05);
        transformedMask(23:24) = true;
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

