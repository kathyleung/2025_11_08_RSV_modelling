function [proposal1415, usedEmpiricalCov] = proposePair1415(current1415,...
    ~,proposalCov1415)

proposal1415 = current1415;
usedEmpiricalCov = false;

if nargin < 3
    proposalCov1415 = [];
end

% Cannot propose in log space if current values are non-positive
if any(current1415 <= 0)
    return;
end

% Fall back to a default diagonal covariance when the empirical cov is
% unavailable (cold start, no saved chain, or too few samples).  This
% ensures the transformed proposal always fires with at least a ~5%
% movement scale instead of falling back to tiny raw RWM steps.
if isempty(proposalCov1415) || ~all(isfinite(proposalCov1415(:))) || any(diag(proposalCov1415) <= 0)
    proposalCov1415 = [0.05^2, 0; 0, 0.05^2];
end

[cholCov1415,cholFlag] = chol(proposalCov1415,'lower');
if cholFlag ~= 0
    return;
end

% Floor the Cholesky diagonal to avoid the cold-start trap where a
% stationary chain yields machine-epsilon variance, producing proposals
% that are accepted but imperceptible.  A std floor of 0.05 in log space
% corresponds to ~5% movement in the original parameters.
minCholDiag = 0.05;
cholCov1415(1,1) = max(cholCov1415(1,1), minCholDiag);
cholCov1415(2,2) = max(cholCov1415(2,2), minCholDiag);

currentPeakScale = current1415(1)*(1 + current1415(2));
if currentPeakScale <= 0
    return;
end

currentTransformed1415 = [log(currentPeakScale), log(current1415(2))];
% Use a fixed optimal RWM scale decoupled from the (possibly tiny) step
% sizes, to avoid the feedback loop where small steps suppress the proposal
% magnitude and vice versa.
if rand < 0.15
    proposalScale = 0.25;  % occasional larger move
else
    proposalScale = 0.40;  % reduced to target ~35-40% acceptance
end
delta1415 = proposalScale*(randn(1,2)*cholCov1415');
proposalTransformed1415 = currentTransformed1415 + delta1415;

proposalAmp = exp(proposalTransformed1415(2));
proposalPeakScale = exp(proposalTransformed1415(1));
proposalQ = proposalPeakScale/(1 + proposalAmp);
proposal1415 = [proposalQ, proposalAmp];
usedEmpiricalCov = true;
