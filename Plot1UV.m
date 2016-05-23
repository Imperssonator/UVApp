function [] = Plot1UV(StructPath,i)

load(StructPath)

figure
hold on
plot(UVS(i).TrimWaves,UVS(i).NormAbs,'-')

end