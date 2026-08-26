function logProposalCorrection = calcTransformedProposalCorrection(parametersCurrent,...
    parametersProposal,lowerRange,upperRange,transformedMask)

logProposalCorrection = zeros(size(parametersCurrent));

if numel(parametersCurrent) >= 15 && all(transformedMask(14:15))
    logPairJacobianRatio = log(parametersProposal(14)) + log(parametersProposal(15)) - ...
        log(parametersCurrent(14)) - log(parametersCurrent(15));
    logProposalCorrection(14:15) = 0.5*logPairJacobianRatio;
    transformedMask(14:15) = false;
end

boundedIdx = find(transformedMask);
for ii = 1:numel(boundedIdx)
    idx = boundedIdx(ii);
    logCurrentJacobian = log((parametersCurrent(idx)-lowerRange(idx))*...
        (upperRange(idx)-parametersCurrent(idx))/(upperRange(idx)-lowerRange(idx)));
    logProposalJacobian = log((parametersProposal(idx)-lowerRange(idx))*...
        (upperRange(idx)-parametersProposal(idx))/(upperRange(idx)-lowerRange(idx)));
    logProposalCorrection(idx) = logProposalJacobian-logCurrentJacobian;
end

end
