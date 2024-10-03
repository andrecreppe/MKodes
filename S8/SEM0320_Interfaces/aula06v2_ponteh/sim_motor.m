close all; clear all;
clc;

% 1 = ke
% 2 = VCC
% 3 = Bm
% 4 = La
flag_var = 1;

% 1 = Posicao
% 2 = Velocidade
flag_plot = 1;

%% Variaveis Originais

Ra = 4.0305;
Jm = 0.1157;

ke = 0.4536;
Vs = 12;
Bm = 1.0715;
La = 0.1466e-3;

%% Simulacao Condicional

leg = [];
variant = "";

pos_color = [[0 0.4470 0.7410]; [0.8500 0.3250 0.0980]; [0.9290 0.6940 0.1250]; [0.4940 0.1840 0.5560]];
vel_color = [[0.4940 0.1840 0.5560]; [0.4660 0.6740 0.1880]; [0.3010 0.7450 0.9330]; [0.6350 0.0780 0.1840]];

figure

if flag_var == 1 % ke
    variant = "ke";
    for ke = 0.25 : 0.25 : 1.0
        simout = sim('motor_dc');
    
        if flag_plot == 1
            plot(sim_pos.Time, sim_pos.Data, 'Color', pos_color(1,:));
            pos_color(1,:) = [];
        else
            plot(sim_vel.Time, sim_vel.Data, 'Color', vel_color(1,:));
            vel_color(1,:) = [];
        end
    
        hold on
       
        leg = [leg "ke = " + ke];
    end
elseif flag_var == 2
    variant = "VCC";
    for Vs = 5 : 5 : 20
        simout = sim('motor_dc');
    
        if flag_plot == 1
            plot(sim_pos.Time, sim_pos.Data, 'Color', pos_color(1,:));
            pos_color(1,:) = [];
        else
            plot(sim_vel.Time, sim_vel.Data, 'Color', vel_color(1,:));
            vel_color(1,:) = [];
        end
    
        hold on
       
        leg = [leg "VCC = " + Vs];
    end
elseif flag_var == 3
    variant = "Bm";
    for Bm = 0.5 : 0.5 : 2
        simout = sim('motor_dc');
    
        if flag_plot == 1
            plot(sim_pos.Time, sim_pos.Data, 'Color', pos_color(1,:));
            pos_color(1,:) = [];
        else
            plot(sim_vel.Time, sim_vel.Data, 'Color', vel_color(1,:));
            vel_color(1,:) = [];
        end
    
        hold on
       
        leg = [leg "Bm = " + Bm];
    end
elseif flag_var == 4
    variant = "La";
    LAs = [0.05, 0.1, 0.5, 1.0];
    for i = 1:4
        La = LAs(i);
        simout = sim('motor_dc');
    
        if flag_plot == 1
            plot(sim_pos.Time, sim_pos.Data, 'Color', pos_color(1,:));
            pos_color(1,:) = [];
        else
            plot(sim_vel.Time, sim_vel.Data, 'Color', vel_color(1,:));
            vel_color(1,:) = [];
        end
    
        hold on
       
        leg = [leg "La = " + La];
    end
end

if flag_plot == 1
    title("Efeito de '" + variant + "' na Posição")
    xlabel("Tempo (s)")
    ylabel("Posição (rad)")
else
    title("Efeito de '" + variant + "' na Velocidade")
    xlabel("Tempo (s)")
    ylabel("Velocidade (rad/s)")
end

grid on
legend(leg)
