function recallRetrievedPoints=recall_retrieved_points(groundTruth, distHamm)

retrievedPoints=[50, 100, 500, 1000, 5000, 10000, 15000, 20000];
recallRetrievedPoints=[];

for i=1:size(retrievedPoints,2);
    R=[];
    
    for j=1:size(distHamm,1)
        [distHammSorted,ind]=sort(distHamm(j,:),2,'ascend');
        truthSubset=groundTruth(j,ind);
        distHammSorted=distHammSorted(1,1:retrievedPoints(:,i));
        truthSubset=truthSubset(1,1:retrievedPoints(:,i));
        distHammSorted=(uint16(distHammSorted).*uint16(truthSubset))>0;
        TP=sum(distHammSorted,2);
        FN=sum(truthSubset,2)-TP;
        R(j,:)=TP/(TP+FN);
    end
    
    R(isnan(R))=0;
    recallRetrievedPoints(i,:)=mean(R);
    
end
