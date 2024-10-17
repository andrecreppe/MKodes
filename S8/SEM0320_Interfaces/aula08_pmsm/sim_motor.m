function [] = sim_motor(flag_var, flag_plot)
    leg = [];
    variant = "";
    
    curr_color = [[0 0.4470 0.7410]; [0.8500 0.3250 0.0980]; [0.9290 0.6940 0.1250]; [0.4940 0.1840 0.5560]];
    vel_color = [[0.4940 0.1840 0.5560]; [0.4660 0.6740 0.1880]; [0.3010 0.7450 0.9330]; [0.6350 0.0780 0.1840]];
    
    figure
    
    if flag_var == 1
        variant = "psi";
        PSIs = [0.05, 0.10, 0.15, 0.20];
        for i = 1:4
            psim = PSIs(i);
            assignin('base', 'psim', psim); % move to workspace
            out = sim('motor_ac');
        
            if flag_plot == 1
                plot(out.sim_ias.Time, out.sim_ias.Data, 'Color', curr_color(1,:));
                curr_color(1,:) = [];
            elseif flag_plot == 2
                plot(out.sim_ias.Time, out.sim_ibs.Data, 'Color', curr_color(1,:));
                curr_color(1,:) = [];
            elseif flag_plot == 3
                plot(out.sim_ias.Time, out.sim_ics.Data, 'Color', curr_color(1,:));
                curr_color(1,:) = [];
            elseif flag_plot == 4
                plot(out.sim_vel.Time, out.sim_vel.Data, 'Color', vel_color(1,:));
                vel_color(1,:) = [];
            end
        
            hold on
           
            leg = [leg "psi = " + psim];
        end
    elseif flag_var == 2
        variant = "rs";
        RSs = [0.5, 1.0, 2.0, 5.0];
        for i = 1:4
            rs = RSs(i);
            assignin('base', 'rs', rs); % move to workspace
            out = sim('motor_ac');
        
            if flag_plot == 1
                plot(out.sim_ias.Time, out.sim_ias.Data, 'Color', curr_color(1,:));
                curr_color(1,:) = [];
            elseif flag_plot == 2
                plot(out.sim_ias.Time, out.sim_ibs.Data, 'Color', curr_color(1,:));
                curr_color(1,:) = [];
            elseif flag_plot == 3
                plot(out.sim_ias.Time, out.sim_ics.Data, 'Color', curr_color(1,:));
                curr_color(1,:) = [];
            elseif flag_plot == 4
                plot(out.sim_vel.Time, out.sim_vel.Data, 'Color', vel_color(1,:));
                vel_color(1,:) = [];
            end
        
            hold on
           
            leg = [leg "rs = " + rs];
        end
    elseif flag_var == 3
        variant = "a2";
        a2s = [0.0, 0.05, 0.1, 0.5];
        for i = 1:4
            a2 = a2s(i);
            assignin('base', 'a2', a2); % move to workspace
            out = sim('motor_ac');
        
            if flag_plot == 1
                plot(out.sim_ias.Time, out.sim_ias.Data, 'Color', curr_color(1,:));
                curr_color(1,:) = [];
            elseif flag_plot == 2
                plot(out.sim_ias.Time, out.sim_ibs.Data, 'Color', curr_color(1,:));
                curr_color(1,:) = [];
            elseif flag_plot == 3
                plot(out.sim_ias.Time, out.sim_ics.Data, 'Color', curr_color(1,:));
                curr_color(1,:) = [];
            elseif flag_plot == 4
                plot(out.sim_vel.Time, out.sim_vel.Data, 'Color', vel_color(1,:));
                vel_color(1,:) = [];
            end
        
            hold on
           
            leg = [leg "a2 = " + a2];
        end
    elseif flag_var == 4
        variant = "a3";
        a3s = [0.0, 0.01, 0.02, 0.05];
        for i = 1:4
            a3 = a3s(i);
            assignin('base', 'a3', a3); % move to workspace
            out = sim('motor_ac');
        
            if flag_plot == 1
                plot(out.sim_ias.Time, out.sim_ias.Data, 'Color', curr_color(1,:));
                curr_color(1,:) = [];
            elseif flag_plot == 2
                plot(out.sim_ias.Time, out.sim_ibs.Data, 'Color', curr_color(1,:));
                curr_color(1,:) = [];
            elseif flag_plot == 3
                plot(out.sim_ias.Time, out.sim_ics.Data, 'Color', curr_color(1,:));
                curr_color(1,:) = [];
            elseif flag_plot == 4
                plot(out.sim_vel.Time, out.sim_vel.Data, 'Color', vel_color(1,:));
                vel_color(1,:) = [];
            end
        
            hold on
           
            leg = [leg "a3 = " + a3];
        end
    end
    
    if flag_plot == 1
        title("Efeito de '" + variant + "' na Corrente ias")
        xlabel("Tempo (s)")
        ylabel("Corrente (A)")
    elseif flag_plot == 2
        title("Efeito de '" + variant + "' na Corrente ibs")
        xlabel("Tempo (s)")
        ylabel("Corrente (A)")
    elseif flag_plot == 3
        title("Efeito de '" + variant + "' na Corrente ics")
        xlabel("Tempo (s)")
        ylabel("Corrente (A)")
    elseif flag_plot == 4
        title("Efeito de '" + variant + "' na Velocidade")
        xlabel("Tempo (s)")
        ylabel("Velocidade (rad/s)")
    end
    
    grid on
    legend(leg)
end
