function out = FCAgg(Params,En,M)

% Params = ...
%    1: Energy of 0-0 peak in eV
%    2: Exciton bandwidth in eV
%    3: Peak width of FC Peaks

% Hard coded physical parameters
% S = 1;       % Huang Rhys Factor ....
Ep = 0.18;      % 0.18 eV C=C symmetric stretch
N = (0:M);
E00 = Params(1);            % Convert to Energy
EB = Params(2);
FCwid = Params(3);
S = Params(5);

out = zeros(length(En),1);

for m = 0:M
    
    Avg = E00+m*Ep+0.5*EB*S^m*exp(-S);
    Nm = N(N~=m);
    Gm = sum(S.^Nm ./ (factorial(Nm) .* (Nm - m)));
    GaussParams = [1; Avg; FCwid];
    out = out + S^m/factorial(m) ...
              * (1 - EB*exp(-S)/(2*Ep) * Gm)^2 ...
              * GaussPeak(GaussParams,1,En);
end

end
