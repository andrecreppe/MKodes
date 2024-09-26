clear all; close all;
clc;

ra = 3.15;
ka = 0.156;
La = 6.6e-3;
Bm = 0.1e-3;
J = 0.2e-3;

ua = 60;
%Tl = 1;
Tl = 0;
x10 = 0;
x20 = 0;

% Estados
% x = [i; omega]
% u = [ua; Tl];

A = [-ra/La  -ka/La;
     ka/J    -Bm/J];
B = [1/La    0;
     0      -1/J];
C = [0 1];
D = [0];

x0 = [x10 x20];
t = 0:0.001:0.25;

u = [ua*ones(size(t)); Tl*ones(size(t))];

[y, x] = lsim(A,B,C,D,u,t,x0);

figure
subplot(2,1,1)
plot(t, x(:,1), 'r')
title('Corrente, ia (A)')
grid on
subplot(2,1,2)
plot(t, x(:,2))
title('Velocidade Angular, omega_r (rad/s)')
grid on
