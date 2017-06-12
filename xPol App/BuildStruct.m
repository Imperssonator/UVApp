function UVS = BuildStruct(Directory)

hread = waitbar(0,'Reading Files...');

UVS = struct();

NumFiles = length(Directory);

count = 0;
for i = 1:NumFiles
    
    waitbar(i/NumFiles,hread);
    FilePath = Directory{i,1};
    
    switch lower(FilePath(end-2:end))
        
        case 'wav'
            [Waves,RawAbs] = wav2mat(FilePath);
        case 'csv'
            [Waves,RawAbs] = csv2mat(FilePath);
            
    end
    
    if Waves == 0
        
    else
        
        count = count+1;
        UVS(count).Waves = Waves;
        UVS(count).RawAbs = RawAbs;
        UVS(count).FilePath = FilePath;
        
        SlashInd = regexp(FilePath,'[\\/]');
        LastSlash = SlashInd(end);
        SpecName = FilePath(LastSlash+1:end-4);
        
        UVS(count).Name = SpecName;
        Folder = FilePath(1:LastSlash);
        
    end
end

save('UVS0','UVS')

close(hread)

end