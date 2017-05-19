function UVS = RunUVFolder(FolderName,options)

hwait = waitbar(0,'Building Directory...');
Directory = BuildDirectory(FolderName);
waitbar(0.1,hwait,'Building Data Structures...');
UVS = BuildStruct(Directory);
waitbar(0.5,hwait,'Removing Baselines...');
UVS = BaselineUV(UVS,options);
waitbar(0.6,hwait,'Trimming Wavelength Range...');
UVS = TrimUV(UVS,options);
waitbar(0.7,hwait,'Normalizing...');
UVS = NormalizeUV(UVS);
waitbar(0.8,hwait,'Fitting Spano Model...');
UVS = fitUV(UVS,options);
close(hwait)

save('uv_results','UVS')

% PlotAllUV(SP);
% PlotEB(StructPath);
% PlotFC_Pure(SP,7);
% PlotGMFit(StructPath,24);

end