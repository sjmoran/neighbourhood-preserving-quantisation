function RunObj = save_results(RunObj)

%%%%% SBQ

RunObj.results.rSBQAvg=RunObj.results.rSBQAvg./RunObj.results.rSBQAvgDiv;
RunObj.results.pSBQAvg=RunObj.results.pSBQAvg./RunObj.results.pSBQAvgDiv;

auprcSBQAvg=sum(RunObj.results.auprcSBQAvg,1)/RunObj.params.NRUNS;
disp(sprintf('%s\t%f\n','auprcSBQAvg: ',auprcSBQAvg))

%%%%% NPQ

RunObj.results.rNPQAvg=RunObj.results.rNPQAvg./RunObj.results.rNPQAvgDiv;
RunObj.results.pNPQAvg=RunObj.results.pNPQAvg./RunObj.results.pNPQAvgDiv;

auprcNPQAvg=sum(RunObj.results.auprcNPQAvg,1)/RunObj.params.NRUNS;
disp(sprintf('%s\t%f\n','auprcNPQAvg: ',auprcNPQAvg))

%%%%%%%%%%%%%%%%%%

resFileName = [RunObj.params.resDirFilePath,'stat_tests.txt'];
fp = fopen(resFileName, 'a');

fprintf(fp, '%s\n', '******************');
%%%% NPQ %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[h,p]=ttest(RunObj.results.auprcNPQAvg,RunObj.results.auprcSBQAvg,0.05);
fprintf(fp, '%s\t%.15f\t%.5f\n', 'NPQ vs SBQ (ttest, 5%)', p, h);
[h,p]=ttest(RunObj.results.auprcNPQAvg,RunObj.results.auprcSBQAvg,0.01);
fprintf(fp, '%s\t%.15f\t%.5f\n', 'NPQ vs SBQ (ttest, 1%)', p, h);
[p,h]=signtest(RunObj.results.auprcNPQAvg,RunObj.results.auprcSBQAvg, 'alpha',0.05);
fprintf(fp, '%s\t%.15f\t%.5f\n', 'NPQ vs SBQ (signtest 5%)',p, h);
[p,h]=signtest(RunObj.results.auprcNPQAvg,RunObj.results.auprcSBQAvg, 'alpha',0.01);
fprintf(fp, '%s\t%.15f\t%.5f\n', 'NPQ vs SBQ (signtest 1%)',p, h);
[p,h]=signrank(RunObj.results.auprcNPQAvg,RunObj.results.auprcSBQAvg, 'alpha', 0.05);
fprintf(fp, '%s\t%.15f\t%.5f\n', 'NPQ vs SBQ (signrank, 5%)', p, h);
[p,h]=signrank(RunObj.results.auprcNPQAvg,RunObj.results.auprcSBQAvg, 'alpha', 0.01);
fprintf(fp, '%s\t%.15f\t%.5f\n', 'NPQ vs SBQ (signrank 1%)', p, h);

fprintf(fp, '%s\n', '******************');

%%%%%%%%%%%%%%%%

resFileName = [RunObj.params.resDirFilePath,'results.txt'];
fp = fopen(resFileName, 'a');

fprintf(fp, '%s\n', '******************');
fprintf(fp, '%s\t%.5f\n', 'AUPRC (NPQ)', auprcNPQAvg);
fprintf(fp, '%s\t%.5f\n', 'AUPRC (SBQ)', auprcSBQAvg);
fprintf(fp, '%s\n', '******************');
fclose(fp);

paramsFileName = [RunObj.params.resDirFilePath,'params.txt'];
fp = fopen(paramsFileName, 'a');

fprintf(fp, '%s\t%.1f\n', 'NBITS_PER_DIM', RunObj.params.NBITS_PER_DIM);
fprintf(fp, '%s\t%.1f\n', 'NUM_RUNS', RunObj.params.NRUNS);
fprintf(fp, '%s\t%.1f\n', 'NUM_BITS', RunObj.params.NBITS_ARRAY);
fprintf(fp, '%s\t%s\n', 'DATA NAME', RunObj.params.DATA_NAME);
fprintf(fp, '%s\t%s\n', 'PROJ_TYPE', RunObj.params.PROJ_TYPE);
fprintf(fp, '%s\t%.1f\n', 'NAFFINITY', RunObj.params.NAFFINITY);
fprintf(fp, '%s\t%.1f\n', 'NTEST', RunObj.params.NTEST);
fprintf(fp, '%s\t%.1f\n', 'NVALIDTEST', RunObj.params.NVALIDTEST);
fprintf(fp, '%s\t%.1f\n', 'NVALIDTRAIN', RunObj.params.NVALIDTRAIN);
fprintf(fp, '%s\t%.1f\n', 'IS_DATABASE', RunObj.params.IS_DATABASE);
fprintf(fp, '%s\t%.1f\n', 'L2NORM', RunObj.params.L2NORM);
fprintf(fp, '%s\t%.1f\n', 'AVG_NN', RunObj.params.AVG_NN);
fprintf(fp, '%s\t%.1f\n', 'NVALID', RunObj.params.NVALID);
fprintf(fp, '%s\t%.1f\n', 'NCHUNK', RunObj.params.NCHUNK);
fprintf(fp, '%s\t%.1f\n', 'NPQ_ENCODING', RunObj.params.NPQ_ENCODING);
fprintf(fp, '%s\t%.1f\n', 'SBQ_ENCODING', RunObj.params.SBQ_ENCODING);

nOfModels = size(RunObj.params.modelsToRun,2);
fprintf(fp,['%s\t' repmat('%g\t',1,nOfModels-1) '%g\n'],'MODELS',RunObj.params.modelsToRun.');

fclose(fp);

% PR curve Output for plotting
resFileName = [RunObj.params.resDirFilePath,'rSBQ.csv'];
csvwrite(resFileName,RunObj.results.rSBQAvg);

resFileName = [RunObj.params.resDirFilePath,'pSBQ.csv'];
csvwrite(resFileName,RunObj.results.pSBQAvg);

resFileName = [RunObj.params.resDirFilePath,'rNPQ.csv'];
csvwrite(resFileName,RunObj.results.rNPQAvg);

resFileName = [RunObj.params.resDirFilePath,'pNPQ.csv'];
csvwrite(resFileName,RunObj.results.pNPQAvg);

% PR curve Output for plotting
resFileName = [RunObj.params.resDirFilePath,'auprcSBQ.csv'];
csvwrite(resFileName,RunObj.results.auprcSBQAvg);

resFileName = [RunObj.params.resDirFilePath,'auprcNPQ.csv'];
csvwrite(resFileName,RunObj.results.auprcNPQAvg);
