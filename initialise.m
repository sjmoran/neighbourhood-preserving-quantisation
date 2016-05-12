function RunObj = initialise()
 
disp(sprintf ( 'Initalising \n') )
 
%%%%%%%%%%%%%%%%
 
NPQ_ENCODING=2;      %0=SBQ encoding, 1=DBQ encoding, 2=MHQ encoding
SBQ_ENCODING=0;

NTEST=1000;          % Test queries
NVALIDTEST=1000;     % Validation queries
NVALIDTRAIN=10000;   % Training set for the validation queries. 
NVALID=1000;
NCHUNK=4;

NAFFINITY_ARRAY=[2000];   % Number of pairs to use for training
IS_DATABASE=0;            % 1=Use train/test/database split

NPQ_BETA=1;          % F_1 score BETA value
NPQ_ALPHA=1;         % How much to interpolate F1 with squared error

DATA_NAME='TINY';   % Dataset name  
NBITS_ARRAY=[16];    % Number of bits
PROJ_TYPE='SH';
NBITS_PER_DIM=2;     % Number of bits per dim for NPQ

if (ispc)
    RES_ROOT_DIR='C:\Users\Sean\Documents\results\';
    DATA_ROOT_DIR='C:\Users\Sean\Documents\data\';
else
    RES_ROOT_DIR='/Users/seanmoran/Desktop/sigir2015/';
    DATA_ROOT_DIR='/Users/seanmoran/Documents/Work/PhD/code/data/quantisation/';
end

NRUNS=10;
AVG_NN=50;
GA_ITER=15;
GA_POP=15;
L2NORM=0;

ALPHAS_ARRAY=[1.0];
BETAS_ARRAY=[1];

%%%%%%%%%%%%%%%
auprcSBQ=0;
auprcNPQ=0;

auprcSBQAvg=zeros(NRUNS,1);
auprcNPQAvg=zeros(NRUNS,1);
    
rNPQAvg=zeros(1000,1);
pNPQAvg=zeros(1000,1);
rNPQAvgDiv=zeros(1000,1);
pNPQAvgDiv=zeros(1000,1);

rSBQAvg=zeros(1000,1);
pSBQAvg=zeros(1000,1);
rSBQAvgDiv=zeros(1000,1);
pSBQAvgDiv=zeros(1000,1);

RunObj=struct('data',struct('randInd',[],'data',[],'affinity',[],'testInd',[],'trainInd',[],'validInd',[],'dataProj',[]), ...
     'results',struct('auprcSBQ',auprcSBQ,'auprcNPQ',auprcNPQ,'auprcSBQAvg',auprcSBQAvg,'auprcNPQAvg',auprcNPQAvg, ...
     'rSBQAvg',rSBQAvg,'pSBQAvg',pSBQAvg,'rSBQAvgDiv',rSBQAvgDiv,'pSBQAvgDiv',pSBQAvgDiv,'rNPQAvg',rNPQAvg,'pNPQAvg', ...
      pNPQAvg,'rNPQAvgDiv',rNPQAvgDiv,'pNPQAvgDiv',pNPQAvgDiv), ...
     'params',struct('ALPHAS_ARRAY', ALPHAS_ARRAY,'NCHUNK',NCHUNK,'L2NORM',L2NORM,'NVALIDTEST',NVALIDTEST, ...
     'NVALIDTRAIN',NVALIDTRAIN,'NPQ_ENCODING',NPQ_ENCODING,'GA_POP', GA_POP, 'GA_ITER', GA_ITER, ...
     'modelsToRun',[],'NAFFINITY_ARRAY',NAFFINITY_ARRAY,'NBITS_ARRAY',NBITS_ARRAY,'DATA_ROOT_DIR',DATA_ROOT_DIR,...
     'SBQ_ENCODING',SBQ_ENCODING,...
     'BETAS_ARRAY',BETAS_ARRAY, 'AVG_NN',AVG_NN,...
     'NPQ_BETA',NPQ_BETA,'NPQ_ALPHA',NPQ_ALPHA,'RES_DIR_FP','','NVALID',NVALID, 'NTEST',NTEST, 'IS_DATABASE',IS_DATABASE,'NRUNS',NRUNS,...
     'NBITS_PER_DIM',NBITS_PER_DIM,'PROJ_TYPE',PROJ_TYPE,'RES_DIR_ROOT',RES_ROOT_DIR,'DATA_NAME',DATA_NAME));
 
%%%%%%%%%%%%%%%
disp(['******************']);
disp(['Parameters are:';]);
disp(['******************']);
disp(['NBITS: ', int2str(NBITS_ARRAY)]);
disp(['PROJ_TYPE: ', PROJ_TYPE]);
disp(['NTEST: ', int2str(NTEST)]);
disp(['NVALIDTEST: ', int2str(NVALIDTEST)]);
disp(['NVALIDTRAIN: ', int2str(NVALIDTRAIN)]);
disp(['NRUNS: ', int2str(NRUNS)]);
disp(['IS_DATABASE: ', int2str(IS_DATABASE)]);
disp(['L2NORM: ', int2str(L2NORM)]);
disp(['NBITS_PER_DIM: ', int2str(NBITS_PER_DIM)]);
disp(['AVG_NN: ', int2str(AVG_NN)])
disp(['NVALID: ', int2str(NVALID)]);
disp(['NCHUNK: ', int2str(NCHUNK)]);
disp(['******************']);

disp(sprintf ( '\n') )
%%%%%%%%%%%%%%%%
 
    

