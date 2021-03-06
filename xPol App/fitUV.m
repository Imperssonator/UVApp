function UVS = fitUV(UVS,options)


for i = 1:length(UVS)
    disp(UVS(i).Name)
    % Convert wavelengths to Energies
    hc = 1239.842;              % eV*nm
    UVS(i).TrimEn = hc./UVS(i).TrimWaves;
    
    % Trim En and Abs down to the fit range
    
    % fitRange is specified as:
    %   [Range 1 lower, Range 1 upper;...
    %    Range 2 lower, range 2 upper];
    
    fit_weights = MultiEquiv(UVS(i).TrimWaves,options.fitWaves);
%     fit_weights = ( UVS(i).TrimWaves > options.fitRange(1) &...
%                     UVS(i).TrimWaves < options.fitRange(2) )...
%                   |...
%                   ( UVS(i).TrimWaves > options.fitRange(3) &...
%                     UVS(i).TrimWaves < options.fitRange(4) );
    
    fit_inds = find(fit_weights);
    disp(UVS(i).TrimWaves(fit_inds))
    
    FitEn = UVS(i).TrimEn(fit_inds);
    FitAbs = UVS(i).NormAbs(fit_inds);
    
    switch lower(options.amor)
        case 'gauss'
            
            disp('fitting FC_Gauss')
            
            % Build initial parameters
            UVS(i).ParamNames = {'E00', 'EB', 'FCwid', 'AggFrac', 'Gauss E', 'Gauss sig'};
            initParams = [options.iE00, ...
                        options.iEB, ...
                        options.iFCwid, ...
                        options.iAggFrac, ...
                        options.iGE, ...
                        options.iGsig];

            Bounds =     [options.limE00; ...
                        options.limEB; ...
                        options.limFCwid; ...
                        options.limAggFrac; ...
                        options.limGE; ...
                        options.limGsig];
            
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
            
            disp('fitting FC_Spec')
            
            % Build initial parameters
            UVS(i).ParamNames = {'E00', 'EB', 'FCwid', 'AggFrac', 'Total Scale'};
            initParams = [options.iE00, ...
                        options.iEB, ...
                        options.iFCwid, ...
                        options.iAggFrac, ...
                        options.iScale];

            Bounds =     [options.limE00; ...
                        options.limEB; ...
                        options.limFCwid; ...
                        options.limAggFrac; ...
                        options.limScale];
            
            % Build optimization problem
            Problem = struct();
            fit_opts = optimoptions('lsqcurvefit');
            Problem.options = fit_opts;
            Problem.objective = ...
                @(Params,En) FC_Spec(Params,En,options.M, ...
                                        UVS(UVS(i).RefSpec).NormAbs(fit_inds(1):fit_inds(2)));
            Problem.x0 = initParams;
            Problem.LB = Bounds(:,1)';
            Problem.UB = Bounds(:,2)';
            Problem.xdata = FitEn;
            Problem.ydata = FitAbs;
            Problem.solver = 'lsqcurvefit';
            Problem.Algorithm = 'trust-region-reflective';
            [FitParams,Resnorm,Residual] = lsqcurvefit(Problem);
            
            % Generate the fit spectrum
            UVS(i).FitAbs = FC_Spec(FitParams,UVS(i).TrimEn,options.M, ...
                                      UVS(UVS(i).RefSpec).NormAbs);
            UVS(i).FitParams = FitParams;
            UVS(i).EB = FitParams(2);
            UVS(i).AggFrac = FitParams(4);
            UVS(i).M = options.M;
            
        case 'none'
            
            disp('fitting FC_Pure')
            
            % Build initial parameters
            UVS(i).ParamNames = {'E00', 'EB', 'FCwid', 'AggFrac', 'S'};
            initParams = [options.iE00, ...
                        options.iEB, ...
                        options.iFCwid, ...
                        options.iAggFrac, ...
                        options.iS];
            
            Bounds =     [options.limE00; ...
                        options.limEB; ...
                        options.limFCwid; ...
                        options.limAggFrac; ...
                        options.limS];
            
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
            Problem.Algorithm = 'trust-region-reflective';
            Problem.TolFun = 1e-8;
            [FitParams,Resnorm,Residual] = lsqcurvefit(Problem);
            
            % Generate the fit spectrum
            UVS(i).FitAbs = FC_Pure(FitParams,UVS(i).TrimEn,options.M); % Fit aggregate absorbance
            UVS(i).FitAmor = UVS(i).NormAbs - UVS(i).FitAbs;    % Total raw absorbance minus fit aggregate absorbance
            UVS(i).FitParams = FitParams;
            UVS(i).EB = FitParams(2);
            AggArea = trapz(UVS(i).TrimWaves,UVS(i).FitAbs);
            AmorArea = trapz(UVS(i).TrimWaves,UVS(i).FitAmor);
            UVS(i).AggFrac = 100 * AggArea / ( 1.39*AmorArea + AggArea);    % Aggregated chains absorb 1.39x stronger than amorphous
            UVS(i).M = options.M;
            UVS(i).S = FitParams(5);
    end
    
end

end