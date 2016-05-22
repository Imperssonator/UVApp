figure
hold on

scatter(Time, PureEB37)
scatter(Time, PureEB58)
scatter(Time, PureEB90)

xlabel('Time')
ylabel('EB')
legend('37', '58', '90')

figure
hold on

scatter(Time, AggFrac37)
scatter(Time, AggFrac58)
scatter(Time, AggFrac90)

xlabel('Time')
ylabel('AggFrac')
legend('37', '58', '90')