function UVS = RunUVFolder(FolderName,options)

Directory = BuildDirectory(FolderName);
UVS = BuildStruct(Directory);
UVS = BaselineUV(UVS,options);
UVS = TrimUV(UVS,options);
UVS = NormalizeUV(UVS,options);
UVS = fitUV(UVS,options);

% PlotAllUV(SP);
% PlotEB(StructPath);
% PlotFC_Pure(SP,7);
% PlotGMFit(StructPath,24);

end