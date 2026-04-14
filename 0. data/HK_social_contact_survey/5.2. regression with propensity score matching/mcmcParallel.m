function [iPar,iiLogL] = mcmcParallel(mcSteps,regrX,regrY,parameters,parameterSteps,lowerLimit,upperLimit)

goodMC = false;
pAccept = 0.5*ones(1,length(parameters));
numWhileLoop = 0;
numPars = length(parameters);

while goodMC == false
    numWhileLoop = numWhileLoop+1;
    iPar=zeros(mcSteps,numPars); 
    iiLogL=zeros(mcSteps,1);
    nAccept = zeros(1,numPars);
    parameterSteps(pAccept > 0.7) = parameterSteps(pAccept > 0.7)*1.2;
    parameterSteps(pAccept < 0.3) = parameterSteps(pAccept < 0.3)/1.25;
    parameterSteps = min([parameterSteps;upperLimit-lowerLimit]);
    % Current loglikelihood
    parameters_c = parameters;
    logL = logLikelihood(parameters_c(1),parameters_c(2),parameters_c(3:length(parameters_c)),regrX,regrY);
    for tt = 1:mcSteps
        tempNew = mcmcProposal(parameters_c,parameterSteps,lowerLimit,upperLimit);
        for ii = 1:numPars
            parameters_mc = parameters_c;
            parameters_mc(ii) = tempNew(ii);
            logL_new = logLikelihood(parameters_mc(1),parameters_mc(2),parameters_mc(3:length(parameters_mc)),regrX,regrY);
            alpha = min(1,exp(logL_new-logL));
            uu = rand;
            if uu <= alpha
                parameters_c = parameters_mc;
                logL = logL_new;
                nAccept(ii) = nAccept(ii)+1;
            end
        end
        iiLogL(tt,:) = logL;
        iPar(tt,:) = parameters_c;
        % Check MCMC
        if mod(tt,mcSteps/100) == 0
            pAccept = nAccept/tt;
            write_matrix_new(parameterSteps,'mcmc_result/parameter_step.csv','w',',','dec');
            write_matrix_new(iPar,'mcmc_result/mcmc.csv','w',',','dec');
            display('MCMC');
            display(tt/mcSteps);
            display('Acceptance probability');
            display(pAccept);
            if any(pAccept > 0.7) || any(pAccept < 0.3)
                goodMC = false;
                if numWhileLoop < 100
                    if tt/mcSteps >= 0.01
                        display('Restart mcmc...');
                        break;
                    end
                else
                    goodMC = true;
                end
            else
                goodMC = true;
            end
        end     
    end
end

end



