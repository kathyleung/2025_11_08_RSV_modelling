function outTotalPopu = loadTotalPopulation(strCountry)

% Return total population in 2007 from World Bank website
% Return Hong Kong total population in 2015 in stat gov

if strcmp(strCountry, 'Belgium')
    outTotalPopu = 10625700;
else 
    if strcmp(strCountry,'Germany')
        outTotalPopu = 82266372;
    else 
        if strcmp(strCountry, 'Finland')
            outTotalPopu = 5288720;
        else 
            if strcmp(strCountry, 'Great Britain')
                outTotalPopu = 61322463;
            else 
                if strcmp(strCountry, 'Italy')
                    outTotalPopu = 58438310;
                else 
                    if strcmp(strCountry, 'Luxembourg')
                        outTotalPopu = 479993;
                    else 
                        if strcmp(strCountry, 'Netherlands')
                            outTotalPopu = 16381696;
                        else 
                            if strcmp(strCountry, 'Poland')
                                outTotalPopu = 38120560;
                            else 
                                if strcmp(strCountry, 'Hong Kong')
                                    outTotalPopu = 7324800;
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end
                
end

