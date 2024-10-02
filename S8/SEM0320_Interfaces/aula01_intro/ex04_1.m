close all; clear all;
clc

t0 = 0;
tfinal = 1;
tspan = [t0, tfinal];
y0 = [2, 1, -2];

[t, y] = ode45(@ex04_2, tspan, y0);

figure()
plot(t, y(:, 1), 'Linewidth', 2); hold on
plot(t, y(:, 2), '--', 'LineWidth', 2); hold on
plot(t, y(:, 3), ':', 'LineWidth', 2);
xlabel( 'Time [s]', 'FontSize', 10);
ylabel( 'State Variables', 'FontSize', 10);
