function fitUV(SP,options)

load(SP)

for i = 1:length(UVS)
    disp(UVS(i).Name)
    % Convert wavelengths to Energies
    hc = 1239.842;              % eV*nm
    UVS(i).TrimEn = hc./UVS(i).TrimWaves;
    
    % Trim En and Abs down to the fit range
    fit_ind = [find(UVS(i).TrimWaves==options.fitRange(1),1),...
        find(UVS(i).TrimWaves==options.fitRange(2),1)];
    FitEn = UVS(i).TrimEn(fit_ind(1):fit_ind(2));
    FitAbs = UVS(i).NormAbs(fit_ind(1):fit_ind(2));
    
    switch lower(options.amor)
        case 'gauss'
            
            disp('fitting FC_Gauss')
            % Build initial parameters
            initParams = [options.iE00, ...
                options.iEB, ...
                options.iFCwid, ...
                options.iAggFrac, ...
                options.iGE, ...
                options.iGsig];
            UVS(i).ParamNames = {'E00', 'EB', 'FCwid', 'AggFrac', 'Gauss E', 'Gauss sig'};

            Bounds =     [options.limE00; ...
                options.limEB; ...
                options.limFCwid; ...
                options.limAggFrac; ...
                options.limGE; ...
                options.limGsig];
            
            LB = Bounds(:,1)'; UB = Bounds(:,2)';
            
            % Build optimization problem
            Problem = struct();
            fit_opts = optimoptions('lsqcurvefit');
            Problem.options = fit_opts;
            Problem.objective = @(Params,En) FC_Gauss(Params,En,options.M);
            Problem.x0 = initParams;
            Problem.LB = Bounds(:,1)';
            Problem.UB = Bounds(:,2)';
            Problem.xdata = FitEn;
            Problem.ydata = FitAbs;
            Problem.solver = 'lsqcurvefit';
            Problem.Algorithm = 'levenberg-marquardt';
            [FitParams,Resnorm,Residual] = lsqcurvefit(Problem);
            
            % Generate the fit spectrum
            UVS(i).FitAbs = FC_Gauss(FitParams,UVS(i).TrimEn,options.M);
            UVS(i).FitParams = FitParams;
            UVS(i).EB = FitParams(2);
            UVS(i).AggFrac = FitParams(4);
            UVS(i).M = options.M;
            
        case 'spec'
            
        case 'none'
            
            disp('fitting FC_Pure')
            % Build initial parameters
            initParams = [options.iE00, ...
                options.iEB, ...
                options.iFCwid, ...
                options.iAggFrac, ...
                options.iGE, ...
                options.iGsig];
            UVS(i).ParamNames = {'E00', 'EB', 'FCwid', 'AggFrac', 'Unused', 'Unused'};
            
            Bounds =     [options.limE00; ...
                options.limEB; ...
                options.limFCwid; ...
                options.limAggFrac; ...
                options.limGE; ...
                options.limGsig];
            
            LB = Bounds(:,1)'; UB = Bounds(:,2)';
            
            % Build optimization problem
            Problem = struct();
            fit_opts = optimoptions('lsqcurvefit');
            Problem.options = fit_opts;
            Problem.objective = @(Params,En) FC_Pure(Params,En,options.M);
            Problem.x0 = initParams;
            Problem.LB = Bounds(:,1)';
            Problem.UB = Bounds(:,2)';
            Problem.xdata = FitEn;
            Problem.ydata = FitAbs;
            Problem.solver = 'lsqcurvefit';
            Problem.Algorithm = 'levenberg-marquardt';
            [FitParams,Resnorm,Residual] = lsqcurvefit(Problem);
            
            % Generate the fit spectrum
            UVS(i).FitAbs = FC_Pure(FitParams,UVS(i).TrimEn,options.M);
            UVS(i).FitParams = FitParams;
            UVS(i).EB = FitParams(2);
            UVS(i).AggFrac = sum(UVS(i).FitAbs)/sum(UVS(i).NormAbs);
            UVS(i).M = options.M;
    end
    
end

save(SP,'UVS')

end