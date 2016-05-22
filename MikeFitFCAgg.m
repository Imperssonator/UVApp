function [] = MikeFitFCAgg(StructPath, M, N)


load(StructPath)


for i=1:length(UVS)
Waves = UVS(i).TrimWaves;
Abs = UVS(i).NormAbs;


[EB, FitParams, Range]=MikePureOptomizatioin(Waves, Abs, M, N);
UVS(i).Range=Range;
hc = 1239.842; 
En = hc./Waves;


%Make Plots for Percent Agg and Precent Amop
[AggFrac CorrectFitAbs FitAmorp]=MikeAggFrac(FitParams, En, M, N, Abs, Waves, Range)
UVS(i).AggFrac=AggFrac
UVS(i).FCFits=CorrectFitAbs;
UVS(i).FCAmorp=FitAmorp;

% Make Plots for Gaussian Fits
FCPeaks = PlotMikeFrankConAgg(FitParams,En,M, N);
UVS(i).FCPeaks=FCPeaks;
[Row Col]=size(FCPeaks);
hold on
for j=1:Col
plot(UVS(i).TrimWaves, FCPeaks(:,j), '--');
    
end




UVS(i).PureEB = EB;
UVS(i).PureParams = FitParams;
end

save(StructPath,'UVS')

end