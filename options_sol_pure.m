function options = options_sol_pure()

options = struct();

options.specType = 'sol';   % Type of spectra
options.RefName = 'default';
options.trimRange = [375, 700];
options.baselineRange = 700;
options.amor = 'none';     % What type of amorphous spectrum to fit
options.E00tol = 0.1;       % tolerance for the position of E00

% Fitting parameters, initial
options.iE00 = 2;
options.iEB = 0.2;
options.iFCwid = 0.04;
options.iAggFrac = 0.6;

% Fitting parameters, constraints
options.fitRange = [550, 650];
options.limE00 = [options.iE00-options.E00tol,...
                    options.iE00+options.E00tol];
options.limGE = [options.iGE-options.GEtol,...
                    options.iGE+options.GEtol];
options.limEB = [0, 0.5];
options.limFCwid = [0, 0.2];
options.limAggFrac = [0, 1];

% Fitting parameters, misc.
options.M = 4;

