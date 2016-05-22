figure
hold on
for i=1:length(UVS)
    plot(UVS(i).TrimWaves, UVS(i).NormAbs)
    LegendName{i}=UVS(i).Name
    
end
legend(LegendName)
