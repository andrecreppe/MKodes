function [] = sim_motor(flag_var, flag_plot)
    leg = [];
    variant = "";
    
    curr_color = [[0 0.4470 0.7410]; [0.8500 0.3250 0.0980]; [0.9290 0.6940 0.1250]; [0.4940 0.1840 0.5560]];
    vel_color = [[0.4940 0.1840 0.5560]; [0.4660 0.6740 0.1880]; [0.3010 0.7450 0.9330]; [0.6350 0.0780 0.1840]];
    
    figure
    
    if flag_var == 1
        variant = "\psi";
        PSIs = [0.01, 0.02, 0.03, 0.04];
        for i = 1:4
            psim = PSIs(i);
            assignin('base', 'psim', psim); % move to workspace
            sim('motor_passo');
        
            if flag_plot == 1
                plot(sim_id.Time, sim_id.Data, 'Color', curr_color(1,:));
                curr_color(1,:) = [];
            elseif flag_plot == 2
                plot(sim_id.Time, sim_iq.Data, 'Color', curr_color(1,:));
                curr_color(1,:) = [];
            elseif flag_plot == 3
                plot(sim_id.Time, sim_Te.Data, 'Color', curr_color(1,:));
                curr_color(1,:) = [];
            elseif flag_plot == 4
                plot(sim_id.Time, sim_theta.Data, 'Color', vel_color(1,:));
                vel_color(1,:) = [];
            elseif flag_plot == 5
                plot(sim_id.Time, sim_vd.Data, 'Color', vel_color(1,:));
                vel_color(1,:) = [];
            elseif flag_plot == 6
                plot(sim_id.Time, sim_vq.Data, 'Color', vel_color(1,:));
                vel_color(1,:) = [];
            elseif flag_plot == 7
                plot(sim_id.Time, sim_w.Data, 'Color', vel_color(1,:));
                vel_color(1,:) = [];
            end
        
            hold on
           
            leg = [leg "\psi = " + psim];
        end
    elseif flag_var == 2
        variant = "L_s";
        LSs = [0.1, 0.5, 1.0, 2.0] * 1e-3;
        for i = 1:4
            Ls = LSs(i);
            assignin('base', 'Ls', Ls); % move to workspace
            sim('motor_passo');
        
            if flag_plot == 1
                plot(sim_id.Time, sim_id.Data, 'Color', curr_color(1,:));
                curr_color(1,:) = [];
            elseif flag_plot == 2
                plot(sim_id.Time, sim_iq.Data, 'Color', curr_color(1,:));
                curr_color(1,:) = [];
            elseif flag_plot == 3
                plot(sim_id.Time, sim_Te.Data, 'Color', curr_color(1,:));
                curr_color(1,:) = [];
            elseif flag_plot == 4
                plot(sim_id.Time, sim_theta.Data, 'Color', vel_color(1,:));
                vel_color(1,:) = [];
            elseif flag_plot == 5
                plot(sim_id.Time, sim_vd.Data, 'Color', vel_color(1,:));
                vel_color(1,:) = [];
            elseif flag_plot == 6
                plot(sim_id.Time, sim_vq.Data, 'Color', vel_color(1,:));
                vel_color(1,:) = [];
            elseif flag_plot == 7
                plot(sim_id.Time, sim_w.Data, 'Color', vel_color(1,:));
                vel_color(1,:) = [];
            end
        
            hold on
           
            leg = [leg "Ls = " + Ls];
        end
    elseif flag_var == 3
        variant = "R_s";
        RSs = [0.1, 0.5, 1.0, 2.0];
        for i = 1:4
            Rs = RSs(i);
            assignin('base', 'Rs', Rs); % move to workspace
            sim('motor_passo');
        
            if flag_plot == 1
                plot(sim_id.Time, sim_id.Data, 'Color', curr_color(1,:));
                curr_color(1,:) = [];
            elseif flag_plot == 2
                plot(sim_id.Time, sim_iq.Data, 'Color', curr_color(1,:));
                curr_color(1,:) = [];
            elseif flag_plot == 3
                plot(sim_id.Time, sim_Te.Data, 'Color', curr_color(1,:));
                curr_color(1,:) = [];
            elseif flag_plot == 4
                plot(sim_id.Time, sim_theta.Data, 'Color', vel_color(1,:));
                vel_color(1,:) = [];
            elseif flag_plot == 5
                plot(sim_id.Time, sim_vd.Data, 'Color', vel_color(1,:));
                vel_color(1,:) = [];
            elseif flag_plot == 6
                plot(sim_id.Time, sim_vq.Data, 'Color', vel_color(1,:));
                vel_color(1,:) = [];
            elseif flag_plot == 7
                plot(sim_id.Time, sim_w.Data, 'Color', vel_color(1,:));
                vel_color(1,:) = [];
            end
        
            hold on
           
            leg = [leg "Rs = " + Rs];
        end
    elseif flag_var == 4
        variant = "B";
        Bs = [0.1, 0.5, 1.0, 5.0] * 1e-3;
        for i = 1:4
            B = Bs(i);
            assignin('base', 'B', B); % move to workspace
            sim('motor_passo');
        
            if flag_plot == 1
                plot(sim_id.Time, sim_id.Data, 'Color', curr_color(1,:));
                curr_color(1,:) = [];
            elseif flag_plot == 2
                plot(sim_id.Time, sim_iq.Data, 'Color', curr_color(1,:));
                curr_color(1,:) = [];
            elseif flag_plot == 3
                plot(sim_id.Time, sim_Te.Data, 'Color', curr_color(1,:));
                curr_color(1,:) = [];
            elseif flag_plot == 4
                plot(sim_id.Time, sim_theta.Data, 'Color', vel_color(1,:));
                vel_color(1,:) = [];
            elseif flag_plot == 5
                plot(sim_id.Time, sim_vd.Data, 'Color', vel_color(1,:));
                vel_color(1,:) = [];
            elseif flag_plot == 6
                plot(sim_id.Time, sim_vq.Data, 'Color', vel_color(1,:));
                vel_color(1,:) = [];
            elseif flag_plot == 7
                plot(sim_id.Time, sim_w.Data, 'Color', vel_color(1,:));
                vel_color(1,:) = [];
            end
        
            hold on
           
            leg = [leg "B = " + B];
        end
    end
    
    if flag_plot == 1
        title("Efeito de $" + variant + "$ na Corrente $i_d$",'Interpreter','latex')
        xlabel("Tempo (s)")
        ylabel("Corrente (A)")
    elseif flag_plot == 2
        title("Efeito de $" + variant + "$ na Corrente $i_q$",'Interpreter','latex')
        xlabel("Tempo (s)")
        ylabel("Corrente (A)")
    elseif flag_plot == 3
        title("Efeito de $" + variant + "$ no Torque da Carga $T_e$",'Interpreter','latex')
        xlabel("Tempo (s)")
        ylabel("Corrente (A)")
    elseif flag_plot == 4
        title("Efeito de $" + variant + "$ na Posi\c{c}\~ao $\theta$",'Interpreter','latex')
        xlabel("Tempo (s)")
        ylabel("Velocidade (rad/s)")
    elseif flag_plot == 5
        title("Efeito de $" + variant + "$ na Tens\~ao $V_d$",'Interpreter','latex')
        xlabel("Tempo (s)")
        ylabel("Velocidade (rad/s)")
    elseif flag_plot == 6
        title("Efeito de $" + variant + "$ na Tens\~ao $V_q$",'Interpreter','latex')
        xlabel("Tempo (s)")
        ylabel("Velocidade (rad/s)")
    elseif flag_plot == 7
        title("Efeito de $" + variant + "$ na Velocidade $\omega$",'Interpreter','latex')
        xlabel("Tempo (s)")
        ylabel("Velocidade (rad/s)")
    end
    
    grid on
    legend(leg)
end
