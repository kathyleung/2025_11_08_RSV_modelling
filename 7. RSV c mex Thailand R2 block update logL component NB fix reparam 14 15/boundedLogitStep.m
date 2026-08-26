function stepZ = boundedLogitStep(~,stepX,lowerBound,upperBound,minStepZ)

if nargin < 5
    minStepZ = 0.05;
end

stepZ = max(2*abs(stepX)/(upperBound-lowerBound),minStepZ);
