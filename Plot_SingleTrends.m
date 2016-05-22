
for i=1:length(UVS)
   PureEB(i)=UVS(i).PureEB
   AggFrac(i)=UVS(i).AggFrac
end

figure
hold on
scatter(Time, PureEB)
xlabel('Time')
ylabel('EB')

figure
hold on

scatter(Time, AggFrac)
xlabel('Time')
ylabel('AggFrac')
