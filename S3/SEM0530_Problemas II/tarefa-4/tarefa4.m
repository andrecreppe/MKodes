# tarefa4.m
close all

% Velocidade Angular (Aproximacao de EDO)
int = [0:0.1:20];
[t, th] = ode45(@(t, th) velang(t, th), int, 0);

% Raio e sua variacao
r = 600 - 400 .* cos(th);
drdt = 400 .* sin(th);

% Velocidade Linear
v = 860 - 8.6 .* t;

% Valor de t mais proximo de 3 voltas
rot = 3 .* (2 .* pi);
[dif, index] = min(abs(th - rot));
temp = t(index);

fprintf('Tempo mais proximo de 3 voltas: %f s\n', temp);

% Graficos
figure
plot(t, th, '-b'); grid;
xlabel('t (s)'); ylabel('theta (rad)');

figure
plot(t, velang(th, t), '-r'); grid;
xlabel('t (s)'); ylabel('dth/dt (rad/s)');

figure
plot(t, v/1000, '-c'); grid;
xlabel('t (s)'); ylabel('v (m/s)');

figure
plot(t, r/1000, '-m'); grid;
xlabel('t (s)'); ylabel('r (m)');

figure
plot(t, drdt/1000, '-g'); grid;
xlabel('t (s)'); ylabel('dr/dt (m/s)');

figure
plot(th, r/1000); grid;
xlabel('th (rad)'); ylabel('r (m)');
