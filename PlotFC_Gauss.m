function [] = PlotFC_Gauss(StructPath,run)

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
GaussParams = [1-Params(4), Params(5), Params(6)];
Y1 = Params(4).*FCAgg(Params(1:3),En,M);
Y2 = GaussPeak(GaussParams,1,En);
Y3 = FC_Gauss(Params,En,M);
Y4 = UVS(run).NormAbs;

plot(X,Y1,'--r',X,Y2,'--b',X,Y3,'--g',X,Y4,'-k')

save(StructPath,'UVS')

end