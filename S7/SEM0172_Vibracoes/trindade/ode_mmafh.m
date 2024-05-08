function [xd]=ode_mmafh(t,x,m,c,k,p0,W)
xd=[x(2); -c/m*x(2)-k/m*x(1)+p0/m*cos(W*t)];
