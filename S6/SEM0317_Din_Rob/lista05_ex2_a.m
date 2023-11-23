clear all
close all
clc

%% Denavit-Hartenberg

syms d1 d2 th3 real

A01 = transfMatrix(0, d1, -pi/2, 0)
A12 = transfMatrix(-pi/2, d2, -pi/2, 0)
A23 = transfMatrix(th3, 0, 0, 10)

A03 = A01 * A12 * A23

%% Sistema - Junta 1 (Prismatica)

q0 = 22; qi = 15; qf = 15;
tf1 = 7; tf2 = 5;

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

t1 = 0 : 0.01 : tf1;
pos1 = a10+a11*t1+a12*t1.^2+a13*t1.^3;
vel1 = a11+2*a12*t1+3*a13*t1.^2;
acc1 = 2*a12+6*a13*t1;

t2 = tf1 : 0.01 : (tf1+tf2);
pos2 = a20+a21*(t2-tf1)+a22*(t2-tf1).^2+a23*(t2-tf1).^3;
vel2 = a21+2*a22*(t2-tf1)+3*a23*(t2-tf1).^2;
acc2 = 2*a22+6*a23*(t2-tf1);

vmax_1 = max(max(abs(vel1)), max(abs(vel2)))

% Plot das trajetórias
figure()
subplot(1,3,1)
plot(t1,pos1,'b'); hold on;
plot(t2,pos2,'b'); hold on;
plot([0 7 12],[22 15 15],'ro'); grid on;
title('Position J1'); xlabel('t [s]'); ylabel ('\theta [\circ]')
subplot(1,3,2)
plot(t1,vel1,'b'); hold on;
plot(t2,vel2,'b'); grid on;
title('Velocity J1'); xlabel('t [s]'); ylabel ('\theta vel [\circ/s]')
subplot(1,3,3)
plot(t1,acc1,'b'); hold on;
plot(t2,acc2,'b'); grid on;
title('Acceleration J1'); xlabel('t [s]'); ylabel ('\theta acc[\circ/s^2]')

%% Sistema - Junta 2 (Prismatica)

q0 = 20; qi = 35; qf = 30;

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

pos1 = a10+a11*t1+a12*t1.^2+a13*t1.^3;
vel1 = a11+2*a12*t1+3*a13*t1.^2;
acc1 = 2*a12+6*a13*t1;

pos2 = a20+a21*(t2-tf1)+a22*(t2-tf1).^2+a23*(t2-tf1).^3;
vel2 = a21+2*a22*(t2-tf1)+3*a23*(t2-tf1).^2;
acc2 = 2*a22+6*a23*(t2-tf1);

vmax_2 = max(max(abs(vel1)), max(abs(vel2)))

% Plot das trajetórias
figure()
subplot(1,3,1)
plot(t1,pos1,'b'); hold on;
plot(t2,pos2,'b'); hold on;
plot([0 7 12],[20 35 30],'ro'); grid on;
title('Position J2'); xlabel('t [s]'); ylabel ('\theta [\circ]')
subplot(1,3,2)
plot(t1,vel1,'b'); hold on;
plot(t2,vel2,'b'); grid on;
title('Velocity J2'); xlabel('t [s]'); ylabel ('\theta vel [\circ/s]')
subplot(1,3,3)
plot(t1,acc1,'b'); hold on;
plot(t2,acc2,'b'); grid on;
title('Acceleration J2'); xlabel('t [s]'); ylabel ('\theta acc[\circ/s^2]')

%% Sistema - Junta 3 (Rotacional)

q0 = 30; qi = 60; qf = 45;

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

pos1 = a10+a11*t1+a12*t1.^2+a13*t1.^3;
vel1 = a11+2*a12*t1+3*a13*t1.^2;
acc1 = 2*a12+6*a13*t1;

pos2 = a20+a21*(t2-tf1)+a22*(t2-tf1).^2+a23*(t2-tf1).^3;
vel2 = a21+2*a22*(t2-tf1)+3*a23*(t2-tf1).^2;
acc2 = 2*a22+6*a23*(t2-tf1);

vmax_3 = max(max(abs(vel1)), max(abs(vel2)))

% Plot das trajetórias
figure()
subplot(1,3,1)
plot(t1,pos1,'b'); hold on;
plot(t2,pos2,'b'); hold on;
plot([0 7 12],[30 60 45],'ro'); grid on;
title('Position J3'); xlabel('t [s]'); ylabel ('\theta [\circ]')
subplot(1,3,2)
plot(t1,vel1,'b'); hold on;
plot(t2,vel2,'b'); grid on;
title('Velocity J3'); xlabel('t [s]'); ylabel ('\theta vel [\circ/s]')
subplot(1,3,3)
plot(t1,acc1,'b'); hold on;
plot(t2,acc2,'b'); grid on;
title('Acceleration J3'); xlabel('t [s]'); ylabel ('\theta acc[\circ/s^2]')
