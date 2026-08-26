function [proposal1415, usedEmpiricalCov] = proposePair1415(current1415,...
    ~,proposalCov1415)

proposal1415 = current1415;
usedEmpiricalCov = false;

if nargin < 3 || isempty(proposalCov1415) || any(current1415 <= 0)
    return;
end

if ~all(isfinite(proposalCov1415(:))) || any(diag(proposalCov1415) <= 0)
    return;
end

[cholCov1415,cholFlag] = chol(proposalCov1415,'lower');
if cholFlag ~= 0
    return;
end

currentPeakScale = current1415(1)*(1 + current1415(2));
if currentPeakScale <= 0
    return;
end

currentTransformed1415 = [log(currentPeakScale), log(current1415(2))];
if rand < 0.15
    proposalScale = 1.20;
else
    proposalScale = 0.80;
end
delta1415 = proposalScale*(randn(1,2)*cholCov1415');
proposalTransformed1415 = currentTransformed1415 + delta1415;

proposalAmp = exp(proposalTransformed1415(2));
proposalPeakScale = exp(proposalTransformed1415(1));
proposalQ = proposalPeakScale/(1 + proposalAmp);
proposal1415 = [proposalQ, proposalAmp];
usedEmpiricalCov = true;

end
