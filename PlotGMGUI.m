function [X Y] = PlotGMFit(StructPath,run, flag)

load(StructPath);


X = UVS(run).TrimWaves;
Y1 = UVS(run).NormAbs;
Y2 = UVS(run).GMM.FitAbs;


Params = UVS(run).GMM.Params; % Pull out the Gaussian parameters
[p,~] = size(Params);
k = floor(p/3);

GMParams = reshape(Params(1:end-1),3,k);

for i = 1:k
    Yi = GaussPeak(GMParams(:,i),1,X);

end

Y=[Y1 Y2 Yi Params(end).*UVS(UVS(1).RefSpec).NormAbs];

if flag==1
    figure
    hold on
    plot(X,Y1,'-k',X,Y2,'-r');
    plot(X,Yi,'--b')
    plot(X,Params(end).*UVS(UVS(1).RefSpec).NormAbs,'--c') 
end
    


save(StructPath,'UVS')

end