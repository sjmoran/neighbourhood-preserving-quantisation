function bits = dbq_encode(projData, thresholds, order)

bits=[];

for i=1:size(thresholds,1)
    
    current_thresh=unique(thresholds(i,:));
    
    current_thresh=current_thresh(:,isinf(current_thresh)==0);
    
    if (~isempty(current_thresh))
        num_thresh=size(current_thresh,2);
        dim=repmat(projData(:,order(:,i)),1,num_thresh);
        threshold=repmat(current_thresh,size(projData,1),1);
        ind=sum(dim>threshold,2);
       
        ind(find(ind==0))=9;
        ind(find(ind==1))=0;
        ind(find(ind==9))=1;

        bits=[bits,dec2bin(ind)];
       
    end
end
bits=double(bits) - double('0');