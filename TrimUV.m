function [] = TrimUV(StructPath,options)

load(StructPath);
tr = options.trimRange;

for i = 1:length(UVS)
    BaseAbsi = UVS(i).BaseAbs;
    RawWavesi = UVS(i).Waves;
    TrimLow = find(RawWavesi==tr(1));
    TrimHigh = find(RawWavesi==tr(2));
    
    TrimWavesi = RawWavesi(TrimLow:TrimHigh);
    TrimAbsi = BaseAbsi(TrimLow:TrimHigh);
    
    UVS(i).TrimAbs = TrimAbsi;
    UVS(i).TrimWaves = TrimWavesi;
end

save(StructPath,'UVS')

end

