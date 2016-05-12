function thresholds=compute_thresholds(thresholds,thresholdSorted, dataProjSortedDim, dim)

  i=1;
while i < size(thresholdSorted,2)
    
  if (int32(thresholdSorted(:,i))+1) > int32(thresholdSorted(:,i+1))
					 cluster1_max=int32(thresholdSorted(:,i+1));
  else
    cluster1_max=(int32(thresholdSorted(:,i))+1):int32(thresholdSorted(:,i+1));
    end
    
    if (int32(thresholdSorted(:,i+1))+1) > int32(thresholdSorted(:,i+2))
					     cluster2_max=int32(thresholdSorted(:,i+2));
    else
      cluster2_max=(int32(thresholdSorted(:,i+1))+1):int32(thresholdSorted(:,i+2));
    end
    
    centroid1=mean(dataProjSortedDim(cluster1_max,:));
centroid2=mean(dataProjSortedDim(cluster2_max,:));
    
thresholds(dim,i)=(dataProjSortedDim(cluster1_max(1,end))+dataProjSortedDim(cluster2_max(1,1)))/2;
%thresholds(dim,i)=(centroid2+centroid1)/2;

if (i+2) >= size(thresholdSorted,2)
	      break;
    end
    
    i=i+1;
end
