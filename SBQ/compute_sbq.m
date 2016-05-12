function RunObj = compute_sbq(RunObj, bitsSBQ, nRun)

disp(sprintf ( 'Running SBQ \n') )

[RunObj, rSBQ,pSBQ,auprcSBQ]=eval_bits(RunObj, bitsSBQ, RunObj.params.SBQ_ENCODING, 0);

disp(sprintf('%s\t%f\n','auprcSBQ: ',auprcSBQ))

RunObj.results.rSBQ=[rSBQ;zeros(size(RunObj.results.rSBQAvg,1)-size(rSBQ,1),1)];
RunObj.results.pSBQ=[pSBQ;zeros(size(RunObj.results.pSBQAvg,1)-size(pSBQ,1),1)];

RunObj.results.rSBQAvg=RunObj.results.rSBQAvg+ RunObj.results.rSBQ;
RunObj.results.pSBQAvg=RunObj.results.pSBQAvg+ RunObj.results.pSBQ;

RunObj.results.rSBQAvgDiv=RunObj.results.rSBQAvgDiv+(RunObj.results.rSBQ>0);
RunObj.results.pSBQAvgDiv=RunObj.results.pSBQAvgDiv+(RunObj.results.pSBQ>0);

RunObj.results.auprcSBQAvg(nRun,:)=auprcSBQ;
