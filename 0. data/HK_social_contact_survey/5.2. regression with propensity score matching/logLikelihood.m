function logL = logLikelihood(alphaDisp,betaZero,betaVec,regrX,regrY)

% Probability function
miuVec = (exp(betaVec*regrX'+betaZero))';
probVec = (((gamma(regrY+1/alphaDisp)/gamma(1/alphaDisp))./gamma(regrY+1)).*...
    ((1./(1+alphaDisp*miuVec)).^(1/alphaDisp))).*...
    (((alphaDisp*miuVec)./(1+alphaDisp*miuVec)).^regrY);

% Without census age weights
logL = sum(log(probVec));

% % With census age weights
% logL = sum(ageWeights.*log(probVec));

end

