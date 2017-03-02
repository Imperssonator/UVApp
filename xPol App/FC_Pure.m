function out = FC_Pure(Params,En,M)

% Params = ...
%    1: Energy of 0-0 peak in eV
%    2: Exciton bandwidth in eV
%    3: Peak width of FC Peaks
%    4: Aggregate Fraction
%    5: S, the Huang-Rhys factor

out = Params(4).*FCAgg(Params,En,M);

end