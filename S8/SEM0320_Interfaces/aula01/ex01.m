close all; clear all;
clc

x = 0 : 0.025*pi : 3*pi;
y1 = sin(2*x);
y2 = sin(2*x) .* cos(2*x);
y3 = sin(2*x) .* exp(-x./2);

figure()
subplot(311)
plot(x, y1, '-o');

subplot(312)
plot(x, y2, '-x');

subplot(313)
plot(x, y3, '--');
