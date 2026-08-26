function [c, ceq] = parameterConstraint(x0)

if numel(x0) ~= 28
    error('parameterConstraint expects a 28-parameter vector.');
end

% pAsym
pAsym = x0(9:12);

% Probability that an RSV infection is reported (0-23 months; 2-4 yr)
expReport = [x0(20), x0(21)];

c = [...
    pAsym(1)-pAsym(2),...
    pAsym(2)-pAsym(3),...
    pAsym(3)-pAsym(4),...
    -exp(expReport(1)+expReport(2)),...
    exp(expReport(1)+expReport(2))-1,...
    -exp(expReport(1)+ 5*expReport(2)),...
    exp(expReport(1)+5*expReport(2))-1];

ceq = [];

end

