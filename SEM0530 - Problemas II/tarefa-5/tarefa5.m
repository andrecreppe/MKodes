# tarefa5.m
clear all
close all

% Problema

interv = [0:0.01:20];
theta0 = [
  0; # th0
  15 # (dth/dt)0
];

[t, theta] = ode45(@pendulum, interv, theta0);
% theta(:, 1) = deslocamento angular theta
% theta(:, 2) = velocidade angular dth/dt

T = 1 .* 9.807 .* cos(theta(:, 1));

f = theta(:, 2) ./ (2 .* pi);

% Respostas Numericas

turns = theta(end, 1) ./ (2 .* pi);
fprintf('Total de voltas dadas: %f\n', turns);

% Graficos

figure
plot(t, theta(:, 1), '-b', t, theta(:, 2), '-r'); grid;
lel = legend({'Des. Ang. (rad)', 'Vel. Ang. (rad/s)'}, 'location', 'east');
  set(lel, 'fontsize', 14);
xlabel('Tempo (s)');

figure
plot(theta(:, 1), theta(:, 2), '-m'); grid;
xlabel('Ângulo(rad)');
ylabel('Velocidade Angular (rad/s)');

figure
plot(t, T, '-c'); grid;
xlabel('Tempo (s)');
ylabel('Tração (N)');

figure
plot(t, f, '-g'); grid;
xlabel('Tempo (s)');
ylabel('Frequência (Hz)');
