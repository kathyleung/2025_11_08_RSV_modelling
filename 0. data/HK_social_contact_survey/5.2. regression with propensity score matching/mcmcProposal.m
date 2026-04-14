function parameters_new = mcmcProposal(parameters_c,parameterSteps,lowerRange,upperRange)

parameters_new = -999*ones(size(parameters_c));

% Constraints
% probPos40 <= probPos20
% meanDayPos20 <= meanDayPos40

while any(bsxfun(@lt,parameters_new,lowerRange)) || any(bsxfun(@gt,parameters_new,upperRange))
    for ii = 1:length(parameters_c)
        parameters_new(ii) = parameters_c(ii) + parameterSteps(ii)*(rand-0.5)*2;
    end
end

end

