function xInit = buildChainInitialPoint(xBase,chainIdx,lowerBound,upperBound,jitterFrac,...
    referenceMcmcPath,numChains)
    xInit = xBase;
    usedReferenceStart = false;

    if nargin < 7 || isempty(numChains)
        numChains = max(1,chainIdx);
    end

    if nargin >= 6 && ~isempty(referenceMcmcPath) && exist(referenceMcmcPath,'file') == 2
        referenceSamples = readmatrix(referenceMcmcPath);
        if ~isempty(referenceSamples)
            validRows = all(isfinite(referenceSamples),2) & referenceSamples(:,1) ~= 0;
            referenceSamples = referenceSamples(validRows,:);
        end
        if ~isempty(referenceSamples)
            if size(referenceSamples,2) == numel(xBase)-1
                referenceSamples = [referenceSamples,repmat(xBase(end),size(referenceSamples,1),1)];
            end
            if size(referenceSamples,2) == numel(xBase)
                tailStartIdx = floor(size(referenceSamples,1)/2) + 1;
                referenceTail = referenceSamples(tailStartIdx:end,:);
                if isempty(referenceTail)
                    referenceTail = referenceSamples;
                end
                anchorPositions = round(((1:numChains)/(numChains+1))*size(referenceTail,1));
                anchorPositions = min(max(anchorPositions,1),size(referenceTail,1));
                anchorIdx = anchorPositions(min(chainIdx,numel(anchorPositions)));
                xInit = referenceTail(anchorIdx,:);
                if numel(xInit) >= 15
                    % Keep the transmission ridge anchored at a common
                    % reference point so starts do not drift to very
                    % different parameter 14-15 combinations.
                    centerIdx = anchorPositions(ceil(numel(anchorPositions)/2));
                    xInit(14:15) = referenceTail(centerIdx,14:15);
                end
                usedReferenceStart = true;
            end
        end
    end

    if ~usedReferenceStart
        if chainIdx == 1
            return;
        end

        paramIdx = 1:numel(xBase);
        paramSpan = upperBound - lowerBound;
        safeSpan = max(paramSpan,max(abs(xBase),1e-6));
        perturbation = sin(1.618*paramIdx + chainIdx) + 0.5*cos((chainIdx + 1)*paramIdx);
        xInit = xBase + jitterFrac*safeSpan.*perturbation;
        if numel(xInit) >= 15
            xInit(14:15) = xBase(14:15);
        end
    end

    paramSpan = upperBound - lowerBound;
    boundBuffer = max(1e-9,1e-6*paramSpan);
    xInit = min(max(xInit,lowerBound + boundBuffer),upperBound - boundBuffer);

    if numel(xInit) >= 11
        xInit(9:11) = sort(xInit(9:11),'ascend');
        xInit(9:11) = min(max(xInit(9:11),lowerBound(9:11) + boundBuffer(9:11)),...
            upperBound(9:11) - boundBuffer(9:11));
    end
end
