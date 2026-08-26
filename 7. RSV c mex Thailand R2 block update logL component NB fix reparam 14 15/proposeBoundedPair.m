function proposal = proposeBoundedPair(proposal,parameters_c,parameterSteps,...
    lowerRange,upperRange,idx1,idx2,rho,minStepZ)

if nargin < 8
    minStepZ = 0.05;
end

rho = min(max(rho,-0.98),0.98);
sharedDraw = (rand-0.5)*2;
orthDraw = (rand-0.5)*2;

z1Current = boundedLogit(parameters_c(idx1),lowerRange(idx1),upperRange(idx1));
z2Current = boundedLogit(parameters_c(idx2),lowerRange(idx2),upperRange(idx2));
z1Step = boundedLogitStep(parameters_c(idx1),parameterSteps(idx1),...
    lowerRange(idx1),upperRange(idx1),minStepZ);
z2Step = boundedLogitStep(parameters_c(idx2),parameterSteps(idx2),...
    lowerRange(idx2),upperRange(idx2),minStepZ);

proposalZ1 = z1Current + z1Step*sharedDraw;
proposalZ2 = z2Current + z2Step*(rho*sharedDraw + sqrt(1-rho^2)*orthDraw);

proposal(idx1) = inverseBoundedLogit(proposalZ1,lowerRange(idx1),upperRange(idx1));
proposal(idx2) = inverseBoundedLogit(proposalZ2,lowerRange(idx2),upperRange(idx2));
