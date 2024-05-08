function [xd]=ode_mmafmh(t,x,m,c,k,pv,Wv)
pt=pv.*sin(Wv*t); pt=sum(pt')';
xd=[x(2); -c/m*x(2)-k/m*x(1)+pt/m];
