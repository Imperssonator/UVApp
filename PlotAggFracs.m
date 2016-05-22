%Plot AggFracs

hold on

scatter(numbers(1:5), SOLAggFrac(1:5),10, 'b')
scatter(numbers(6:10), SOLAggFrac(6:10),10, 'k')
scatter(numbers(11:15), SOLAggFrac(11:15),10, 'm')
scatter(numbers(16:20), SOLAggFrac(16:20),10, 'r')

SOLAve=mean(SOLAggFrac)
SOLAveVec=SOLAve*ones(1,length(SOLAggFrac))

plot(numbers, SOLAveVec)

scatter(numbers(1:5), FILMAggFrac(1:5),20, 'b')
scatter(numbers(6:10), FILMAggFrac(6:10),20, 'k')
scatter(numbers(11:15), FILMAggFrac(11:15),20, 'm')
scatter(numbers(16:20), FILMAggFrac(16:20),20, 'r')

FILMAve=mean(FILMAggFrac)
FILMAveVec=FILMAve*ones(1,length(FILMAggFrac))

plot(numbers, FILMAveVec)