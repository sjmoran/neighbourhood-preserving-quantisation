function [thresholds,numFunctionEvals] = find_quant_thresh_ga(RunObj,bitsPerDim)

global predictionsGlobal;

NIND=RunObj.params.GA_POP;
MAXGEN=RunObj.params.GA_ITER;

ALPHA=RunObj.params.NPQ_ALPHA;
BETA=RunObj.params.NPQ_BETA;
encoding= RunObj.params.NPQ_ENCODING;

GGAP = .9;           % Generation gap, how many new individuals are created
PRECI = 64;          % Precision of binary representation

dataProj=RunObj.data.dataProj;

dataProj=dataProj(RunObj.data.affinityInd,:);
nPoints=size(dataProj,1);

[dataProjSorted,dataProjSortedInd]=sort(dataProj,1,'ascend');

affinity=sparse(RunObj.data.affinity);
affinityTriuInd = triu(affinity,0);
affinity=sparse(affinity.*affinityTriuInd);
affinity=affinity-diag(diag(affinity));
affinity=sparse(affinity);

fn = @get_thresh_f1_ga;

thresholds=zeros(size(RunObj.data.dataProj,2),15);
thresholds(thresholds==0)=-Inf;

count=0;
predictionsGlobal{1}.count=count;

if (RunObj.params.GA_ITER>0)
    
    for d=1:size(dataProjSorted,2)
        
        nBits=bitsPerDim(:,d);
        
        count=predictionsGlobal{1}.count;
        predictionsGlobal={};
        predictionsGlobal{1}.count=count;
        
        if (nBits>0)
            
            if(nBits==1)
                % Build field descriptor
                FieldD = [rep([PRECI],[1, 1]); rep([1;RunObj.params.NAFFINITY],[1, 1]);...
                    rep([0; 0; 0 ;0], [1, 1])];
                NVAR=1;
            elseif(nBits==2 && encoding==1)   % DBQ encoding
                % Build field descriptor
                FieldD = [rep([PRECI],[1, 2]); rep([1;RunObj.params.NAFFINITY],[1, 2]);...
                    rep([0; 0; 0 ;0], [1, 2])];
                NVAR=2;
            elseif(nBits==2 && encoding ==2)  % MHQ encoding
                % Build field descriptor
                FieldD = [rep([PRECI],[1, 3]); rep([1;RunObj.params.NAFFINITY],[1, 3]);...
                    rep([0; 0; 0 ;0], [1, 3])];
                NVAR=3;
            elseif(nBits==3)
                FieldD = [rep([PRECI],[1, 7]); rep([1;RunObj.params.NAFFINITY],[1, 7]);...
                    rep([0; 0; 0 ;0], [1, 7])];
                NVAR=7;
            elseif(nBits==4)
                FieldD = [rep([PRECI],[1, 15]); rep([1;RunObj.params.NAFFINITY],[1, 15]);...
                    rep([0; 0; 0 ;0], [1, 15])];
                NVAR=15;
            end
            
            dataProjSortedDim=dataProjSorted(:,d);
            dataProjSortedDimInd=dataProjSortedInd(:,d);
            
            % Initialise population
            Chrom = crtbp(NIND, NVAR*PRECI);
            
            % Reset counters
            Best = NaN*ones(MAXGEN,1);	% best in current population
            gen = 0;			% generational counter
            
            % Evaluate initial population
            RunObjV = fn(dataProjSortedDim, dataProjSortedDimInd, affinity, ALPHA, BETA, bs2rv(Chrom,FieldD));
            
            while gen < MAXGEN,
                
                % Assign fitness-value to entire population
                FitnV = ranking(RunObjV);
                
                % Select individuals for breeding
                SelCh = select('sus', Chrom, FitnV, GGAP);
                
                % Recombine selected individuals (crossover)
                SelCh = recombin('xovsp',SelCh,0.7);
                
                % Perform mutation on offspring
                SelCh = mut(SelCh);
                
                % Evaluate offspring, call RunObjective function
                RunObjVSel = fn(dataProjSortedDim, dataProjSortedDimInd, affinity, ALPHA, BETA, bs2rv(SelCh,FieldD));
                
                % Reinsert offspring into current population
                [Chrom RunObjV]=reins(Chrom,SelCh,1,1,RunObjV,RunObjVSel);
                
                % Increment generational counter
                gen = gen+1;
            end
            % End of GA
            
            [bestScore,bestScoreInd]=min(RunObjV);
            thresholdCandidates=bs2rv(Chrom,FieldD);
            thresholdSorted=sort(thresholdCandidates(bestScoreInd,:),2,'ascend');
            
            thresholdSorted=[0,thresholdSorted,nPoints];
            thresholds=compute_thresholds(thresholds,thresholdSorted, dataProjSortedDim, d);
            
        end
    end
    
    thresholds=sort(thresholds,2,'ascend');
    numFunctionEvals=predictionsGlobal{1}.count;
    
else
    
    thresholds=zeros(size(RunObj.data.dataProj,2),15);
    thresholds(thresholds==0)=-Inf;
    numFunctionEvals=0;
    
    for d=1:size(dataProjSorted,2)
        
        dataProjSortedDim=dataProjSorted(:,d);
        
        nBits=bitsPerDim(:,d);
        
        NVAR=2^(nBits)-1;
        startVal = 1;
        endVal = nPoints;
        
        thresholdCandidates = ((endVal-startVal).*rand(NVAR,1) + startVal)';
        thresholdsSorted=sort(thresholdCandidates,2,'ascend');
        thresholds=compute_thresholds(thresholds, thresholdsSorted, dataProjSortedDim, d);
    end
end
