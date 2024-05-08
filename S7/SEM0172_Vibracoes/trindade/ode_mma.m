function [xd]=ode_mma(t,x,m,c,k)
xd=[x(2); -c/m*x(2)-k/m*x(1)];
