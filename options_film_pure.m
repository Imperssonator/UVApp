function options = options_film_pure()

options = struct();

options.specType = 'film';   % Type of spectra
options.RefName = 'default';
options.trimRange = [375, 700];
options.baselineRange = 700;
options.amor = 'none';     % What type of amorphous spectrum to fit
options.E00tol = 0.2;       % tolerance for the position of E00
options.GEtol = 0.14;

% Fitting parameters, initial
options.iE00 = 2;
options.iEB = 0;
options.iFCwid = 0.04;
options.iAggFrac = 0.6;
options.iS = 0.9;

% Fitting parameters, initial (amorphous Gaussian)
options.iGE = 2.6;          % initial energy of amorphous gaussian
options.iGsig = 0.23;        % initial width of amorphous gaussian

% Fitting parameters, constraints
options.fitRange = [558, 660];
options.limE00 = [options.iE00-options.E00tol,...
                    options.iE00+options.E00tol];
options.limGE = [options.iGE-options.GEtol,...
                    options.iGE+options.GEtol];
options.limEB = [-0.5, 0.5];
options.limFCwid = [0, 0.3];
options.limAggFrac = [0, 1];
options.limGsig = [0, 0.4];
options.limS = [0.9, 0.9];

% Fitting parameters, misc.
options.M = 4;

% For Dichroic Ratio Calc.
options.wavelength00 = 613;

