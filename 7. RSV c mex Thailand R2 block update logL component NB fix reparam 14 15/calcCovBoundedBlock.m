function proposalCovBlock = calcCovBoundedBlock(histSamples,lowerLimit,upperLimit,idxVec)

proposalCovBlock = [];
if any(idxVec > size(histSamples,2))
    return;
end

rawBlock = histSamples(:,idxVec);
validIdx = all(isfinite(rawBlock),2) & all(rawBlock > lowerLimit(idxVec),2) & ...
    all(rawBlock < upperLimit(idxVec),2);
if nnz(validIdx) < 100
    return;
end

transBlock = zeros(nnz(validIdx),numel(idxVec));
rawBlock = rawBlock(validIdx,:);
for ii = 1:numel(idxVec)
    transBlock(:,ii) = boundedLogit(rawBlock(:,ii),lowerLimit(idxVec(ii)),upperLimit(idxVec(ii)));
end
proposalCovBlock = cov(transBlock);
if ~all(isfinite(proposalCovBlock(:))) || any(diag(proposalCovBlock) <= 0)
    proposalCovBlock = [];
end

end
