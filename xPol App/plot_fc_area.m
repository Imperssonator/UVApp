function out = plot_fc_area(UVS,run,params)

M=6;
X = UVS(run).TrimWaves;
En = UVS(run).TrimEn;
Y1 = FC_Pure(params,En,M);
Y2 = UVS(run).NormAbs;

figure; ax = gca;
hold(ax,'on')
plot(ax,X,Y2,'-k')
out = area(ax,X,Y1);
out.FaceAlpha = 0.6;
out.FaceColor = [0.2 0.2 1];

end