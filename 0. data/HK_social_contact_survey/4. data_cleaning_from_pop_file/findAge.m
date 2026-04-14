function out = findAge(codelabel,age_range_index)

midAge = repmat(999,size(age_range_index));

for iiIdx = 1:length(age_range_index)
    if ismember(age_range_index(iiIdx),codelabel.code_pop)
        midAge(iiIdx) = 0.5*(codelabel.range_lower(codelabel.code_pop==age_range_index(iiIdx))+codelabel.range_upper(codelabel.code_pop==age_range_index(iiIdx)));
    end
end
        
out = midAge;

end

