function [EBBEST, FitParamsBEST, Range]=MikePureOptomizatioin(Waves, Abs, M, N)

LowerStart=540; %545
LowerEnd=565; %565
LowerVec=LowerStart:1:LowerEnd;

UpperStart=610; %650
UpperEnd=590; %630
UpperVec=UpperStart:-1:UpperEnd;

ResNormCur=1;

for i=1:length(LowerVec)
    Low=LowerVec(i);
    for j=1:length(UpperVec)
        Up=UpperVec(j);
        [EB,FitParams, RESNORM, RESIDUAL] = MikeFitFCPure(Waves,Abs,Low, Up, M, N);        
        ResNorm=RESNORM/(Up-Low);
        if ResNormCur>ResNorm
            EBBEST=EB;
            FitParamsBEST=FitParams;
            ResNormCur=ResNorm;
            Range(1)=Low;
            Range(2)=Up;

        end
    end
end
end