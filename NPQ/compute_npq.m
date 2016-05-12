function [RunObj, auprcNPQ] = compute_npq(RunObj, nRun)

disp(sprintf ( 'Running NPQ \n') )

[RunObj, rNPQ,pNPQ,auprcNPQ]=run_npq(RunObj,1:RunObj.params.NBITS);

disp(sprintf('%s\t%f\n','auprcNPQ: ',auprcNPQ))

RunObj.results.rNPQ=[rNPQ;zeros(size(RunObj.results.rNPQAvg,1)-size(rNPQ,1),1)];
RunObj.results.pNPQ=[pNPQ;zeros(size(RunObj.results.pNPQAvg,1)-size(pNPQ,1),1)];
RunObj.results.rNPQAvg=RunObj.results.rNPQAvg+RunObj.results.rNPQ;
RunObj.results.pNPQAvg=RunObj.results.pNPQAvg+RunObj.results.pNPQ;
RunObj.results.rNPQAvgDiv=RunObj.results.rNPQAvgDiv+(RunObj.results.rNPQ>0);
RunObj.results.pNPQAvgDiv=RunObj.results.pNPQAvgDiv+(RunObj.results.pNPQ>0);

RunObj.results.auprcNPQAvg(nRun,:)=auprcNPQ;
