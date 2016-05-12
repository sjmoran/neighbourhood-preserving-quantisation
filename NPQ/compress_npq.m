function bits = compress_npq(obj, thresh, DO_DATABASE)

['Compressing data ...']

XX=obj.XX;

if (DO_DATABASE==1)
    
    XX_training = XX(1:obj.num_train,:);
    XX(1:obj.num_train,:)=[];
    XX_database = XX(1:obj.num_database,:);
    XX(1:obj.num_database,:)=[];
    XX_test = XX(1:obj.num_test,:);
    
    Dtraining=npq_encode(XX_training, thresh);
    Dtest=npq_encode(XX_test, thresh);
    Ddatabase=npq_encode(XX_database, thresh);
    
    bits=[Dtraining;Ddatabase;Dtest];
    
else
    
    XX_training = XX(1:obj.num_train,:);
    XX(1:obj.num_train,:)=[];
    XX_test = XX(1:obj.num_test,:);
    
    Dtraining=npq_encode(XX_training, thresh);
    Dtest=npq_encode(XX_test, thresh);
    
    bits=[Dtraining;Dtest];
   
end

