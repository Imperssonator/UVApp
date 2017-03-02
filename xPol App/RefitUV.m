function UVS = RefitUV(UVS,options)

hwait = waitbar(0,'refitting');
UVS = BaselinePol(UVS,options);
waitbar(0.9,hwait,'Calculating Dichroic Ratios')
UVS = CalcDC(UVS,options);
close(hwait)

% PlotAllUV(SP);
% PlotEB(StructPath);
% PlotFC_Pure(SP,7);
% PlotGMFit(StructPath,24);

end