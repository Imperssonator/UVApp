function UVS_pol = PolarStruct(UVS)

% First, find the polarization of each sample, store that, then remove the
% polarization from the names to help find matches

i=1;
while i<=length(UVS)
    
    p_loc = regexp(UVS(i).Name,'[pP]\d\d');
    
    if ~isempty(p_loc)
        
        UVS(i).p = str2num(UVS(i).Name(p_loc+1:p_loc+2));
        
        no_pol_split = regexp(UVS(i).Name,'[pP]\d\d','split');
        name_no_pol = [no_pol_split{:}];
        UVS(i).name_no_pol = name_no_pol;
        
        i=i+1;
        
    else
        
        UVS(i)=[];
        
    end
    
end

% Now, build a new structure where both p90 and p0 are part of the same
% element

UVS_pol = struct();

count = 0;

for i = 1:length(UVS)
    
    if isfield(UVS(i),'p')
        
        if UVS(i).p == 0
            
            count = count+1;
            
            % Store information about the p0 spectrum
            UVS_pol(count).Name=UVS(i).name_no_pol;
            UVS_pol(count).p(1).p=0;
            UVS_pol(count).p(1).Waves = UVS(i).Waves;
            UVS_pol(count).p(1).RawAbs = UVS(i).RawAbs;
            UVS_pol(count).p(1).FilePath = UVS(i).FilePath;
            UVS_pol(count).p(1).Name = UVS(i).Name;
            
            % Find the p90 pair in UVS
            matches=find(...
                         cellfun( @(x) strcmp(x,UVS(i).name_no_pol),...
                                  {UVS(:).name_no_pol}));
            pair_ind = matches(matches~=i);
            
                        UVS_pol(count).name=UVS(i).name_no_pol;
                        
            % Store all of its information
            UVS_pol(count).p(2).p=90;
            UVS_pol(count).p(2).Waves = UVS(pair_ind).Waves;
            UVS_pol(count).p(2).RawAbs = UVS(pair_ind).RawAbs;
            UVS_pol(count).p(2).FilePath = UVS(pair_ind).FilePath;
            UVS_pol(count).p(2).Name = UVS(pair_ind).Name;
            
        end
    end
end

save('polar_test','UVS_pol')
end
            
            
            