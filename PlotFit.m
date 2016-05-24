function [] = PlotFit(handles,sn)

UVS = handles.UVS;

switch lower(handles.options.amor)
    case 'gauss'
        
    case 'spec'
        
        X = UVS(sn).TrimWaves;
        En = UVS(sn).TrimEn;
        M = UVS(sn).M;
        Params = UVS(sn).FitParams;
        Y2 = UVS(sn).FitAbs;
        Y3 = FC_Pure(Params,En,M);
        Y4 = UVS(sn).NormAbs;
        Y5 = Params(5).*UVS(UVS(sn).RefSpec).NormAbs;   % Amorphous spectrum
        
        plot(handles.axes1,X,Y2,'--g',X,Y3,'--b',X,Y4,'-k',X,Y5,'--r')
            
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