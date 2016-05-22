function F=EBtoLen(x, EB)
m=1;
d=1.1;
c=10-7.4*d;


F(1)=2*x*m^2/d^3*(1/(1+2*(x*m)^2/(c*d^3)))-EB;


end