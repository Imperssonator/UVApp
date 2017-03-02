function UVS = CalcDC(UVS,options)

for i = 1:length(UVS)
    
    calc_ind = find(UVS(i).p(1).Waves == options.wavelength00,1);
    UVS(i).DC = UVS(i).p(2).BlankAbs(calc_ind) ...
              / UVS(i).p(1).BlankAbs(calc_ind);
          
end

end

