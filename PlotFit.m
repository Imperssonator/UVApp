function [] = PlotFit(handles,sn)

UVS = handles.UVS;

switch lower(handles.options.amor)
    case 'gauss'
            
    case 'none'
        
        X = UVS(sn).TrimWaves;
        En = UVS(sn).TrimEn;
        M = UVS(sn).M;
        Params = UVS(sn).FitParams;
        Y3 = FC_Pure(Params,En,M);
        Y4 = UVS(sn).NormAbs;
        
        plot(handles.axes1,X,Y3,'--b',X,Y4,'-k',X,Y4-Y3,'--r')
        
    otherwise
        
end

end