function RunObj = clear_results(RunObj)

RunObj.results.auprcEQUAL=0;
RunObj.results.auprcRAND=0;
RunObj.results.auprcADQ=0;
RunObj.results.auprcDBQ=0;
RunObj.results.auprcMHQ=0;
RunObj.results.auprcSBQ=0;
RunObj.results.auprcVBQIL=0;
RunObj.results.auprcVBQRH=0;
RunObj.results.auprcNPQ=0;
RunObj.results.auprcBBQ=0;
RunObj.results.auprcISOLP=0;
RunObj.results.auprcISOGF=0;
RunObj.results.auprcAGH=0;

RunObj.results.precisionBucketAGHAvg=0;
RunObj.results.recallBucketAGHAvg=0;
RunObj.results.f1BucketAGHAvg=0;

RunObj.results.precisionBucketBBQAvg=0;
RunObj.results.recallBucketBBQAvg=0;
RunObj.results.f1BucketBBQAvg=0;

RunObj.results.precisionBucketRANDAvg=0;
RunObj.results.recallBucketRANDAvg=0;
RunObj.results.f1BucketRANDAvg=0;

RunObj.results.precisionBucketSBQAvg=0;
RunObj.results.recallBucketSBQAvg=0;
RunObj.results.f1BucketSBQAvg=0;

RunObj.results.precisionBucketSTHAvg=0;
RunObj.results.recallBucketSTHAvg=0;
RunObj.results.f1BucketSTHAvg=0;

RunObj.results.precisionBucketGRHAvg=0;
RunObj.results.recallBucketGRHAvg=0;
RunObj.results.f1BucketGRHAvg=0;

RunObj.results.precisionBucketKSHAvg=0;
RunObj.results.recallBucketKSHAvg=0;
RunObj.results.f1BucketKSHAvg=0;

RunObj.results.precisionBucketBREAvg=0;
RunObj.results.recallBucketBREAvg=0;
RunObj.results.f1BucketBREAvg=0;

RunObj.results.precisionBucketAGHAvg=0;
RunObj.results.recallBucketAGHAvg=0;
RunObj.results.f1BucketAGHAvg=0;

RunObj.results.precisionBucketEQUALAvg=0;
RunObj.results.recallBucketEQUALAvg=0;
RunObj.results.f1BucketEQUALAvg=0;

RunObj.results.f1BucketGRHs=[];
RunObj.results.f1BucketSBQs=[];
RunObj.results.f1BucketSTHs=[];
RunObj.results.f1BucketBREs=[];
RunObj.results.f1BucketKSHs=[];
RunObj.results.f1BucketAGHs=[];
RunObj.results.f1BucketBBQs=[];
RunObj.results.f1BucketRANDs=[];
RunObj.results.f1BucketEQUALs=[];
RunObj.results.f1BucketAGHs=[];

RunObj.results.auprcADQAvg=zeros(RunObj.params.NRUNS,1);
RunObj.results.auprcDBQAvg=zeros(RunObj.params.NRUNS,1);
RunObj.results.auprcSBQAvg=zeros(RunObj.params.NRUNS,1);
RunObj.results.auprcVBQRHAvg=zeros(RunObj.params.NRUNS,1);
RunObj.results.auprcVBQILAvg=zeros(RunObj.params.NRUNS,1);
RunObj.results.auprcNPQAvg=zeros(RunObj.params.NRUNS,1);
RunObj.results.auprcBBQAvg=zeros(RunObj.params.NRUNS,1);
RunObj.results.auprcMHQAvg=zeros(RunObj.params.NRUNS,1);
RunObj.results.auprcISOLPAvg=zeros(RunObj.params.NRUNS,1);
RunObj.results.auprcISOGFAvg=zeros(RunObj.params.NRUNS,1);
RunObj.results.auprcRANDAvg=zeros(RunObj.params.NRUNS,1);
RunObj.results.auprcEQUALAvg=zeros(RunObj.params.NRUNS,1);
RunObj.results.auprcAGHAvg=zeros(RunObj.params.NRUNS,1);

RunObj.results.mAPADQAvg=zeros(RunObj.params.NRUNS,1);
RunObj.results.mAPDBQAvg=zeros(RunObj.params.NRUNS,1);
RunObj.results.mAPSBQAvg=zeros(RunObj.params.NRUNS,1);
RunObj.results.mAPVBQRHAvg=zeros(RunObj.params.NRUNS,1);
RunObj.results.mAPVBQILAvg=zeros(RunObj.params.NRUNS,1);
RunObj.results.mAPNPQAvg=zeros(RunObj.params.NRUNS,1);
RunObj.results.mAPBBQAvg=zeros(RunObj.params.NRUNS,1);
RunObj.results.mAPMHQAvg=zeros(RunObj.params.NRUNS,1);
RunObj.results.mAPISOLPAvg=zeros(RunObj.params.NRUNS,1);
RunObj.results.mAPISOGFAvg=zeros(RunObj.params.NRUNS,1);
RunObj.results.mAPRANDAvg=zeros(RunObj.params.NRUNS,1);
RunObj.results.mAPEQUALAvg=zeros(RunObj.params.NRUNS,1);
RunObj.results.mAPAGHAvg=zeros(RunObj.params.NRUNS,1);

RunObj.results.rAGHAvg=zeros(1000,1);
RunObj.results.pAGHAvg=zeros(1000,1);
RunObj.results.rAGHAvgDiv=zeros(1000,1);
RunObj.results.pAGHAvgDiv=zeros(1000,1);

RunObj.results.rEQUALAvg=zeros(1000,1);
RunObj.results.pEQUALAvg=zeros(1000,1);
RunObj.results.rEQUALAvgDiv=zeros(1000,1);
RunObj.results.pEQUALAvgDiv=zeros(1000,1);

RunObj.results.rRANDAvg=zeros(1000,1);
RunObj.results.pRANDAvg=zeros(1000,1);
RunObj.results.rRANDAvgDiv=zeros(1000,1);
RunObj.results.pRANDAvgDiv=zeros(1000,1);
    
RunObj.results.rISOLPAvg=zeros(1000,1);
RunObj.results.pISOLPAvg=zeros(1000,1);
RunObj.results.rISOLPAvgDiv=zeros(1000,1);
RunObj.results.pISOLPAvgDiv=zeros(1000,1);
    
RunObj.results.rISOGFAvg=zeros(1000,1);
RunObj.results.pISOGFAvg=zeros(1000,1);
RunObj.results.rISOGFAvgDiv=zeros(1000,1);
RunObj.results.pISOGFAvgDiv=zeros(1000,1);
    
RunObj.results.rADQAvg=zeros(1000,1);
RunObj.results.pADQAvg=zeros(1000,1);
RunObj.results.rADQAvgDiv=zeros(1000,1);
RunObj.results.pADQAvgDiv=zeros(1000,1);
    
RunObj.results.rSBQAvg=zeros(1000,1);
RunObj.results.pSBQAvg=zeros(1000,1);
RunObj.results.rSBQAvgDiv=zeros(1000,1);
RunObj.results.pSBQAvgDiv=zeros(1000,1);

RunObj.results.rBBQAvg=zeros(1000,1);
RunObj.results.pBBQAvg=zeros(1000,1);
RunObj.results.rBBQAvgDiv=zeros(1000,1);
RunObj.results.pBBQAvgDiv=zeros(1000,1);
    
RunObj.results.rVBQILAvg=zeros(1000,1);
RunObj.results.pVBQILAvg=zeros(1000,1);
RunObj.results.rVBQILAvgDiv=zeros(1000,1);
RunObj.results.pVBQILAvgDiv=zeros(1000,1);

RunObj.results.rVBQRHAvg=zeros(1000,1);
RunObj.results.pVBQRHAvg=zeros(1000,1);
RunObj.results.rVBQRHAvgDiv=zeros(1000,1);
RunObj.results.pVBQRHAvgDiv=zeros(1000,1);

RunObj.results.rNPQAvg=zeros(1000,1);
RunObj.results.pNPQAvg=zeros(1000,1);
RunObj.results.rNPQAvgDiv=zeros(1000,1);
RunObj.results.pNPQAvgDiv=zeros(1000,1);
    
RunObj.results.rMHQAvg=zeros(1000,1);
RunObj.results.pMHQAvg=zeros(1000,1);
RunObj.results.rMHQAvgDiv=zeros(1000,1);
RunObj.results.pMHQAvgDiv=zeros(1000,1);
    
RunObj.results.rDBQAvg=zeros(1000,1);
RunObj.results.pDBQAvg=zeros(1000,1);
RunObj.results.rDBQAvgDiv=zeros(1000,1);
RunObj.results.pDBQAvgDiv=zeros(1000,1);
