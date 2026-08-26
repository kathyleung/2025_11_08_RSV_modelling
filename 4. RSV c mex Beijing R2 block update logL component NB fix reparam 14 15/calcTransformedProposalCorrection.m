function logProposalCorrection = calcTransformedProposalCorrection(parametersCurrent,...
    parametersProposal,~,~,transformedMask)

logProposalCorrection = zeros(size(parametersCurrent));

if numel(parametersCurrent) >= 15 && all(transformedMask(14:15))
    logPairJacobianRatio = log(parametersProposal(14)) + log(parametersProposal(15)) - ...
        log(parametersCurrent(14)) - log(parametersCurrent(15));
    logProposalCorrection(14:15) = 0.5*logPairJacobianRatio;
end

end
