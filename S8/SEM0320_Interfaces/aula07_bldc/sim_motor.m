close all; clear all;
clc;

% 1 = psi
% 2 = rs
% 3 = Bm
% 4 = J
flag_var = 1;

% 1 = Torque
% 2 = Velocidade
flag_plot = 1;

%% Variaveis Originais

uM = 50;
TL = 0;

rs = 1;
Lls = 5e-4;
Lss = 5e-3;
fm = 0.15;
Bm = 5e-4;
J = 2.5e-4;
P = 4;

Lmb = Lss - Lls;

%% Simulacao Condicional

leg = [];
variant = "";

torq_color = [[0 0.4470 0.7410]; [0.8500 0.3250 0.0980]; [0.9290 0.6940 0.1250]; [0.4940 0.1840 0.5560]];
vel_color = [[0.4940 0.1840 0.5560]; [0.4660 0.6740 0.1880]; [0.3010 0.7450 0.9330]; [0.6350 0.0780 0.1840]];

figure

if flag_var == 1 % psi
    variant = "psi";
    PSIs = [0.05, 0.10, 0.15, 0.20];
    for i = 1:4
        fm = PSIs(i);
        out = sim('motor_bldc');
    
        if flag_plot == 1
            plot(out.sim_torq.Time, out.sim_torq.Data, 'Color', torq_color(1,:));
            torq_color(1,:) = [];
        else
            plot(out.sim_vel.Time, out.sim_vel.Data, 'Color', vel_color(1,:));
            vel_color(1,:) = [];
        end
    
        hold on
       
        leg = [leg "psi = " + fm];
    end
elseif flag_var == 2
    variant = "rs";
    RSs = [0.5, 1.0, 2.0, 5.0];
    for i = 1:4
        rs = RSs(i);
        out = sim('motor_bldc');
    
        if flag_plot == 1
            plot(out.sim_torq.Time, out.sim_torq.Data, 'Color', torq_color(1,:));
            torq_color(1,:) = [];
        else
            plot(out.sim_vel.Time, out.sim_vel.Data, 'Color', vel_color(1,:));
            vel_color(1,:) = [];
        end
    
        hold on
       
        leg = [leg "rs = " + rs];
    end
elseif flag_var == 3
    variant = "Bm";
    Bms = [0.5, 1.0, 2.0, 5.0]*1e-3;
    for i = 1:4
        Bm = Bms(i);
        out = sim('motor_bldc');
    
        if flag_plot == 1
            plot(out.sim_torq.Time, out.sim_torq.Data, 'Color', torq_color(1,:));
            torq_color(1,:) = [];
        else
            plot(out.sim_vel.Time, out.sim_vel.Data, 'Color', vel_color(1,:));
            vel_color(1,:) = [];
        end
    
        hold on
       
        leg = [leg "Bm = " + Bm];
    end
elseif flag_var == 4
    variant = "J";
    Js = [1.0, 2.5, 5.0, 10.0]*1e-4;
    for i = 1:4
        J = Js(i);
        out = sim('motor_bldc');
    
        if flag_plot == 1
            plot(out.sim_torq.Time, out.sim_torq.Data, 'Color', torq_color(1,:));
            torq_color(1,:) = [];
        else
            plot(out.sim_vel.Time, out.sim_vel.Data, 'Color', vel_color(1,:));
            vel_color(1,:) = [];
        end
    
        hold on
       
        leg = [leg "J = " + J];
    end
end

if flag_plot == 1
    title("Efeito de '" + variant + "' no Torque")
    xlabel("Tempo (s)")
    ylabel("Torque (N.s)")
else
    title("Efeito de '" + variant + "' na Velocidade")
    xlabel("Tempo (s)")
    ylabel("Velocidade (rad/s)")
end

grid on
legend(leg)
