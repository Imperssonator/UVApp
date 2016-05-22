function out = GaussPeak(Params,k,Waves)

%GaussPeak Vectorized Gaussian Peak
%   out is a vector of the output of a mixture of Gaussians given the input
%   W, which is a vector of wavelengths.
%   k = number of Gaussian peaks
%   Params = [3 x k]:
%   [Peak area 1 ...  Peak area k;
%    Wavelength 1...  Wavelength k;
%    Peak width 1...  Peak width k]

out = 0;
Params = reshape(Params,length(Params),k);

for i = 1:k
    area = Params(1,i);  % area of this underlying peak
    avg = Params(2,i);  % peak wavelength
    sig = Params(3,i);  % width of gaussian
    EB=Params(4,i);
    m=Params(5,i);
    S=Params(6,i);
    Gi = area*1/(sig*(2*pi)^0.5) .*exp(-(Waves-avg-1/2*EB*S^m*exp(1)^-S).^2./(2*sig^2));
    out = out+Gi;
end

end