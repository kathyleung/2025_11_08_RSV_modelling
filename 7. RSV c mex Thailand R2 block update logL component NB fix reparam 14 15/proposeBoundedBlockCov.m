function [proposalBlock,usedTransformedBlock] = proposeBoundedBlockCov(parameters_c,...
    lowerRange,upperRange,idxVec,proposalCovBlock,parameterSteps,scaleSmall,scaleLarge)

proposalBlock = parameters_c(idxVec);
usedTransformedBlock = false;

if isempty(proposalCovBlock) || size(proposalCovBlock,1) ~= numel(idxVec)
    return;
end
if ~all(isfinite(proposalCovBlock(:))) || any(diag(proposalCovBlock) <= 0)
    return;
end

[cholCovBlock,cholFlag] = chol(proposalCovBlock,'lower');
if cholFlag ~= 0
    return;
end

zCurrent = zeros(1,numel(idxVec));
zMinStep = zeros(1,numel(idxVec));
for ii = 1:numel(idxVec)
    idx = idxVec(ii);
    zCurrent(ii) = boundedLogit(parameters_c(idx),lowerRange(idx),upperRange(idx));
    zMinStep(ii) = boundedLogitStep(parameters_c(idx),parameterSteps(idx),...
        lowerRange(idx),upperRange(idx),0.01);
end

if rand < 0.10
    proposalScale = scaleLarge;
else
    proposalScale = scaleSmall;
end
deltaZ = proposalScale*(randn(1,numel(idxVec))*cholCovBlock');
deltaZ = sign(deltaZ).*max(abs(deltaZ),0.20*zMinStep);
proposalZ = zCurrent + deltaZ;

for ii = 1:numel(idxVec)
    proposalBlock(ii) = inverseBoundedLogit(proposalZ(ii),...
        lowerRange(idxVec(ii)),upperRange(idxVec(ii)));
end
usedTransformedBlock = true;

end
