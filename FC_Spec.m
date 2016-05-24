function out = FC_Spec(Params,En,M,NARef)

% Params = ...
%    1: Energy of 0-0 peak in eV
%    2: Exciton bandwidth in eV
%    3: Peak width of FC Peaks
%    4: Aggregate Fraction
%    5: Scaling factor for the amorphous fit

out = Params(4).*FCAgg(Params(1:3),En,M) +...
    Params(5).*NARef;

end