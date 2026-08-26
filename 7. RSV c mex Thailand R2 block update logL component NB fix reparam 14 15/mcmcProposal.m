function [parameters_new,logProposalCorrection] = mcmcProposal(parameters_c,...
    parameterSteps,lowerRange,upperRange,proposalCov1415,proposalCov2021,proposalCov2326,...
    proposalCov345,proposalCov678)

if nargin < 5
    proposalCov1415 = [];
end
if nargin < 6
    proposalCov2021 = [];
end
if nargin < 7
    proposalCov2326 = [];
end
if nargin < 8
    proposalCov345 = [];
end
if nargin < 9
    proposalCov678 = [];
end

parameters_new = parameters_c;
logProposalCorrection = zeros(size(parameters_c));
numPars = length(parameters_c);

for numWhileLoop = 1:1000
    proposal = parameters_c + parameterSteps.*(rand(1,numPars)-0.5)*2;
    % transformedMask: 0 = raw RWM, 1 = log-space (param 8), 2 = bounded-logit
    transformedMask = zeros(size(parameters_c));

    % Reparameterize the transmission/amplitude ridge using:
    % z1 = log(qTransmissPhysical * (1 + b1AmpTransmissPeak))
    % z2 = log(b1AmpTransmissPeak)
    % and use the transformed empirical covariance when it is available.
    if numPars >= 15
        if rand < 0.85
            [proposal1415, usedTransformedProposal] = proposePair1415(parameters_c(14:15),...
                parameterSteps(14:15),proposalCov1415);
            if usedTransformedProposal
                proposal(14:15) = proposal1415;
                transformedMask(14:15) = 2;
            end
        end
    end

    if numPars >= 8
        if rand < 0.75
            % Parameter 8 (delta3RelSuscep) is near its lower bound, so a
            % log-space random walk avoids the degeneracy of bounded-logit.
            logVal8 = log(max(parameters_c(8), 1e-12));
            logStep8 = max(parameterSteps(8)/(upperRange(8)-lowerRange(8)), 0.05);
            proposalLog8 = logVal8 + logStep8*(rand-0.5)*2;
            proposal(8) = exp(proposalLog8);
            transformedMask(8) = 1;
        end
    end

    if numPars >= 13
        if rand < 0.75
            z13Current = boundedLogit(parameters_c(13),lowerRange(13),upperRange(13));
            z13Step = boundedLogitStep(parameters_c(13),1.0*parameterSteps(13),...
                lowerRange(13),upperRange(13),0.04);
            proposalZ13 = z13Current + z13Step*(rand-0.5)*2;
            proposal(13) = inverseBoundedLogit(proposalZ13,lowerRange(13),upperRange(13));
            transformedMask(13) = 2;
        end
    end

    % --- Block [3,4,5]: gamma0, g1Reduction, g2Reduction (correlated)
    if numPars >= 5
        if rand < 0.85
            [proposal345, usedBlock345] = proposeBoundedBlockCov(parameters_c,...
                lowerRange,upperRange,[3,4,5],proposalCov345,parameterSteps,0.10,0.20);
            if usedBlock345
                proposal(3:5) = proposal345;
                transformedMask(3:5) = 2;
            end
        end
    end

    % --- Block [6,7,8]: delta1, delta2, delta3 relative susceptibility
    % When the block cov is available it overrides the standalone log-space
    % proposal for parameter 8 (mask 1 -> 2) so the Jacobian is correct.
    if numPars >= 8
        if rand < 0.85
            [proposal678, usedBlock678] = proposeBoundedBlockCov(parameters_c,...
                lowerRange,upperRange,[6,7,8],proposalCov678,parameterSteps,0.10,0.20);
            if usedBlock678
                proposal(6:8) = proposal678;
                transformedMask(6:8) = 2;
            end
        end
    end

    if numPars >= 21
        if rand < 0.90
            [proposal2021, usedTransformedPair2021] = proposeBoundedPairCov(parameters_c,...
                lowerRange,upperRange,[20,21],proposalCov2021,parameterSteps,0.15,0.30);
            if usedTransformedPair2021
                proposal(20:21) = proposal2021;
            else
                proposal = proposeBoundedPair(proposal,parameters_c,parameterSteps,...
                    lowerRange,upperRange,20,21,-0.9,0.03);
            end
            transformedMask(20:21) = 2;
        end
    end

    if numPars >= 26
        [proposal2326, usedTransformedBlock2326] = proposeBoundedBlockCov(parameters_c,...
            lowerRange,upperRange,[23,24,25,26],proposalCov2326,parameterSteps,0.80,1.50);
        if usedTransformedBlock2326 && rand < 0.80
            proposal(23:26) = proposal2326;
            transformedMask(23:26) = 2;
        else
            if rand < 0.90
                proposal = proposeBoundedPair(proposal,parameters_c,parameterSteps,...
                    lowerRange,upperRange,23,24,0.75,0.04);
                transformedMask(23:24) = 2;
            end
            if rand < 0.15
                z23Current = boundedLogit(parameters_c(23),lowerRange(23),upperRange(23));
                z24Current = boundedLogit(parameters_c(24),lowerRange(24),upperRange(24));
                z23Step = boundedLogitStep(parameters_c(23),parameterSteps(23),...
                    lowerRange(23),upperRange(23),0.04);
                z24Step = boundedLogitStep(parameters_c(24),parameterSteps(24),...
                    lowerRange(24),upperRange(24),0.04);
                sharedStep2324 = min(max(max(z23Step,z24Step),0.03),0.10);
                sharedDraw2324 = (rand-0.5)*2;
                proposal(23) = inverseBoundedLogit(z23Current + sharedStep2324*sharedDraw2324,...
                    lowerRange(23),upperRange(23));
                proposal(24) = inverseBoundedLogit(z24Current + sharedStep2324*sharedDraw2324,...
                    lowerRange(24),upperRange(24));
                transformedMask(23:24) = 2;
            end
            if rand < 0.85
                proposal = proposeBoundedPair(proposal,parameters_c,parameterSteps,...
                    lowerRange,upperRange,25,26,0.85,0.04);
                transformedMask(25:26) = 2;
            end
            if rand < 0.25
                z25Current = boundedLogit(parameters_c(25),lowerRange(25),upperRange(25));
                z26Current = boundedLogit(parameters_c(26),lowerRange(26),upperRange(26));
                z25Step = boundedLogitStep(parameters_c(25),parameterSteps(25),...
                    lowerRange(25),upperRange(25),0.04);
                z26Step = boundedLogitStep(parameters_c(26),parameterSteps(26),...
                    lowerRange(26),upperRange(26),0.04);
                sharedStep2526 = min(max(max(z25Step,z26Step),0.04),0.12);
                sharedDraw2526 = (rand-0.5)*2;
                proposal(25) = inverseBoundedLogit(z25Current + sharedStep2526*sharedDraw2526,...
                    lowerRange(25),upperRange(25));
                proposal(26) = inverseBoundedLogit(z26Current + sharedStep2526*sharedDraw2526,...
                    lowerRange(26),upperRange(26));
                transformedMask(25:26) = 2;
            end
        end
    end

    rawMask = (transformedMask == 0);
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
