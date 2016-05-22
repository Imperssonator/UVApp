List1=[1,2,10,22,28,29,3,4,5,6,11,12,16,17,18,23,24]
List2=[7,8,9,13,14,15,19,20,21,25,26,27]

for i=1:length(List1)
    Ordered(i)=UVS(List1(i))
end

for i=19:(19+length(List2))
    Ordered(i)=UVS(List2(i-18))
end