function RunObj = make_res_dir(RunObj)

timestamp=[RunObj.params.DATA_NAME,'_',RunObj.params.PROJ_TYPE,'_',int2str(RunObj.params.NRUNS),'_',int2str(RunObj.params.NBITS),'_',int2str(RunObj.params.NAFFINITY),'_',datestr(now,30)];
resDirFilePath = [RunObj.params.RES_DIR_ROOT,timestamp,'/'];
mkdir(resDirFilePath);
RunObj.params.resDirFilePath=resDirFilePath;