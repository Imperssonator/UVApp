function [] = PlotFC_Pure(StructPath,run)

% Basically re-plotting this function:
% GaussParams = [1-Params(4), Params(5), Params(6)];
% 
% out = Params(4).*FCAgg(Params(1:3),En,M) +...
%     GaussPeak(GaussParams,1,En);
% 

load(StructPath);
figure
hold on

X = UVS(run).TrimWaves;
En = UVS(run).TrimEn;
M = UVS(run).M;
Params = UVS(run).FitParams;
Y3 = FC_Pure(Params,En,M);
Y4 = UVS(run).NormAbs;

plot(X,Y3,'--b',X,Y4,'-k',X,Y4-Y3,'--r')

save(StructPath,'UVS')

end