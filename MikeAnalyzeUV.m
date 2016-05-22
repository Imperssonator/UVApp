function StructPath = MikeAnalyzeUV(FolderName,RefName)

% Run with this line:
% FN = 'UV Vis 150630'; RefName = '0PRE'; SP = AnalyzeUV(FN,RefName); load(SP);

Directory = BuildDirectory(FolderName);
StructPath = BuildStruct(Directory);
TrimUV(StructPath);
CorrectBaseline(StructPath);
NormalizeUV(StructPath,RefName)
 PlotAllUV(StructPath);

% InitParams = [20;  ...  Gaussian Areas
%               510; ...  Gaussian Averages
%               10;  ...  Gaussian Width
%               
%               20;  ...  0-1 Peak
%               570;
%               10;
%               
%               20;  ...  0-0 Peak
%               620;
%               10;
%               
%               1];  ...  Amorhpous Contrib.
% % 
% InitParams = [
%               20;  ...  Gaussian Areas
%               510; ...  Gaussian Averages
%               10;  ...  Gaussian Width
%               
%               20;  ...  0-1 Peak
%               570;
%               10;
%               
%               20;  ...  0-0 Peak
%               600;
%               10;
%               
%               20;  ...  
%               430;
%               10;
%               
%               1];  ...  Amorhpous Contrib.
% 
%  FitGauss(StructPath,InitParams)
%  GMExcitonBW(StructPath);
    M = 3; % M+1=Number of peaks to include in the aggregate FC portion
    N= 10;
% MikeFitFC(StructPath, M, N);
MikeFitFCAgg(StructPath, M, N);

% PlotEB(StructPath);
% MikePlotFCFit(StructPath,1);
% PlotGMFit(StructPath,20);

end