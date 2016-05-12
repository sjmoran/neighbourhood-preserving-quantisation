function RunObj = preprocess(RunObj,run)

disp(sprintf ( 'Generating dataset splits \n') )

if ~(strcmp(RunObj.params.DATA_NAME,'IMAGENET'))
    
    if (RunObj.params.L2NORM)
        RunObj.data.data=RunObj.data.data';
        normX = sqrt(sum(RunObj.data.data.^2, 1));
        RunObj.data.data = bsxfun(@rdivide, RunObj.data.data, normX);
        RunObj.data.data=RunObj.data.data';
    end
    
    data = RunObj.data.data;
    data(isnan(data))=0;
    
    % center the data, VERY IMPORTANT
    sampleMean = mean(data,1);
    RunObj.data.data = data - repmat(sampleMean,size(data,1),1);
end

dataValid=RunObj.data.data([RunObj.data.affinityInd,RunObj.data.validInd,RunObj.data.validTrainInd],:);

if ~(strcmp(RunObj.params.DATA_NAME,'IMAGENET'))
    chunkSize=floor(size(dataValid,1)/RunObj.params.NCHUNK);
    dataValidParFor={};
    for i=1:RunObj.params.NCHUNK-1
        dataValidParFor{i}=dataValid(1+((i-1)*chunkSize):(i*chunkSize),:);
    end
    dataValidParFor{RunObj.params.NCHUNK}=dataValid(1+((RunObj.params.NCHUNK-1)*chunkSize):(size(dataValid,1)),:);
    RunObj.data.dataValidParFor=dataValidParFor;

    RunObj.data.dataValid=dataValid;

    chunkSize=floor(size(RunObj.data.data,1)/RunObj.params.NCHUNK);
    dataParFor={};
    for i=1:RunObj.params.NCHUNK-1
        dataParFor{i}=RunObj.data.data(1+((i-1)*chunkSize):(i*chunkSize),:);
    end
    dataParFor{RunObj.params.NCHUNK}=RunObj.data.data(1+((RunObj.params.NCHUNK-1)*chunkSize):(size(RunObj.data.data,1)),:);

    RunObj.data.dataParFor=dataParFor;
    dataValid=RunObj.data.data([RunObj.data.affinityInd,RunObj.data.validInd,RunObj.data.validTrainInd, RunObj.data.databaseInd],:);
else
    RunObj.data.dataValid=dataValid;
    dataValid=RunObj.data.data([RunObj.data.affinityInd,RunObj.data.validInd,RunObj.data.validTrainInd, RunObj.data.databaseInd],:);
end

distTrueTrain = distMat(dataValid(1:100,:),dataValid); % sample 100 points to find a threshold
distBall = sort(distTrueTrain,2);
distBall = mean(distBall(:,RunObj.params.AVG_NN));

% Compute affinity matrix
affinityData=RunObj.data.data(RunObj.data.affinityInd,:);
affinity=distMat(affinityData,affinityData);
affinity=affinity<distBall;

RunObj.data.affinity=affinity;
RunObj.params.distBall=distBall;

if (RunObj.params.IS_DATABASE==1)
    distTrueTestTrain = distMat(RunObj.data.data(RunObj.data.testInd,:), RunObj.data.data(RunObj.data.databaseInd,:));
else
    distTrueTestTrain = distMat(RunObj.data.data(RunObj.data.testInd,:), RunObj.data.data(RunObj.data.trainInd,:));
end

distTrueValidTrain = distMat(RunObj.data.data(RunObj.data.validInd,:), RunObj.data.data(RunObj.data.validTrainInd,:));

RunObj.data.validGroundTruth = distTrueValidTrain < distBall;
RunObj.data.testGroundTruth = distTrueTestTrain < distBall;