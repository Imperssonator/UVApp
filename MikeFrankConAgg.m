function out = MikeFrankConAgg(Params,En,M, N)


out = zeros(length(En),1);

E00 = Params(1);            % Convert to Energy
EB = Params(2);
FCwid = Params(3);
FCWeight = Params(4);


S =1.05; %Params(5);                      % Huang Rhys Factor ....
Ep = 0.18;                  % 0.18 eV C=C symmetric stretch
N = (0:N); %(0:M);

FCPeaks = zeros(length(En),1);

for m = 0:M
    
    Avg = E00+m*Ep;
    Nm = N(N~=m);
    Gm = sum(S.^Nm ./ (factorial(Nm) .* (Nm - m)));
    FCParams = [1; Avg; FCwid; EB; m; S];
%     disp(exp(-S)*S^m/factorial(m) * (1 - EB*exp(-S)/(2*Ep) * Gm)^2)
    FCPeaks = FCPeaks + exp(-S)*S^m/factorial(m) ...
              * (1 - EB*exp(-S)/(2*Ep) * Gm)^2 ...
              * MikeGaussPeak(FCParams,1,En);
          
          
end

out = FCWeight * FCPeaks;

end
