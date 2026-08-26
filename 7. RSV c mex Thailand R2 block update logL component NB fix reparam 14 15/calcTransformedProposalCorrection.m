function logProposalCorrection = calcTransformedProposalCorrection(parametersCurrent,...
    parametersProposal,lowerRange,upperRange,transformedMask)

% transformedMask: 0 = raw RWM (no correction), 1 = log-space (param 8),
%                  2 = bounded-logit
logProposalCorrection = zeros(size(parametersCurrent));

% Parameter 8: log-space Jacobian (mask == 1)
if numel(parametersCurrent) >= 8 && transformedMask(8) == 1
    logProposalCorrection(8) = log(parametersProposal(8)) - log(parametersCurrent(8));
end

% Parameters 14-15: log-log Jacobian pair (mask == 2)
if numel(parametersCurrent) >= 15 && all(transformedMask(14:15) == 2)
    logPairJacobianRatio = log(parametersProposal(14)) + log(parametersProposal(15)) - ...
        log(parametersCurrent(14)) - log(parametersCurrent(15));
    logProposalCorrection(14:15) = 0.5*logPairJacobianRatio;
    transformedMask(14:15) = 0;
end

% All remaining bounded-logit parameters (mask == 2)
boundedIdx = find(transformedMask == 2);
for ii = 1:numel(boundedIdx)
    idx = boundedIdx(ii);
    logCurrentJacobian = log((parametersCurrent(idx)-lowerRange(idx))*...
        (upperRange(idx)-parametersCurrent(idx))/(upperRange(idx)-lowerRange(idx)));
    logProposalJacobian = log((parametersProposal(idx)-lowerRange(idx))*...
        (upperRange(idx)-parametersProposal(idx))/(upperRange(idx)-lowerRange(idx)));
    logProposalCorrection(idx) = logProposalJacobian-logCurrentJacobian;
end

end
