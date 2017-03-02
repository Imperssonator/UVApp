function UVS = RunUVFolder(FolderName,options)

hwait = waitbar(0,'Building Directory...');
Directory = BuildDirectory(FolderName);
waitbar(0.1,hwait,'Building Data Structures...');
UVS = BuildStruct(Directory);
waitbar(0.7,hwait,'Converting to Polarized Format')
UVS = PolarStruct(UVS);
waitbar(0.8,hwait,'Removing Baselines...');
UVS = BaselinePol(UVS,options);
waitbar(0.9,hwait,'Calculating Dichroic Ratios')
UVS = CalcDC(UVS,options);

close(hwait)

% PlotAllUV(SP);
% PlotEB(StructPath);
% PlotFC_Pure(SP,7);
% PlotGMFit(StructPath,24);

end