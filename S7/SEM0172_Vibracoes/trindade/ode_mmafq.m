function [xd]=ode_mmafq(t,x,m,c,k,z0,W)
if t<pi/W pt=k*z0*sin(W*t)+c*z0*W*cos(W*t); else pt=0; end
xd=[x(2); -c/m*x(2)-k/m*x(1)+pt/m];
