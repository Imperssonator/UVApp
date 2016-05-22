function [AggFrac, PureEB, PureParams] = MikeFitFCAggSingle(Waves, Abs)

Waves=round(Waves)




[EB, FitParams, Range]=MikePureOptomizatioin(Waves, Abs)
% [EB,FitParams] = MikeFitFCPure(Waves,Abs);

hc = 1239.842; 
En = hc./Waves;
M=4;

%Make Plots for Percent Agg and Precent Amop
AggFrac=MikeAggFrac(FitParams, En, M, Abs, Waves, Range);




PureEB = EB;
PureParams = FitParams;



end