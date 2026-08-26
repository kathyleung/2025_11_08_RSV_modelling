function proposalCovPair = calcCovBoundedPair(histSamples,lowerLimit,upperLimit,idxVec)

proposalCovPair = [];
if any(idxVec > size(histSamples,2))
    return;
end

rawPair = histSamples(:,idxVec);
validIdx = all(isfinite(rawPair),2) & all(rawPair > lowerLimit(idxVec),2) & ...
    all(rawPair < upperLimit(idxVec),2);
if nnz(validIdx) < 50
    return;
end

transPair = zeros(nnz(validIdx),numel(idxVec));
rawPair = rawPair(validIdx,:);
for ii = 1:numel(idxVec)
    transPair(:,ii) = boundedLogit(rawPair(:,ii),lowerLimit(idxVec(ii)),upperLimit(idxVec(ii)));
end
proposalCovPair = cov(transPair);
if ~all(isfinite(proposalCovPair(:))) || any(diag(proposalCovPair) <= 0)
    proposalCovPair = [];
end

end
