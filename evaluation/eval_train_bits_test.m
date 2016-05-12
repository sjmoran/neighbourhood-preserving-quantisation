function [RunObj, recall,precision, auprc] = eval_train_bits_test(RunObj, bitsData, encoding)

bitsTrainData = bitsData(RunObj.data.trainInd,:);
bitsTestData = bitsData(RunObj.data.testInd,:);


if (encoding==0 || encoding ==1)
       
    bitsTestData=compactbit(bitsTestData>0);
    bitsTrainData=compactbit(bitsTrainData>0);
    
    distHammTestTrain = hammDist_mex(bitsTestData', bitsTrainData');    
else
    distHammTestTrain = slmetric_pw(bitsTestData', bitsTrainData', 'cityblk');
end

[recall, precision, rate] = recall_precision(full(RunObj.data.testGroundTruth), distHammTestTrain);

precision(isnan(precision))=0;
recall(isnan(recall))=0;

assert(sum(isnan(precision))==0);
assert(sum(isnan(recall))==0);

auprc=trapz(recall,precision,1);
