function outAgeDistr = loadAgeDistrCensus(strCountry)

% Return age distribution from census in Mossong et al Table S2

if strcmp(strCountry, 'Belgium')
    outAgeDistr = [0.055	0.0565	0.0604	0.0593	0.0614	0.0627	0.0688	0.0742	0.078	0.074	0.0674	0.0628	0.0473	0.0472	0.1251];
else if strcmp(strCountry,'Germany')
        outAgeDistr = [0.0444	0.0484	0.0522	0.0582	0.0595	0.0577	0.0643	0.0843	0.0866	0.075	0.0679	0.0547	0.0632	0.0632	0.1203];
    else if strcmp(strCountry, 'Finland')
            outAgeDistr = [0.0542	0.0571	0.0633	0.0608	0.0636	0.0632	0.0585	0.0682	0.0725	0.0731	0.0759	0.0787	0.0522	0.0466	0.112];
        else if strcmp(strCountry, 'Great Britain')
                outAgeDistr = [0.0568	0.0597	0.0641	0.0656	0.0642	0.0616	0.0703	0.0777	0.0759	0.0665	0.0614	0.0648	0.0511	0.045	0.1152];
            else if strcmp(strCountry, 'Italy')
                    outAgeDistr = [0.0468	0.0459	0.0485	0.0494	0.0549	0.0674	0.0792	0.0825	0.0782	0.0686	0.0636	0.0642	0.0561	0.0556	0.1391];
                else if strcmp(strCountry, 'Luxembourg')
                        outAgeDistr = [0.0608	0.0636	0.0628	0.0579	0.0575	0.064	0.0761	0.0864	0.0849	0.0753	0.0657	0.057	0.0459	0.0416	0.1005];
                    else if strcmp(strCountry, 'Netherlands')
                            outAgeDistr = [0.0619	0.0604	0.0616	0.0601	0.0594	0.061	0.0731	0.0808	0.0802	0.0737	0.0684	0.0683	0.0506	0.0415	0.099];
                        else if strcmp(strCountry, 'Poland')
                                outAgeDistr = [0.047	0.0535	0.0665	0.0781	0.0866	0.0802	0.0698	0.0619	0.0678	0.081	0.077	0.0593	0.0396	0.0409	0.0906];
                            else if strcmp(strCountry, 'Hong Kong')
                                    outAgeDistr = [0.031 0.039 0.039 0.036 0.044 0.062 0.071 0.079 0.079 0.079 0.078 0.085 0.083 0.066 0.05 0.027 0.022 0.031];
                                    outAgeDistr = outAgeDistr/sum(outAgeDistr);
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

