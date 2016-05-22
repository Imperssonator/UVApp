function [AggFrac CorrectFitAbs FitAmorp]=MikeAggFrac(FitParams, En, M,N, Abs, Waves, Range)

figure
hold on

Low=find(Waves==Range(1));
Up=find(Waves==Range(2));

FitAbs = MikeFrankConAgg(FitParams,En,M, N);
CorrectFitAbs(1:Up)=FitAbs(1:Up)
CorrectFitAbs(Up:length(Abs))=Abs(Up:length(Abs));
CorrectFitAbs=CorrectFitAbs';


FitAmorp=Abs-CorrectFitAbs;

AggArea=trapz(Waves, CorrectFitAbs);
AmorArea=trapz(Waves, FitAmorp);

AggFrac=100*AggArea/(AmorArea*1.39+AggArea);

%This line accounts for the poor fit at the tail end of the distribution
FitAmorp(Up:length(Abs))=Abs(Up:end)-Abs(Up:end);
plot(Waves,Abs,'-k',Waves,CorrectFitAbs,'-b', Waves, FitAmorp, '-r');


end