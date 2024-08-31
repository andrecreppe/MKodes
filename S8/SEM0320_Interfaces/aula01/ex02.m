close all; clear all;
clc

R = 0.5;
L = 1.0;
C = 2.0;
a = 1.0;
b = -1.0;
cf = 1;
e = R/2*L;
w0 = 1/sqrt(L*C);

t = 0 : 0.01 : 30;

x = exp(-e*t) .* (a*cos(sqrt(w0^2 - e^2) * t) ...
    + b*sin(sqrt(w0^2 - e^2) * t)) + cf;

figure()
plot(t, x);
xlabel('Time [s]'); ylabel('i(t) [A]');
