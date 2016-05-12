function bits = compress_data(RunObj, thresholds, order, encoding, isValid)

disp(['Compressing data ...'])

if (isValid==0)
    dataProj=RunObj.data.dataProj;
else
    dataProj=RunObj.data.dataValidProj;
end

if (encoding==2)
    bits=npq_encode(dataProj, thresholds, order);
elseif(encoding==0)
    bits=sbq_encode(dataProj, thresholds, order);
elseif(encoding==1)
    bits=dbq_encode(dataProj, thresholds, order);
end
