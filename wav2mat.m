function [Waves,RawAbs,Num] = wav2mat(FilePath)

%% csv2mat
% CSV2MAT takes a filepath (starting from the current matlab active
% directory) to a UV-Vis .csv file, and parses it to obtain:

% Waves: A column vector of wavelengths
% RawAbs: A column vector of the raw absorbance values

%% Open file and read in data as strings

Waves = 0;
RawAbs = 0;

% disp(FilePath)
fid = fopen(FilePath);
if fid==-1
    disp('File does not exist')
    return
end

Num = textscan(fid,'%s%s','Delimiter',',');
fclose(fid);
Num = {cellfun(@strfix,Num{1},'UniformOutput',false), cellfun(@strfix,Num{2},'UniformOutput',false)};

% disp(Num)
Waves = (str2num(Num{1}{13}):str2num(Num{2}{13}))';
RawAbs = cellfun(@(x) str2num(x),Num{1}(14:14+length(Waves)-1),'UniformOutput',false);
RawAbs = cell2mat(RawAbs);

save('wav_debug')

end

function out = strfix(str)

if ~ischar(str)
    out = str;
    return
end

out = '';
for i = 1:length(str)
    if ~isempty(str2num(str(i))) || strcmp(str(i),'.') || strcmp(str(i),'-')
        out = [out, str(i)];
    end
end

end