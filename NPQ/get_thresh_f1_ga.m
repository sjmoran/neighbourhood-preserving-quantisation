function fitness = get_thresh_f1_ga(dataProjSortedDim, dataProjSortedDimInd, affinity, ALPHA, F1_BETA, solutions)

global predictionsGlobal;

fitness=zeros(size(solutions,1),1);
solutions=sort(solutions,2,'ascend');
affinity=affinity(dataProjSortedDimInd,dataProjSortedDimInd);

nDim=size(solutions,1);

nPoints=size(affinity,2);
thresholds=[zeros(nDim,1),solutions,repmat(nPoints,nDim,1)];

squareErrorTotal=sum((dataProjSortedDim-repmat(mean(dataProjSortedDim),size(dataProjSortedDim,2),1)).^2);
nTruePairs=sum(sum(affinity));

for i=1:size(thresholds,1)
    
    TP_RUN=0;
    FP_RUN=0;
    squareError=0;

    for j=1:size(thresholds,2)
        
        if (int32(thresholds(i,j))+1) > int32(thresholds(i,j+1))
            cluster=int32(thresholds(i,j+1));
        else
            cluster=(int32(thresholds(i,j))+1):int32(thresholds(i,j+1));
        end
    
        squareError=squareError+sum((dataProjSortedDim(cluster,:)-repmat(mean(dataProjSortedDim(cluster,:)),size(cluster,2),1)).^2);
    
        [TP,FP]=find_f1(cluster, affinity);
        
        assert(TP>=0);
        assert(FP>=0);
        
        TP_RUN=TP_RUN+TP;
        FP_RUN=FP_RUN+FP;

        if (j+2) > size(thresholds,2)
            break;
        end
    end
    
    FN_RUN=nTruePairs-TP_RUN;
    
    P=TP_RUN/(TP_RUN+FP_RUN);
    R=TP_RUN/(TP_RUN+FN_RUN);

    f1=((F1_BETA.^2+1)*P*R)/((F1_BETA.^2)*P+R);
    
    if isnan(f1)
        f1=0;
    end
    
    assert(f1>=0 && f1 <=1);
    
    squareError=1-(squareError/squareErrorTotal);

    objectiveFn=(ALPHA*f1)+(1-ALPHA)*squareError;

    fitness(i,1)=1-objectiveFn;
    predictionsGlobal{1}.count=predictionsGlobal{1}.count+1;
    
end

