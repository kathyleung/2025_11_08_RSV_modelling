function logp = logNegativeBinomialMeanLinearDispersion(y, mu, dispParam, meanFloor)
    % Log pmf for a negative binomial observation model with
    %   E[Y] = mu
    %   Var(Y) = mu * (1 + dispParam)
    %
    % This is useful for sparse count data because it preserves
    % extra-Poisson variance even when mu is small. It is equivalent to an
    % NB(mean = mu, size = mu / dispParam) parameterization.
    if nargin < 4 || isempty(meanFloor)
        meanFloor = 0;
    end

    if dispParam <= 0
        error('dispParam must be greater than 0.');
    end
    if any(meanFloor(:) < 0)
        error('meanFloor must be greater than or equal to 0.');
    end

    muOriginal = mu;
    mu = max(mu, meanFloor);
    mu = max(mu, 1e-12);
    sizeParam = max(mu ./ dispParam, 1e-12);

    logp = gammaln(y + sizeParam) ...
        - gammaln(sizeParam) ...
        - gammaln(y + 1) ...
        + sizeParam .* log(sizeParam ./ (sizeParam + mu)) ...
        + y .* log(mu ./ (sizeParam + mu));

    zeroMean = (muOriginal <= 0) & (meanFloor <= 0);
    logp(zeroMean & y == 0) = 0;
    logp(zeroMean & y > 0) = -Inf;
end
