function [agingRate,propAgingDaily] = calcAgingRate(populationSizeTable,populationSizeTableRev,ageGroupDefRange)

agingRate = zeros(12*max(populationSizeTableRev.age_group_end),1);

for ii = 1:length(agingRate)
    for jj = 1:length(populationSizeTable.age_group_start)
        if (ii/12) >= populationSizeTable.age_group_start(jj) && (ii/12) < (populationSizeTable.age_group_end(jj)+1)
            agingRate(ii) = 1-(1-populationSizeTable.age_mortality_rate_per_1000_2022(jj)/1000)^(1/12);
            break;
        end
    end
end

propAgingDaily = 1./(365.25*((ageGroupDefRange(2:end)-ageGroupDefRange(1:(end-1)))));


end