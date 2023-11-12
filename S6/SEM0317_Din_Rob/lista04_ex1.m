clear all
close all

syms q1 q2 q3 l3 real % q1 = d1, q2 = d2, q3 = theta3
q = [q1 q2 q3];

%% 1-3 - Transformacao DH
A01 = transfMatrix(pi/2, q1, pi/2, 0);
A12 = transfMatrix(pi/2, q2, pi/2, 0);
A23 = transfMatrix(q3, 0, 0, l3);

A02 = A01 * A12;
A03 = A02 * A23;

%% 1-4 Jacobiano

syms q1_dt q2_dt q3_dt real
q_dt = [q1_dt q2_dt q3_dt]';

xe = q1 + l3*cos(sym(q3)); % copiado do A03 e trocado da base DH para XY
ye = q2 + l3*sin(sym(q3));
alpha = q3;

J_L = [diff(xe, q1) diff(xe, q2) diff(xe, q3);
       diff(ye, q1) diff(ye, q2) diff(ye, q3)];

J_A = [0 0 diff(alpha, q3)];

ve = J_L * q_dt;
omg_e = J_A * q_dt;

%% 1-5 Jacobiano com Massa

syms lc1 lc2 lc3 real

xc1 = q1 - lc1; 
yc1 = 0;

J_L1 = [diff(xc1, q1)  diff(yc1, q1)  0;
        diff(xc1, q2)  diff(yc1, q2)  0;
        diff(xc1, q3) diff(yc1, q3) 0]';
J_A1 = [0 0 0];

xc2 = q1; 
yc2 = q2 - lc2;

J_L2 = [diff(xc2, q1)  diff(yc2, q1)  0;
        diff(xc2, q2)  diff(yc2, q2)  0;
        diff(xc2, q3)  diff(yc2, q3)  0]';
J_A2 = [0 0 0];

xc3 = q1 + lc3*cos(sym(q3)); 
yc3 = q2 + lc3*sin(sym(q3));

J_L3 = [diff(xc3, q1)  diff(yc3, q1) 0;
        diff(xc3, q2)  diff(yc3, q2) 0
        diff(xc3, q3)  diff(yc3, q3) 0]';
J_A3 = [0 0 1];

%% 1-6 Matriz de Inércia

syms m1 m2 m3 I1 I2 I3 real

H1 = (m1 * (J_L1') * J_L1) + (I1 * (J_A1') * J_A1);
H2 = (m2 * (J_L2') * J_L2) + (I2 * (J_A2') * J_A2);
H3 = (m3 * (J_L3') * J_L3) + (I3 * (J_A3') * J_A3);
H = simplify(H1 + H2 + H3);

%% 1-7 Euler-Lagrange

% Lagrange -> Christoffel
% (sem gravidade)

syms q1_dt2 q2_dt2 q3_dt2 real
q_dt2 = [q1_dt2 q2_dt2 q3_dt2];

valores = true;
%valores = false;

if valores
    % Com Valores
    for i = 1:3
        for j = 1:3
            junta = simplify(H(i,j) * q_dt2(j));
    
            for k = 1:3
                h = diff(H(i,j), q(k)) - (1/2) * diff(H(j,k), q(i));
                h = simplify(h);
    
                junta = junta + simplify(h * q_dt(j) * q_dt(k));
            end
        end
    
        Q(i) = simplify(junta);
    end
else
    % Simbólico (para copiar)
    clear Q H h
    
    syms H [3 3] real
    syms h [3 3 3] real
    
    for i = 1:3
        for j = 1:3
            junta = simplify(H(i,j) * q_dt2(j));
    
            for k = 1:3
                junta = junta + simplify(h(i,j,k) * q_dt(j) * q_dt(k));
            end
        end
    
        Q(i) = simplify(junta);
    end
end

f1 = Q(1);
f2 = Q(2);
tau3 = Q(3);
