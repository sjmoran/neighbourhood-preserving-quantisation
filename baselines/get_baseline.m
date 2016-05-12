function [RunObj, bits] = get_baseline(RunObj)

disp(sprintf ( 'Getting baseline \n') )

affinityData=RunObj.data.data(RunObj.data.affinityInd,:);

switch(RunObj.params.PROJ_TYPE)           

    % ITQ method proposed in our CVPR11 paper
    case 'ITQ'
        
        [pc, l] = eigs(cov(affinityData),RunObj.params.NBITS);
        dataProj = RunObj.data.data * pc;
        
        [Y, R] = ITQ(dataProj(RunObj.data.affinityInd,:),100);
        dataProj = dataProj*R;
        
        bits = zeros(size(dataProj));
        bits(dataProj>0)=1;
        
        RunObj.data.dataProj = dataProj;

    case 'PCA'
        
        [pc, l] = eigs(cov(affinityData),RunObj.params.NBITS);
        dataProj = RunObj.data.data * pc;
        bits = zeros(size(dataProj));
        bits(dataProj>0)=1;
        
        RunObj.data.dataProj = dataProj;

    % SKLSH
    % M. Raginsky, S. Lazebnik. Locality Sensitive Binary Codes from
    % Shift-Invariant Kernels. NIPS 2009.
    case 'SKLSH'
        
        RFparam.gamma = 1;
        RFparam.D = size(affinityData,2);
        RFparam.M = RunObj.params.NBITS;
        RFparam = RF_train(RFparam);
        [~,dataProj] = RF_compress(RunObj.data.data, RFparam);
        bits = zeros(size(dataProj));
        bits(dataProj>0)=1;
        
        RunObj.data.dataProj = dataProj;

    % Locality sensitive hashing (LSH)
    case 'LSH'
        
        dataProj = RunObj.data.data * randn(size(RunObj.data.data,2),RunObj.params.NBITS);
        bits = zeros(size(dataProj));
        bits(dataProj>0)=1;
        
        RunObj.data.dataProj = dataProj;

    case 'SH'
        
        SHparam.nbits = RunObj.params.NBITS; % number of bits to code each sample
        SHparam = trainSH(affinityData, SHparam);
        [~,dataProj] = compressSH(RunObj.data.data, SHparam);
        
        bits=zeros(size(dataProj));
        bits(dataProj>0)=1;
        
        RunObj.data.dataProj = dataProj;
end

RunObj.data.dataValidProj=RunObj.data.dataProj([RunObj.data.affinityInd,RunObj.data.validInd,RunObj.data.validTrainInd],:);

end