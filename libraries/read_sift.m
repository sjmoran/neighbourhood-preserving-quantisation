%data=spconvert(load('/Users/seanmoran/Documents/Work/PhD/code/quantization/data/sift_1m.rcv'));

DATA_ROOT_DIR='/Users/seanmoran/Documents/Work/PhD/code/quantization/data/';

data=fvecs_read('/Users/seanmoran/Documents/Work/PhD/code/quantization/data/sift_base.fvecs');
data=data';

for i=1:10
    rng(i);
    affinity_ind=randperm(1000000);
    affinity_ind=affinity_ind(:,1:10000)';

    %system('rm /Users/seanmoran/Documents/Work/PhD/code/quantization/data/SIFT/sift1m.rcv');
    %system(['rm /Users/seanmoran/Documents/Work/PhD/code/quantization/data/SIFT/sift1m_affinity_ind',int2str(i),'.mat']);
    system(['rm /Users/seanmoran/Documents/Work/PhD/code/quantization/data/SIFT/sift1m.mat']);

    %dlmwrite('/Users/seanmoran/Documents/Work/PhD/code/quantization/data/SIFT/sift1m.rcv',[int32(a),int32(b),int32(c)],'delimiter','\t','precision','%.2f');
    %save(['/Users/seanmoran/Documents/Work/PhD/code/quantization/data/SIFT/sift1m_valid_ind',int2str(i),'.mat'],'valid_ind');
    save(['/Users/seanmoran/Documents/Work/PhD/code/quantization/data/SIFT/sift1m.mat'],'data');
end

%dlmwrite('/Users/seanmoran/Documents/Work/PhD/code/quantization/data/sift_1m.rcv',[int32(i),int32(j),int32(v)],'delimiter','\t','precision','%.2f');