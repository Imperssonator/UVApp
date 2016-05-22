function [X Y] = PlotFCGui(StructPath,run, flag)

load(StructPath);

%Experimental Data
X = UVS(run).TrimWaves;
En = UVS(run).En;

M = UVS(run).FCFit.M;
FCParams = UVS(run).FCFit.Params;
Y1 = FrankConAgg(FCParams,En,M);
Y2 = FCParams(5)*AmorSpec(StructPath);
Y3 = FrankCondon(FCParams,En,AmorSpec(StructPath),M);
Y4 = UVS(run).NormAbs;

Y=[Y1 Y2 Y3 Y4];

if flag==1
    figure
    hold on
    plot(X,Y1,'--r',X,Y2,'--b',X,Y3,'--g',X,Y4,'-k')
end

save(StructPath,'UVS')

end