clear all
close all

%% 2.1 Euler-Lagrange

syms lc1 lc2 real % dimensoes

syms q1 q2 real % q1 = theta1, q2 = d2
q = [q1 q2];

xc1 = lc1*cos(sym(q1));
yc1 = lc1*sin(sym(q1));

J_L1 = [diff(xc1, q1)  diff(yc1, q1);
        diff(xc1, q2)  diff(yc1, q2)]';
J_A1 = [0 1];

xc2 = (q2 - lc2)*cos(sym(q1)); 
yc2 = (q2 - lc2)*sin(sym(q1));

J_L2 = [diff(xc2, q1)  diff(yc2, q1);
        diff(xc2, q2)  diff(yc2, q2)]';
J_A2 = [0 0];

syms m1 m2 I1 I2 real
syms m [1,2] real

H1 = (m1 * (J_L1') * J_L1) + (I1 * (J_A1') * J_A1);
H2 = (m2 * (J_L2') * J_L2) + (I2 * (J_A2') * J_A2);
H = simplify(H1 + H2);

syms q1_dt q2_dt real
q_dt = [q1_dt q2_dt]';

syms q1_dt2 q2_dt2 real
q_dt2 = [q1_dt2 q2_dt2];

syms g real
grav = [0 g]';

r0c = [xc1 yc1;
       xc2 yc2]';

%valores = true;
valores = false;

% Coeficientes de Christofel
if valores
    for i = 1:2
        for j = 1:2
            junta = simplify(H(i,j) * q_dt2(j));
    
            for k = 1:2
                h = diff(H(i,j), q(k)) - (1/2) * diff(H(j,k), q(i));
                h = simplify(h);
    
                junta = junta + simplify(h * q_dt(j) * q_dt(k));
            end
        end
    
        Q(i) = simplify(junta);
    
        for j = 1:2
            Gi = m(j) * (grav') * diff(r0c(:,j), q(i))
            Q(i) = Q(i) - simplify(Gi);
        end
    
        Q(i) = simplify(Q(i));
    end
else
    % Simbólico (para copiar)
    clear Q H h r0c
    
    syms r0c [2 2] real
    syms H [2 2] real
    syms h [2 2 2] real
    
    for i = 1:2
        for j = 1:2
            junta = simplify(H(i,j) * q_dt2(j));
    
            for k = 1:2
                junta = junta + simplify(h(i,j,k) * q_dt(j) * q_dt(k));
            end
        end
    
        Q(i) = simplify(junta);
    end
end

tau1 = Q(1);
f2 = Q(2);
