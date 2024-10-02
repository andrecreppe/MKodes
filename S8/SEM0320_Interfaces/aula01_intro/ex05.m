%% Inicio

close all; clear all;
clc

x10 = 1;
x20 = -1;

%% Depois do Simulink

figure()
plot(out.tout, out.simout(:,3)); hold on;
plot(out.tout, out.simout(:,1)); hold on;
plot(out.tout, out.simout(:,2)); hold on;
xlabel('t(s)'); ylabel('x_1, x_2'); legend('input', 'x_1', 'x_2');
