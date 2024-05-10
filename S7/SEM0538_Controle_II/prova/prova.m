close all; clear all;
clc

%% ========== QUESTAO 1 ==========

% 1.a)
data = load('dados.txt');

t_data = data(:,1);
u_data = data(:,2);
y_data = data(:,3);

%{
systemIdentification()
   input = u
   output = y
   poles = 2
   zeros = 0
%}

G = tf(16.3, [1, 0.6513, 5.085])

% 1.b)
t = 0:0.005:5;
u = 9.3;

y = step(G, t) * u;

figure
plot(t_data,y_data)
hold on
plot(t,y)
title('Resposta ao Degrau')
xlabel('Tempo (s)')
ylabel('Deslocamento (cm)')
legend('Experimental', 'Teorico')
grid on

%% ========== QUESTAO 2 ==========

A = [0  1  0; 
     0  0  1; 
     0 -5.085 -0.6513];
     
B = [0; 0; 16.3];

%% ========== QUESTAO 3 ==========

p = [-1; -5+5*i; -5-5*i];

K = place(A, B, p);

Ki = K(1)
Kp = K(2)
Kd = K(3)

% 3.a)

polin = poly(p(2:3));

omega_n = sqrt(polin(3)) % rad/s
zeta = polin(2) / (2 * omega_n) % -

Mp = exp(-(zeta * pi) / (sqrt(1 - zeta^2))) * 100 % porc.
tr = 1.8 / omega_n % seg.

% 3.b)

C = tf([Kd Kp Ki], [1 0]);

Gfc = feedback(G*C, 1);

uf = 20; % cm
yf = step(Gfc, t) * uf;

figure
plot(t, yf)
title('Resposta ao Degrau')
xlabel('Tempo (s)')
ylabel('Deslocamento (cm)')
grid on

stepinfo(yf) % verificar os parametros

%% ========== QUESTAO 4 ==========

T0 = 0.1; % s

% 4.a)

Gz = c2d(G, T0, 'zoh')

% 4.b)

q0 = Kp + Kd/T0 + Ki*T0
q1 = -Kp - 2*Kd/T0
q2 = Kd / T0

C_PID = tf([q0 q1 q2], [1 -1 0], T0)

% 4.c)

Gfd = feedback(Gz*C_PID, 1)

% 4.d)

ufd = 20; % cm

figure
step(ufd * Gfd);
title('Resposta ao Degrau')
xlabel('Tempo (s)')
ylabel('Deslocamento (cm)')
grid on

p_zc = pole(c2d(Gfc,T0))
p_zd = pole(Gfd)

%% ========== QUESTAO 5 ==========

figure
h = pzplot(c2d(Gfc,T0));
zgrid
axis equal

% 5.b)

z0 = 0.53 + 0.29i;
z1 = 0.891;

GC_mult = [(0.07942*z0^-1) + (0.07771*z0^-2);
        z0 - 0.891;
        z0
        z0 - 1
        1 - 1.888*(z0^-1) + 0.9369*(z0^-2)];

GC_phase = phase(GC_mult);
z0z2 = sum(GC_phase) * 180/pi - 188;

z2 = 0.53 - (0.29 / tand(z0z2))

% 5.c)

q0_num = abs(1 - 1.888*z0^-1 + 0.9369*z0^-2) * abs(z0) * abs(z0 - 1);
q0_den = abs(0.07942*z0^-1 + 0.07771*z0^-2) * abs(z0 - z1) * abs(z0 - z2);
q0 = q0_num / q0_den

syms q1 q2
q = solve(q1/q0 == -z1-z2, q2/q0 == z1*z2);
q1 = double(vpa(q.q1(1)))
q2 = double(vpa(q.q2(1)))

syms Kid Kdd Kpd
Kc = solve(q0 == Kpd + Kdd/T0 + Kid*T0, q1 == -Kpd - (2*Kdd)/T0, q2 == Kdd/T0);
Kid = double(Kc.Kid)
Kpd = double(Kc.Kpd)
Kdd = double(Kc.Kdd)

C_PIDZ = tf([q0 q1 q2], [1 -1 0], T0)

% 5.d)

Gfd2 = feedback(Gz*C_PIDZ, 1)

figure
rlocus(Gfd2)
title('Lugar das Raizes')
grid on

% 5.e)

figure
step(ufd * Gfd2)
hold on
step(ufd * Gfc)
title('Resposta ao Degrau')
xlabel('Tempo (s)')
ylabel('Deslocamento (cm)')
legend('Discreto', 'Conitnuo')
grid on
