function [RunObj,recall,precision,auprc] = eval_bits(RunObj, bitsData, encoding, IS_VALID)

disp(sprintf ( 'Evaluating retrieval... \n') )
  
if (RunObj.params.IS_DATABASE==1)
    if (IS_VALID)
       [RunObj, recall,precision, auprc] = eval_database_bits_valid(RunObj, bitsData, encoding);
    else
       [RunObj, recall,precision, auprc] = eval_database_bits_test(RunObj, bitsData, encoding);        
    end
    
else
    if (IS_VALID)
       [RunObj, recall,precision, auprc] = eval_train_bits_valid(RunObj, bitsData, encoding);
    else
       [RunObj, recall,precision, auprc] = eval_train_bits_test(RunObj, bitsData, encoding);        
    end
end