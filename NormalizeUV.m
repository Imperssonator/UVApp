function UVS = NormalizeUV(UVS)

%NormalizeUV Normalize UV Spectra Set
%   Normalize to the maximum point

for j = 1:length(UVS)
    [~, NormInd] = max(UVS(j).TrimAbs); % This is the index of the jth spectra corresponding to the wavelength to be normalized
    UVS(j).NormAbs = UVS(j).TrimAbs ./ UVS(j).TrimAbs(NormInd);
end

end

