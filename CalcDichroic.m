function UVS = CalcDichroic(UVS,options)

for i = 1:length(UVS)
    
    p_ind = regexp(UVS(i).Name,'[\p]');
    last_p = p_ind(end);
    ind_00 = find(UVS(i).TrimWaves==options.wavelength00,1);
    
    switch UVS(i).Name(last_p+1:last_p+2)
        case '90'
    end
    
end