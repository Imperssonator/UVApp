function []=CorrectBaseline(StructPath)

%This function corrects the UV-Vis curves so that the tail ends all end at
%zero. A consistant wavelength number is selected and used to correct all
%sample. 

WaitPoint=700; %Reference location for all corrections

load(StructPath);

for i=1:length(UVS)
    
    index=find(UVS(i).TrimWaves==WaitPoint);
    delta=0-UVS(i).TrimAbs(index);

    UVS(i).BaseABs=UVS(i).TrimAbs+delta;
    UVS(i).TrimAbs=UVS(i).BaseABs;

end
save(StructPath, 'UVS')

end