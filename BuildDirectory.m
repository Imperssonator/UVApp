function Directory = BuildDirectory(FolderName)

%% Build Directory
% Takes the name of a folder full of UV-Vis .csv files and a .xlsx directory
% and converts it to

% Directory: a cell array (Nx1) of strings that are the file paths of UV
% Vis csv files

% Input computer specfic pathway to the correct file
ad = pwd;
cd(FolderName)
D = dir('*.csv');
cd(ad)

FileNames = {D(:).name}';   % File names

NumFiles = length(FileNames);
Directory = {}; % File Paths

for i = 1:NumFiles
    Directory{i,1} = [FolderName FileNames{i,1}];
end

end