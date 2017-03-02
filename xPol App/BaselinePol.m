function UVS = BaselinePol(UVS,options)

[b00_waves,b00_abs] = wav2mat('Blanks/p00.wav');
[b90_waves,b90_abs] = wav2mat('Blanks/p90.wav');

switch options.blank
    
    case '90' % Blanked on 90
        
        % Add the b90 absorbance to p00 (p(1)),
        % then substract the b00 absorbance
        
        for i = 1:length(UVS)
            UVS(i).p(1).BlankAbs = UVS(i).p(1).RawAbs ...
                                 + b90_abs ...
                                 - b00_abs;
            UVS(i).p(2).BlankAbs = UVS(i).p(2).RawAbs;
        end
        
    case '0' % Blanked on 0

        % Add the b00 absorbance to p90 (p(2)),
        % then substract the b90 absorbance
        
        for i = 1:length(UVS)
            UVS(i).p(1).BlankAbs = UVS(i).p(1).RawAbs;
            UVS(i).p(2).BlankAbs = UVS(i).p(2).RawAbs ...
                                 + b00_abs ...
                                 - b90_abs;
        end
        
    case 'both' % Both blanked
        
        for i = 1:length(UVS)
            UVS(i).p(1).BlankAbs = UVS(i).p(1).RawAbs;
            UVS(i).p(2).BlankAbs = UVS(i).p(2).RawAbs;
        end
        
    case 'neither' % Neither blanked
        
        % Subtract the proper blank file from both
        
        for i = 1:length(UVS)
            UVS(i).p(1).BlankAbs = UVS(i).p(1).RawAbs ...
                                 - b00_abs;
            UVS(i).p(2).BlankAbs = UVS(i).p(2).RawAbs ...
                                 - b90_abs;
        end

end

end

