function x = inverseBoundedLogit(z,lowerBound,upperBound)

frac = 1./(1 + exp(-z));
x = lowerBound + (upperBound - lowerBound).*frac;

end
