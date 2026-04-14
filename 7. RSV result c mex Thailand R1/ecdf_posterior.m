function [f_p,x_p] = ecdf_posterior(mcParm)

[f_hist,x_hist] = histcounts(mcParm);

if length(x_hist)>40
    x_p = 0.5*(x_hist(1:(end-1))+x_hist(2:end));
    f_p = f_hist/sum(f_hist);
else
    [f_hist,x_hist] = histcounts(mcParm,40);
    x_p = 0.5*(x_hist(1:(end-1))+x_hist(2:end));
    f_p = f_hist/sum(f_hist);
end

end