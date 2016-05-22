function [EB,FitParams, RESNORM, RESIDUAL] = MikeFitFCPure(Waves,Abs,Low, Up, M, N)

%FitFC Frank-Condon fit for UV-Vis spectra
%   StructPath is the file path of the UV-Vis structure
%   The function will fit a mixed Frank-Condon function + amorphous peak to
%   yield:
%   Exciton Bandwith (UVS(run).EB) and
%   Percent Aggregates (UVS(run).AggFrac), as well as
%   The Frank-Condon fit structure (UVS(run).FCFit)

hc = 1239.842;              % eV*nm
Weights = MakeWeights(Waves, Low, Up);


Problem = struct();

InitParams = [2.0 ...   Energy of 0-0 peak in eV
              .20 ...  Exciton bandwidth in eV
              0.04 ... Peak width of FC Peaks
              0.1 ...   Relative Contribution of FC peaks
              1 ];     

[LB,UB] = MakeBounds(InitParams);
OPTIONS = optimoptions('lsqcurvefit', 'Display', 'off');
En = hc./Waves;

Problem.objective = @(Params,En) Weights.*MikeFrankConAgg(Params,En,M,N);
Problem.x0 = InitParams;
Problem.xdata = En;
Problem.ydata = Weights.*Abs;
Problem.lb = LB;
Problem.ub = UB;
Problem.solver = 'lsqcurvefit';
Problem.options = OPTIONS;

[FitParams,RESNORM,RESIDUAL] = lsqcurvefit(Problem);

EB = FitParams(2);

% figure
% hold on

% FitAbs = MikeFrankConAgg(FitParams,En,M);
% plot(Waves,Abs,'-k',Waves,FitAbs,'--b')

end

function [LB, UB] = MakeBounds(InitParams)

B = [];

WaveTol = 0.1; % Only allow Gaussians to shift 0.1 eV in either direction from initial guess

B(1,:) = [InitParams(1)-WaveTol, InitParams(1)+WaveTol];
B(2,:) = [0, 0.5];
B(3,:) = [0, Inf];
B(4,:) = [0, Inf];
B(5,:) = [0, Inf];

LB = B(:,1); UB = B(:,2);

end

function Weights = MakeWeights(Waves, Low, Up)

% Only fit FC from 475 nm to 650 nm

Lower = Waves>Low;
Upper = Waves<Up;
Weights = Lower&Upper;

end



