function [RunObj, rNPQ, pNPQ, auprcNPQ] = run_npq(RunObj, order)

auprcMaxValid=0;
maxAlpha=0;

bitsPerDim=ones(1,RunObj.params.NBITS).*RunObj.params.NBITS_PER_DIM;

resFileName = [RunObj.params.resDirFilePath,'npq_cross_valid.txt'];
fp = fopen(resFileName, 'a');

betasArray=RunObj.params.BETAS_ARRAY;

threshNPQMax=[];

alphasArray=RunObj.params.ALPHAS_ARRAY;

for i=1:size(RunObj.params.ALPHAS_ARRAY,2)
    
    RunObj.params.NPQ_ALPHA=alphasArray(1,i);
    disp(['Cross validating for alpha=',num2str(RunObj.params.NPQ_ALPHA)])

    for j=1:size(betasArray,2)
        
        RunObj.params.NPQ_BETA=betasArray(1,j);
        
        disp(['Cross validating for beta=',num2str(RunObj.params.NPQ_BETA)])

        [threshNPQ]=find_quant_thresh_ga(RunObj,bitsPerDim);
        
        bitsNPQ=compress_data(RunObj, threshNPQ, order, RunObj.params.NPQ_ENCODING, 1);
        assert(sum(sum(isnan(threshNPQ)))==0);
        
        [RunObj, rNPQValid,pNPQValid,auprcNPQValid]=eval_bits(RunObj, bitsNPQ, RunObj.params.NPQ_ENCODING, 1);
        
        disp(sprintf('%s\t%f\n','auprcNPQValid: ',auprcNPQValid))
        
        if (auprcNPQValid>auprcMaxValid)
            threshNPQMax=threshNPQ;
            auprcMaxValid=auprcNPQValid;
            maxBeta=RunObj.params.NPQ_BETA;
            maxAlpha=RunObj.params.NPQ_ALPHA;
        end
        
        fprintf(fp, '%s\n', '******************');
        fprintf(fp, '%s\t%.5f\n', 'ALPHA', RunObj.params.NPQ_ALPHA);
        fprintf(fp, '%s\t%.5f\n', 'BETA', RunObj.params.NPQ_BETA);
        fprintf(fp, '%s\t%.5f\n', 'AUPRC (Valid)', auprcNPQValid);
        fprintf(fp, '%s\n', '******************');
    end
    
end

RunObj.params.NPQ_BETA=maxBeta;
RunObj.params.NPQ_ALPHA=maxAlpha;

disp(sprintf('%s\t%f\n','Best valid AUPRC= ',auprcMaxValid));
disp(sprintf('%s\t%f\n','Best alpha= ',maxAlpha));
disp(sprintf('%s\t%f\n','Best beta= ',maxBeta));

fprintf(fp, '%s\n', '******************');

fprintf(fp, '%s\t%.5f\n', 'Best ALPHA', maxAlpha);
fprintf(fp, '%s\t%.5f\n', 'Best BETA', maxBeta);
fprintf(fp, '%s\t%.5f\n', 'Best AUPRC (Valid)', auprcMaxValid);
fprintf(fp, '%s\n', '******************');

fclose(fp);

disp(['Using alpha=',num2str(RunObj.params.NPQ_ALPHA)])
disp(['Using beta=',num2str(RunObj.params.NPQ_BETA)])

bitsNPQ=compress_data(RunObj, threshNPQMax, order, RunObj.params.NPQ_ENCODING, 0);
assert(sum(sum(isnan(threshNPQ)))==0);
[RunObj, rNPQTest,pNPQTest,auprcNPQTest]=eval_bits(RunObj, bitsNPQ, RunObj.params.NPQ_ENCODING, 0);

auprcNPQ=auprcNPQTest;
rNPQ=rNPQTest;
pNPQ=pNPQTest;