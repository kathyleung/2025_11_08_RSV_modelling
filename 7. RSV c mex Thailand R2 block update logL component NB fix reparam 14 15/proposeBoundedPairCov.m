function [proposalPair,usedTransformedPair] = proposeBoundedPairCov(parameters_c,...
    lowerRange,upperRange,idxVec,proposalCovPair,parameterSteps,scaleSmall,scaleLarge)

proposalPair = parameters_c(idxVec);
usedTransformedPair = false;

if isempty(proposalCovPair) || numel(idxVec) ~= 2
    return;
end
if ~all(isfinite(proposalCovPair(:))) || any(diag(proposalCovPair) <= 0)
    return;
end

[cholCovPair,cholFlag] = chol(proposalCovPair,'lower');
if cholFlag ~= 0
    return;
end

zCurrent = zeros(1,2);
zMinStep = zeros(1,2);
for ii = 1:2
    idx = idxVec(ii);
    zCurrent(ii) = boundedLogit(parameters_c(idx),lowerRange(idx),upperRange(idx));
    zMinStep(ii) = boundedLogitStep(parameters_c(idx),parameterSteps(idx),...
        lowerRange(idx),upperRange(idx),0.02);
end

if rand < 0.15
    proposalScale = scaleLarge;
else
    proposalScale = scaleSmall;
end
deltaZ = proposalScale*(randn(1,2)*cholCovPair');
deltaZ = sign(deltaZ).*max(abs(deltaZ),0.25*zMinStep);
proposalZ = zCurrent + deltaZ;

proposalPair(1) = inverseBoundedLogit(proposalZ(1),lowerRange(idxVec(1)),upperRange(idxVec(1)));
proposalPair(2) = inverseBoundedLogit(proposalZ(2),lowerRange(idxVec(2)),upperRange(idxVec(2)));
usedTransformedPair = true;

end
