function [] = BaselineUV(StructPath,options)

load(StructPath);

for i = 1:length(UVS)
    UVS(i).BaseAbs = baselineCorrect(UVS(i).Waves,UVS(i).RawAbs,options.baselineRange);
end

save(StructPath,'UVS')

end

