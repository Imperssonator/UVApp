function UVS = BaselineUV(UVS,options)

for i = 1:length(UVS)
    UVS(i).BaseAbs = baselineCorrect(UVS(i).Waves,UVS(i).RawAbs,options.baselineRange);
end

end

