function parameters_new = mcmcProposal(parameters_c,...
    parameterSteps,lowerRange,upperRange)

parameters_new = -999*ones(size(parameters_c));
numWhileLoop = 0;

while any(bsxfun(@lt,parameters_new,lowerRange)) ||...
      any(bsxfun(@gt,parameters_new,upperRange))
    
    numWhileLoop = numWhileLoop+1;
    parameters_new = parameters_c + parameterSteps.*(rand(1,length(parameters_c))-0.5)*2;
    parameters_new(parameters_new<lowerRange) = lowerRange(parameters_new<lowerRange)+(lowerRange(parameters_new<lowerRange)-parameters_new(parameters_new<lowerRange));
    parameters_new(parameters_new>upperRange) = upperRange(parameters_new>upperRange)-(parameters_new(parameters_new>upperRange)-upperRange(parameters_new>upperRange));
    
    if numWhileLoop > 1000
        break;
    end
end

end

