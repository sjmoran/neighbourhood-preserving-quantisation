function codes = npq_encode(projData, thresholds, order)

codes=[];

for i=1:size(thresholds,1)
    
    current_thresh=unique(thresholds(i,:));
    
    current_thresh=current_thresh(:,isinf(current_thresh)==0);
    
    if (~isempty(current_thresh))
        num_thresh=size(current_thresh,2);
        dim=repmat(projData(:,order(:,i)),1,num_thresh);
        threshold=repmat(current_thresh,size(projData,1),1);
        ind=sum(dim>threshold,2);
        
        codes=[codes,ind];
    end
end