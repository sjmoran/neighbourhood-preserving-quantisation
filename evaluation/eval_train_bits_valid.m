function [RunObj, recall,precision, auprc] = eval_train_bits_valid(RunObj, bitsData, encoding)

bitsData(1:RunObj.params.NAFFINITY,:)=[];                 % Remove the affinity points - see preprocess
bitsValidData = bitsData(1:RunObj.params.NVALIDTEST,:);
bitsData(1:RunObj.params.NVALIDTEST,:)=[];
bitsTrainData = bitsData;

if (encoding==0 || encoding ==1)
    
    bitsValidData=compactbit(bitsValidData>0);
    bitsTrainData=compactbit(bitsTrainData>0);

    distHammTrainValid = hammDist_mex(bitsValidData', bitsTrainData');
else
    distHammTrainValid = slmetric_pw(bitsValidData', bitsTrainData', 'cityblk');
end

[recall, precision, rate] = recall_precision(RunObj.data.validGroundTruth, distHammTrainValid);

precision(isnan(precision))=0;
recall(isnan(recall))=0;

assert(sum(isnan(precision))==0);
assert(sum(isnan(recall))==0);

auprc=trapz(recall,precision,1);
