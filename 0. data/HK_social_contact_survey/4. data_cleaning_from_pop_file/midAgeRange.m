function midAge = midAgeRange(codelabel,age_range_index)

if isnan(age_range_index)
    midAge = NaN;
else
    midAge(age_range_index<=3) = 3+5*(age_range_index(age_range_index<=3)-1);
    midAge(age_range_index>3 & age_range_index<=14) = 3+5*(age_range_index(age_range_index>3 & age_range_index<=14)-2);
    midAge(age_range_index>14) = findAge(codelabel,age_range_index(age_range_index>14));
end

if isempty(midAge)
    midAge = NaN;
end


end

