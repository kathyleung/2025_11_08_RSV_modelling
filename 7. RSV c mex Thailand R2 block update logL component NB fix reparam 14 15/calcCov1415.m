function proposalCov1415 = calcCov1415(histSamples)

proposalCov1415 = [];
if size(histSamples,2) < 15
    return;
end

raw1415 = histSamples(:,14:15);
validIdx = raw1415(:,1) > 0 & raw1415(:,2) > 0 & ...
    isfinite(raw1415(:,1)) & isfinite(raw1415(:,2));
if nnz(validIdx) < 50
    return;
end

trans1415 = [...
    log(raw1415(validIdx,1).*(1 + raw1415(validIdx,2))),...
    log(raw1415(validIdx,2))];
proposalCov1415 = cov(trans1415);
% Floor the diagonal to avoid zero-variance degeneracy from cold-start
% chains where parameters 14-15 have not yet moved.  A variance floor of
% 0.05^2 in log space corresponds to ~5% movement in original parameters.
if all(isfinite(proposalCov1415(:)))
    minVar = 0.05^2;
    proposalCov1415(1,1) = max(proposalCov1415(1,1), minVar);
    proposalCov1415(2,2) = max(proposalCov1415(2,2), minVar);
else
    proposalCov1415 = [];
end

end
