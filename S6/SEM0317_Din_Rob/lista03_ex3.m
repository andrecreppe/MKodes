clc
clear all
close all

% ========== Ex 1 ==========

syms q1 q2 q3 L1 L2 L3 real

% Denavit-Hartenberg
A01 = [cos(sym(q1)) 0 sin(sym(q1)) 0;
       sin(sym(q1)) 0 -cos(sym(q1)) 0;
       0 1 0 L1;
       0 0 0 1];

A12 = [cos(sym(q2)) -sin(sym(q2)) 0 L2*cos(sym(q2));
       sin(sym(q2)) cos(sym(q2)) 0 L2*sin(sym(q2));
       0 0 1 0;
       0 0 0 1];

A23 = [cos(sym(q3)) -sin(sym(q3)) 0 L3*cos(sym(q3));
       sin(sym(q3)) cos(sym(q3)) 0 L3*sin(sym(q3));
       0 0 1 0;
       0 0 0 1];

A02 = A01 * A12;
A03 = A02 * A23;

% Rotacao e Posicao
R01 = A01(1:3, 1:3);    r01 = A01(1:3, 4);
R12 = A12(1:3, 1:3);    r12 = A12(1:3, 4);
R23 = A23(1:3, 1:3);    r23 = A23(1:3, 4);

r02 = A02(1:3, 4);
r0e = A03(1:3, 4);

% Juntas
v001 = [0 0 1]';

R02 = simplify(R01 * R12);
R03 = simplify(R02 * R23);

r1e = simplify(r0e - r01);
r2e = simplify(r0e - r02);

b0 = v001;
b1 = R01 * v001;
b2 = R02 * v001;

J_A1 = b0;
J_A2 = b1;
J_A3 = b2;

J_L1 = simplify(cross(b0, r0e));
J_L2 = simplify(cross(b1, r1e));
J_L3 = simplify(cross(b2, r2e));

% a)
J = [J_L1 J_L2 J_L3;
     J_A1 J_A2 J_A3];

transf_0e = [R03        zeros(3,3);
             zeros(3,3) R03];
J_e = simplify(transf_0e * J);

lat_ans = latex(J_e);

% b)
q = [0 0 pi/9]; % rad
L = [1 0.5 0.3]; % m
dot_q = [1 1 1]'; % rad/s

J_num = simplify(subs(J, [q1 q2 q3 L1 L2 L3], [q L]));
vel_omg = J_num * dot_q;

v = vel_omg(1:3, :);
omega = vel_omg(4:6, :);
