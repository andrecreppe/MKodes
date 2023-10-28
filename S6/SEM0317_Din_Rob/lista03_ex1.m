clc
clear all
close all

% ========== Ex 1 ==========

syms th1 th2 th3 th4 real
L = 1; % m

% Denavit-Hartenberg
A01 = [cos(sym(th1)) 0 sin(sym(th1)) 0;
       sin(sym(th1)) 0 -cos(sym(th1)) 0;
       0 1 0 0;
       0 0 0 1];

A12 = [cos(sym(th2)) 0 sin(sym(th2)) 0;
       sin(sym(th2)) 0 -cos(sym(th2)) 0;
       0 1 0 0;
       0 0 0 1];

A23 = [cos(sym(th3)) 0 sin(sym(th3)) 0;
       sin(sym(th3)) 0 -cos(sym(th3)) 0;
       0 1 0 L;
       0 0 0 1];

A34 = [cos(sym(th4)) -sin(sym(th4)) 0 L*cos(sym(th4));
       sin(sym(th4)) cos(sym(th4)) 0 L*sin(sym(th4));
       0 0 1 0;
       0 0 0 1];

A02 = A01 * A12;
A03 = A02 * A23;
A04 = A03 * A34;

% Rotacao e Posicao
R01 = A01(1:3, 1:3);    r01 = A01(1:3, 4);
R12 = A12(1:3, 1:3);    r12 = A12(1:3, 4);
R23 = A23(1:3, 1:3);    r23 = A23(1:3, 4);
R34 = A34(1:3, 1:3);    r34 = A34(1:3, 4);

r02 = A02(1:3, 4);
r03 = A03(1:3, 4);

r0e = A04(1:3, 4);

% Juntas
v001 = [0 0 1]';

R02 = simplify(R01 * R12);
R03 = simplify(R02 * R23);

r1e = simplify(r0e - r01);
r2e = simplify(r0e - r02);
r3e = simplify(r0e - r03);

b0 = v001;
b1 = R01 * v001;
b2 = R02 * v001;
b3 = R03 * v001;

J_A1 = b0;
J_A2 = b1;
J_A3 = b2;
J_A4 = b3;

J_L1 = simplify(cross(b0, r0e));
J_L2 = simplify(cross(b1, r1e));
J_L3 = simplify(cross(b2, r2e));
J_L4 = simplify(cross(b3, r3e));

J = [J_L1 J_L2 J_L3 J_L4;
     J_A1 J_A2 J_A3 J_A4];

q = [0 3*pi/5 pi 3*pi/5];
J_q = simplify(subs(J, [th1 th2 th3 th4], q));

q1 = [0 3*pi/4 pi pi];
J_q1 = simplify(subs(J, [th1 th2 th3 th4], q1));
v_omega = J_q1 * q1';
% v_omega = [0 0 -L 0 -sqrt(2)/2 0]';
