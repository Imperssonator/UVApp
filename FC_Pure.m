function out = FC_Pure(Params,En,M)

% Params = ...
%    1: Energy of 0-0 peak in eV
%    2: Exciton bandwidth in eV
%    3: Peak width of FC Peaks
%    4: Aggregate Fraction
%    5: Amorphous Peak Center
%    6: Amorhpous Peak Width

GaussParams = [0, Params(5), Params(6)];

out = Params(4).*FCAgg(Params(1:3),En,M); %+...
%     GaussPeak(GaussParams,1,En);

end