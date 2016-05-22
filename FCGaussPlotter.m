
M=4
for j=0:1:M


hc = 1239.842; 
Waves = hc./UVS(1).TrimWaves;




    area = Gauss(1,j+1);  % area of this underlying peak
    avg = Gauss(2,j+1);  % peak wavelength
    sig = Gauss(3,j+1);  % width of gaussian
    EB=Gauss(4,j+1);
    m=Gauss(5,j+1);
    S=Gauss(6,j+1);
    Gi = area*1/(sig*(2*pi)^0.5) .*exp(-(Waves-avg-1/2*EB*S^m*exp(1)^-S).^2./(2*sig^2));
    out(j+1,:) = Gi;
end