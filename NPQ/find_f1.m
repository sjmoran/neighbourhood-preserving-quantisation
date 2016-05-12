function [TP,FP] = find_f1(points, affinity)

    minEl=min(points);
    maxEl=max(points);
    
    subsetSize=size(minEl:maxEl,2);
    totalCount=subsetSize*subsetSize;

    [~,~,values]=find(affinity(minEl:maxEl,minEl:maxEl)); 
    
    TP=sum(values>0); 
    FP=(totalCount)-TP;
    
    %TP and FP are double-counted due to symmetric matrix - this isn't an
    %issue as the F1 is the same regardless.
end

