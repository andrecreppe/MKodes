clear all
close all

%{ EXERCÍCIO 1 - PARTE 1 %}

%% Dados do Problema

q0 = 15; qi = 5; qf = -16;
tf1 = 2; tf2 = 3;

%% Sistema de 8 Coeficientes

A = [1,0,0,0,0,0,0,0;
     1,tf1,tf1^2,tf1^3,0,0,0,0;
     0,0,0,0,1,0,0,0;
     0,0,0,0,1,tf2,tf2^2,tf2^3;
     0,1,0,0,0,0,0,0;
     0,0,0,0,0,1,2*tf2,3*tf2^2;
     0,0,2*tf1,3*tf1^2,0,-1,0,0;
     0,0,2,6*tf1,0,0,-2,0];

B = [q0;qi;qi;qf;0;0;0;0];

x = A\B

a10 = x(1);
a11 = x(2);
a12 = x(3);
a13 = x(4);
a20 = x(5);
a21 = x(6);
a22 = x(7);
a23 = x(8);

%% Plot dos Resultados

t1 = 0 : 0.01 : tf1;
pos1 = a10+a11*t1+a12*t1.^2+a13*t1.^3;
vel1 = a11+2*a12*t1+3*a13*t1.^2;
acc1 = 2*a12+6*a13*t1;

t2 = tf1 : 0.01 : (tf1+tf2);
pos2 = a20+a21*(t2-2)+a22*(t2-2).^2+a23*(t2-2).^3;
vel2 = a21+2*a22*(t2-2)+3*a23*(t2-2).^2;
acc2 = 2*a22+6*a23*(t2-2);

% Maior velocidade
vel_max = max(max(abs(vel1), max(abs(vel2))))

% Plot das trajetórias
figure()
subplot(1,3,1)
plot(t1,pos1,'b'); hold on;
plot(t2,pos2,'b'); hold on;
plot([0 2 5],[15 5 -16],'ro'); grid on;
title('Position'); xlabel('t [s]'); ylabel ('\theta [\circ]')
subplot(1,3,2)
plot(t1,vel1,'b'); hold on;
plot(t2,vel2,'b'); grid on;
title('Velocity'); xlabel('t [s]'); ylabel ('\theta vel [\circ/s]')
subplot(1,3,3)
plot(t1,acc1,'b'); hold on;
plot(t2,acc2,'b'); grid on;
title('Acceleration'); xlabel('t [s]'); ylabel ('\theta acc [\circ/s^2]')
