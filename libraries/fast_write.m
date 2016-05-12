function [] = fast_write(M,filePath)
tic
fid = fopen(filePath, 'Wb');
for i=1:size(M, 1)
    fprintf(fid, '%f ', M(i,:));
    fprintf(fid, '\n');
end
fclose(fid);
toc
end

