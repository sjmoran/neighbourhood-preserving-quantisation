function [RunObj] = load_data(RunObj)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% T % V  % A  % ValidTrain% Database  %
% e % a  % f  %           %           %
% s % l  % f  %           %           %
% t % i  % i  %           %           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% T % V  % A  %    ValidTrain         %
% e % a  % f  %                       %
% s % l  % f  %                       %
% t % i  % i  %                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   %                                 %
%   %           Train                 %
%   %                                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if (strcmp(RunObj.params.DATA_NAME,'LABELME'))
    
    data=load([RunObj.params.DATA_ROOT_DIR,'LabelMe_gist.mat']);
    dataFea=data.gist;
    
elseif (strcmp(RunObj.params.DATA_NAME,'CIFAR'))
    
    data=load([RunObj.params.DATA_ROOT_DIR,'Gist512CIFAR10.mat']);
    dataFea=data.X;
    
elseif (strcmp(RunObj.params.DATA_NAME,'TINY'))
    
    data=load([RunObj.params.DATA_ROOT_DIR,'Tiny100k.mat']);
    dataFea=double(data.X);
    dataFea(sum(dataFea,2)<0.0000000001,:)=[];
    
elseif (strcmp(RunObj.params.DATA_NAME,'SIFT1M'))
    
    data=load([RunObj.params.DATA_ROOT_DIR,'sift1m.mat']);
    dataFea=double(data.data);
    
elseif (strcmp(RunObj.params.DATA_NAME,'NUSWIDE'))
    
    data=load([RunObj.params.DATA_ROOT_DIR,'/nus_data.mat']);
    dataFea=double(data.dataFea);   
    
elseif (strcmp(RunObj.params.DATA_NAME,'IMAGENET'))
    
    data=load([RunObj.params.DATA_ROOT_DIR,'/ILSVRC2012_caffe_CNN_sean_mean.mat']);
    dataFea=data.dataFea;
  
end

dataPointsInd=1:size(dataFea,1);
dataPointsInd=dataPointsInd(:,randperm(size(dataPointsInd,2)));

testDataPointsInd=dataPointsInd(:,1:RunObj.params.NTEST);
trainDataPointsInd=dataPointsInd(:,(RunObj.params.NTEST+1):end);
validDataPointsInd=trainDataPointsInd(:,1:RunObj.params.NVALIDTEST);
remainingDataPoints=trainDataPointsInd;
remainingDataPoints(:,1:RunObj.params.NVALIDTEST)=[];
affinityDataPointsInd=remainingDataPoints(:,1:RunObj.params.NAFFINITY);
remainingDataPoints(:,1:RunObj.params.NAFFINITY)=[];
validTrainDataPointsInd=remainingDataPoints(:,1:RunObj.params.NVALIDTRAIN);
remainingDataPoints(:,1:RunObj.params.NVALIDTRAIN)=[];
databaseDataPointsInd=remainingDataPoints;

RunObj.data.data=dataFea;

RunObj.data.trainInd=trainDataPointsInd;
RunObj.data.affinityInd=affinityDataPointsInd;
RunObj.data.testInd=testDataPointsInd;
RunObj.data.databaseInd=databaseDataPointsInd;
RunObj.data.validInd=validDataPointsInd;
RunObj.data.validTrainInd=validTrainDataPointsInd;

if ~(strcmp(RunObj.params.DATA_NAME,'IMAGENET'))
    % Check if no overlap between test queries and affinity/training sets
    for i=1:size(RunObj.data.testInd,2)
        ind=RunObj.data.testInd(:,i);
        assert(isempty(find(RunObj.data.trainInd==ind)));
        assert(isempty(find(RunObj.data.validTrainInd==ind)));
        assert(isempty(find(RunObj.data.validInd==ind)));
        assert(isempty(find(RunObj.data.affinityInd==ind)));
        assert(isempty(find(RunObj.data.databaseInd==ind)));
    end

    % Check no overlap between valid queries and validation/affinity sets
    for i=1:size(RunObj.data.validInd,2)
        ind=RunObj.data.validInd(:,i);
        assert(isempty(find(RunObj.data.validTrainInd==ind)));
        assert(isempty(find(RunObj.data.testInd==ind)));
        assert(isempty(find(RunObj.data.affinityInd==ind)));
        assert(isempty(find(RunObj.data.databaseInd==ind)));
    end

    if (RunObj.params.IS_DATABASE)
        % Check no overlap between valid queries and validation/affinity sets
        for i=1:size(RunObj.data.databaseInd,2)
            ind=RunObj.data.databaseInd(:,i);
            assert(isempty(find(RunObj.data.validTrainInd==ind)));
            assert(isempty(find(RunObj.data.testInd==ind)));
            assert(isempty(find(RunObj.data.affinityInd==ind)));
            assert(isempty(find(RunObj.data.validInd==ind)));
        end
    end
end

if (RunObj.params.IS_DATABASE==1)
    RunObj.params.NTRAIN=RunObj.params.NVALIDTEST+RunObj.params.NVALIDTRAIN;
    RunObj.params.NDATABASE=size(data,1)-RunObj.params.NTEST-RunObj.params.NTRAIN;
else
    RunObj.params.NDATABASE=size(data,1)-RunObj.params.NTEST;
    RunObj.params.NTRAIN=RunObj.params.NDATABASE;
end

RunObj.data.randInd=randperm(size(dataFea,1));
