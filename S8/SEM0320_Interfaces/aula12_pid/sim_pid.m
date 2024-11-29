function [] = sim_pid(flag_var, flag_plot, toPNG)
    leg = [];
    variant = "";
    
    curr_color = [[0 0.4470 0.7410]; [0.8500 0.3250 0.0980]; [0.9290 0.6940 0.1250]; [0.4940 0.1840 0.5560]; [0.4660 0.6740 0.1880]];
    vel_color = [[0.9290 0.6940 0.1250]; [0.4940 0.1840 0.5560]; [0.4660 0.6740 0.1880]; [0.3010 0.7450 0.9330]; [0.6350 0.0780 0.1840]];
    
    figure
    
    if flag_var == 1
        variant = "q";
        Qs = [0.00, 0.25, 0.50, 0.75, 1.00];
        for i = 1:5
            q = Qs(i);
            assignin('base', 'q', q); % move to workspace
            sim('model_pid');
        
            if flag_plot == 1
                plot(sim_ia.Time, sim_ia.Data, 'Color', curr_color(1,:));
                curr_color(1,:) = [];
            elseif flag_plot == 2
                plot(sim_ia.Time, sim_J.Data, 'Color', curr_color(1,:));
                curr_color(1,:) = [];
            elseif flag_plot == 3
                plot(sim_ia.Time, sim_ua.Data, 'Color', curr_color(1,:));
                curr_color(1,:) = [];
            elseif flag_plot == 4
                plot(sim_ia.Time, sim_wr.Data, 'Color', vel_color(1,:));
                vel_color(1,:) = [];
            elseif flag_plot == 5
                plot(sim_ia.Time, sim_y.Data, 'Color', vel_color(1,:));
                vel_color(1,:) = [];
            end
        
            hold on
           
            leg = [leg "q = " + q];
        end
    elseif flag_var == 2
        variant = "g";
        Gs = [1.0, 0.75, 0.50, 0.25, 0.00];
        for i = 1:5
            g = Gs(i);
            assignin('base', 'g', g); % move to workspace
            sim('model_pid');
        
            if flag_plot == 1
                plot(sim_ia.Time, sim_ia.Data, 'Color', curr_color(1,:));
                curr_color(1,:) = [];
            elseif flag_plot == 2
                plot(sim_ia.Time, sim_J.Data, 'Color', curr_color(1,:));
                curr_color(1,:) = [];
            elseif flag_plot == 3
                plot(sim_ia.Time, sim_ua.Data, 'Color', curr_color(1,:));
                curr_color(1,:) = [];
            elseif flag_plot == 4
                plot(sim_ia.Time, sim_wr.Data, 'Color', vel_color(1,:));
                vel_color(1,:) = [];
            elseif flag_plot == 5
                plot(sim_ia.Time, sim_y.Data, 'Color', vel_color(1,:));
                vel_color(1,:) = [];
            end
        
            hold on
           
            leg = [leg "g = " + g];
        end
    elseif flag_var == 3
        variant = "u_{lim}";
        ULIM = [5, 10, 24, 30, 50];
        for i = 1:5
            u_lim = ULIM(i);

            assignin('base', 'u_max', u_lim); % move to workspace
            assignin('base', 'u_min', -u_lim);
            sim('model_pid');
        
            if flag_plot == 1
                plot(sim_ia.Time, sim_ia.Data, 'Color', curr_color(1,:));
                curr_color(1,:) = [];
            elseif flag_plot == 2
                plot(sim_ia.Time, sim_J.Data, 'Color', curr_color(1,:));
                curr_color(1,:) = [];
            elseif flag_plot == 3
                plot(sim_ia.Time, sim_ua.Data, 'Color', curr_color(1,:));
                curr_color(1,:) = [];
            elseif flag_plot == 4
                plot(sim_ia.Time, sim_wr.Data, 'Color', vel_color(1,:));
                vel_color(1,:) = [];
            elseif flag_plot == 5
                plot(sim_ia.Time, sim_y.Data, 'Color', vel_color(1,:));
                vel_color(1,:) = [];
            end
        
            hold on
           
            leg = [leg "u_{lim} = \pm" + u_lim];
        end
    elseif flag_var == 4
        variant = "k_d";
        KDs = [0, 1e1, 1e2, 1e3, 1e4];
        for i = 1:5
            kd = KDs(i);

            assignin('base', 'kd', kd); % move to workspace
            sim('model_pid');
        
            if flag_plot == 1
                plot(sim_ia.Time, sim_ia.Data, 'Color', curr_color(1,:));
                curr_color(1,:) = [];
            elseif flag_plot == 2
                plot(sim_ia.Time, sim_J.Data, 'Color', curr_color(1,:));
                curr_color(1,:) = [];
            elseif flag_plot == 3
                plot(sim_ia.Time, sim_ua.Data, 'Color', curr_color(1,:));
                curr_color(1,:) = [];
            elseif flag_plot == 4
                plot(sim_ia.Time, sim_wr.Data, 'Color', vel_color(1,:));
                vel_color(1,:) = [];
            elseif flag_plot == 5
                plot(sim_ia.Time, sim_y.Data, 'Color', vel_color(1,:));
                vel_color(1,:) = [];
            end
        
            hold on
           
            leg = [leg "k_d = " + kd];
        end
    end
    
    if flag_plot == 1
        plot_str = 'ia';
        title("Efeito de $" + variant + "$ na Corrente $i_a$",'Interpreter','latex')
        xlabel("Tempo (s)")
        ylabel("Corrente (A)")
    elseif flag_plot == 2
        plot_str = 'perf';
        title("Efeito de $" + variant + "$ na Performance $J$",'Interpreter','latex')
        xlabel("Tempo (s)")
        ylabel("Performance (-)")
    elseif flag_plot == 3
        plot_str = 'ua';
        title("Efeito de $" + variant + "$ na Tens\~ao $u_a$",'Interpreter','latex')
        xlabel("Tempo (s)")
        ylabel("Tensão (V)")
    elseif flag_plot == 4
        plot_str = 'wr';
        title("Efeito de $" + variant + "$ na Velocidade $\omega_r$",'Interpreter','latex')
        xlabel("Tempo (s)")
        ylabel("Velocidade (rad/s)")
    elseif flag_plot == 5
        plot_str = 'th';
        title("Efeito de $" + variant + "$ na Posi\c{c}\~ao $\theta$",'Interpreter','latex')
        xlabel("Tempo (s)")
        ylabel("Posição (rad)")
    end
    
    grid on
    legend(leg)

    if toPNG == 1
        variant = erase(variant, '_');
        variant = erase(variant, '{');
        variant = erase(variant, '}');
    
        % Export plot to PNG
        saveas(gcf, append('./images/plot_pid_',variant,'_',plot_str,'.png'))
    end
end
