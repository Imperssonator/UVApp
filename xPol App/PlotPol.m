function [] = PlotPol(handles,sn)

UVS = handles.UVS;

disp_range = handles.options.trimRange;

disp_start = find(UVS(sn).p(1).Waves == disp_range(1),1);
disp_end = find(UVS(sn).p(1).Waves == disp_range(2),1);

X = UVS(sn).p(1).Waves(disp_start:disp_end);
Y1 = UVS(sn).p(1).BlankAbs(disp_start:disp_end);
Y2 = UVS(sn).p(2).BlankAbs(disp_start:disp_end);

plot(handles.axes1,X,Y1,'-g',X,Y2,'-b')

end