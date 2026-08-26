function z = boundedLogit(x,lowerBound,upperBound)

epsBound = max(1e-12,1e-9*(upperBound-lowerBound));
x = min(max(x,lowerBound + epsBound),upperBound - epsBound);
frac = (x - lowerBound)/(upperBound - lowerBound);
z = log(frac./(1 - frac));
