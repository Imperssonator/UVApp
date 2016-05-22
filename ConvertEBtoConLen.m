for i=1:length(A)

    EB=A(i,1)
Results(i)=fsolve(@(x)EBtoLen(x,EB), 20);



end