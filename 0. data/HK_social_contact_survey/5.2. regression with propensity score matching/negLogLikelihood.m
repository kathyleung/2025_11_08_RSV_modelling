function negLogL = negLogLikelihood(x,regrX,regrY)

alphaDisp = x(1);
betaZero = x(2);
betaVec = x(3:end);

negLogL = -logLikelihood(alphaDisp,betaZero,betaVec,regrX,regrY);

end

