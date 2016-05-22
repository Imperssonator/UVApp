hold on
for i=1:length(UVS)
   plot(UVS(i).Waves, UVS(i).RawAbs) 
    
end
xlabel('Wavelength (nm)')
ylabel('Absorbance')

legend('Chloroform', 'DCB', 'P-Xylene', 'THF', 'Toluene', 'TCB')