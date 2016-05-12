function [RunObj, recall,precision, auprc] = eval_database_bits_test(RunObj, bitsData, encoding)

bitsDatabaseData = bitsData(RunObj.data.databaseInd,:);
bitsTestData = bitsData(RunObj.data.testInd,:);

if (encoding==0 || encoding ==1)
    
    bitsTestData=compactbit(bitsTestData>0);
    bitsDatabaseData=compactbit(bitsDatabaseData>0);
    
    distHammTestDatabase = hammDist_mex(bitsTestData', bitsDatabaseData');
else
    distHammTestDatabase = slmetric_pw(bitsTestData', bitsDatabaseData', 'cityblk');
end

[recall, precision, rate] = recall_precision(full(RunObj.data.testGroundTruth), distHammTestDatabase);

precision(isnan(precision))=0;
recall(isnan(recall))=0;

assert(sum(isnan(precision))==0);
assert(sum(isnan(recall))==0);

auprc=trapz(recall,precision,1);
