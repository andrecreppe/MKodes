clear all, close all
clc

%% Parâmetros do Modelo

% Veículo
ld = 1.1; % m
lt = 1.5; % m
M = 1180; % kg
Ig = 240; % kg.m^2

% Pneus
k1 = 30e3; % N/m
c1 = 5e3;  % N.s/m
m = 10;    % kg

% Suspensão
k2 = 90e3; % N/m
c2 = 4e3;  % N.s/m

%% Equação Matricial

% Massa
M = [M 0 0 0;
     0 Ig 0 0;
     0 0 m 0;
     0 0 0 m];
 
% Amortecimento
C = [2*c2       c2*(ld-lt)      -c2     -c2 ;
     c2*(ld-lt) c2*(ld^2+lt^2)  -c2*ld  c2*lt;
     -c2        -c2*ld          c1+c2   0 ;
     -c2        c2*lt           0       c1+c2];
 
% Rigidez
K = [2*k2      k2*(ld-lt)      -k2     -k2 ;
    k2*(ld-lt) k2*(ld^2+lt^2)  -k2*ld  k2*lt;
    -k2        -k2*ld          k1+k2   0 ;
    -k2        k2*lt           0       k1+k2];
 
% Forças
F1= [0  0;
     0  0;
     k1 0;
     0  k1];

F2= [0  0;
     0  0;
     c1 0;
     0  c1];

%% Frequencias Naturais e Modos de Vibrar

disp('--- Autovalores e autovetores ---')
[v,d]=eig(K,M); d=sqrt(diag(d));

disp('Frequencias naturais, omega (rad/s)')
omega=(d'); disp(omega)

disp('Modos de vibracao, phi (normalizados pela massa)')
disp(v)
vn1=diag(max(abs(v)))\v;

disp('Modos de vibracao, phi (normalizados pelo maximo)')
disp(vn1)

%% Matriz de Amortecimendo Modal

D=2*0.2*(M*v*diag(d)*v'*M);
Lambda=v'*D*v; zeta=(1/2)*diag(Lambda)./d;

disp('Matriz modal de amortecimento')
disp(Lambda)

%% Pista

h = 0.08; % altura da lombada [m]
L = 1.5; % comprimento da lombada [m]
d = 2; % centro da lombada [m]

L_p = 100; % comprimento da pista [m]
dL = 0.01; % passo de pista

x_p = 0:dL:L_p;
z_ref = zeros(1,length(x_p));
vel_ref = zeros(1,length(x_p));

for i=1:length(x_p)
    f(i) = (4*h/L^2)*(-(x_p(i)-d)^2+(L/2)^2);
    f_dot(i) = -(8*h/L^2)*(x_p(i)-d);
    z_pista(i) = max([z_ref(i) f(i)]);

    % fora dos limites da lombada
    if (x_p(i) > (d-0.5*L)) && (x_p(i) < (d+0.5*L)) 
        v_pista(i) = f_dot(i);
    else
        v_pista(i) = vel_ref(i);
    end
end

figure
plot(x_p, z_pista, 'b')
grid on
title('Perfil de Deslocamento');
xlabel('Distância (m)'); ylabel('Altura (m)');
xlim([0 10]); ylim([0 1])

figure
plot(x_p, v_pista, 'r')
grid on
title('Perfil de Velocidade');
xlabel('Distância (m)'); ylabel('Velocidade (m/s)');
xlim([0 10]); ylim([-0.4 0.4])

%% Espaço de Estados

% uG - translação vertical do CM [m]
% theta - rotacao do veiculo [rad]
% ud - deslocamento vertical da dianteira [m]
% ut - deslocamento vertical da traseira [m]

c=eye(size(M));
damping = D; % modal (D) ou direto (C)

A = [zeros(size(M))  eye(size(M)); 
        -M\K             -M\damping ];

B = [zeros(size(F1));
         M\F1 ];

Cy = [c               zeros(size(c));
         zeros(size(c))  zeros(size(c))];

D = [zeros(size(F2));
         M\F2 ];

sys = ss(A,B,Cy,D);

%% Resposta ao Impulso

t_sim = 3; % tempo de simulação [s]
dt = 0.001; % passo de tempo
time = linspace(0,t_sim,t_sim/dt);

[y,t] = impulse(sys, t_sim);

figure
plot(t,y(:,1,1), 'm');
hold on
plot(t,y(:,1,2), 'g');
legend('F1', 'F2'); grid on;
title('Resposta ao Impulso - Deslocamento CG');

figure
plot(t,y(:,2,1), 'm');
hold on
plot(t,y(:,2,2), 'g');
legend('F1', 'F2'); grid on;
title('Resposta ao Impulso - Rotação Theta');

figure
plot(t,y(:,3,1), 'm');
hold on
plot(t,y(:,3,2), 'g');
legend('F1', 'F2'); grid on;
title('Resposta ao Impulso - Deslocamento Dianteira');

figure
plot(t,y(:,4,1), 'm');
hold on
plot(t,y(:,4,2), 'g');
legend('F1', 'F2'); grid on;
title('Resposta ao Impulso - Deslocamento Traseira');

%% Resposta em Frequência

figure
bodeplot(sys(1,1))
grid on
title('FRF - Deslocamento CG')

figure
bodeplot(sys(1,2))
grid on
title('FRF - Rotação Theta')

%% Resposta no Tempo

v_kmh = 30; % velocidade do veículo [km/h]
v = v_kmh/3.6; % conversao para m/s

pos_d = v*time; % posição eixo dianteiro
u1 = interp1(x_p,z_pista,pos_d);
pos_t = v*time + (lt+ld); % posição eixo traseiro
u2 = interp1(x_p,z_pista,pos_t);
u_vet = [u1' u2'];

[y,time,x] = lsim(sys,u_vet,time);
uG = y(:,1);
theta = y(:,2);
ud = y(:,3);
ut = y(:,4);

figure
title('Simulação da Resposta no Tempo para Lombada');
hold on; grid on;
xlabel('Tempo (s)');
yyaxis left;
plot(time, uG, 'b');
ylabel('Deslocamento do CG (m)');
xlim([0 t_sim]); ylim([-h h]);
yyaxis right;
plot(time,theta*(180/pi), 'r');
ylabel('Ângulo do Veiculo (grau)');
legend('u','theta');
xlim([0 t_sim]); ylim([-5 5]);
