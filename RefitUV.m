function UVS = RefitUV(UVS,options)

hwait = waitbar(0,'refitting');
UVS = BaselineUV(UVS,options);
waitbar(0.6,hwait,'Trimming Wavelength Range...');
UVS = TrimUV(UVS,options);
waitbar(0.7,hwait,'Normalizing...');
UVS = NormalizeUV(UVS,options);
waitbar(0.8,hwait,'Fitting Spano Model...');
UVS = fitUV(UVS,options);
close(hwait)

% PlotAllUV(SP);
% PlotEB(StructPath);
% PlotFC_Pure(SP,7);
% PlotGMFit(StructPath,24);

end