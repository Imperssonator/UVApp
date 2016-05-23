function SP = RunUVFolder(FolderName,options)

Directory = BuildDirectory(FolderName);
SP = BuildStruct(Directory);
BaselineUV(SP,options);
TrimUV(SP,options);
NormalizeUV(SP,options);
fitUV(SP,options);

PlotAllUV(SP);
% PlotEB(StructPath);
PlotFC_Pure(SP,7);
% PlotGMFit(StructPath,24);

end