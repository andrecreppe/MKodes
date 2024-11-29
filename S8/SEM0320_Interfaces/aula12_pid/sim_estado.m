function [] = sim_estado(flag_var, flag_plot, toPNG)
    leg = [];
    variant = "";
    
    curr_color = [[0 0.4470 0.7410]; [0.8500 0.3250 0.0980]; [0.9290 0.6940 0.1250]; [0.4940 0.1840 0.5560]];
    vel_color = [[0.9290 0.6940 0.1250]; [0.4940 0.1840 0.5560]; [0.4660 0.6740 0.1880]; [0.3010 0.7450 0.9330]; [0.6350 0.0780 0.1840]];
    
    figure
    
    if flag_var == 1
        variant = "s_1";
        S1s = -[0, 100, 250, 450];
        for i = 1:4
            s1 = S1s(i);
            p = evalin('base', 'p'); % get from workspace
            p = [s1, p(2), p(3)];

            A = evalin('base', 'A');
            B = evalin('base', 'B');
            [ KF, ~ ] = place( A, B, p );
            assignin('base', 'KF', KF); % move to workspace
            
            sim('model_estado');
        
            if flag_plot == 1
                plot(sim_ia.Time, sim_ia.Data, 'Color', curr_color(1,:));
                curr_color(1,:) = [];
            elseif flag_plot == 2
                plot(sim_ia.Time, sim_wr.Data, 'Color', curr_color(1,:));
                curr_color(1,:) = [];
            end
        
            hold on
           
            leg = [leg "s_1 = " + s1];
        end
    elseif flag_var == 2
        variant = "s_2";
        S2s = -[0, 50, 99, 500];
        for i = 1:4
            s2 = S2s(i);
            p = evalin('base', 'p'); % get from workspace
            p = [p(1), s2, p(3)];

            A = evalin('base', 'A');
            B = evalin('base', 'B');
            [ KF, ~ ] = place( A, B, p );
            assignin('base', 'KF', KF); % move to workspace
            
            sim('model_estado');
        
            if flag_plot == 1
                plot(sim_ia.Time, sim_ia.Data, 'Color', curr_color(1,:));
                curr_color(1,:) = [];
            elseif flag_plot == 2
                plot(sim_ia.Time, sim_wr.Data, 'Color', curr_color(1,:));
                curr_color(1,:) = [];
            end
        
            hold on
           
            leg = [leg "s_2 = " + s2];
        end
    elseif flag_var == 3
        variant = "s_3";
        S3s = -[0, 99, 499, 1000];
        for i = 1:4
            s3 = S3s(i);
            p = evalin('base', 'p'); % get from workspace
            p = [p(1), p(2), s3];

            A = evalin('base', 'A');
            B = evalin('base', 'B');
            [ KF, ~ ] = place( A, B, p );
            assignin('base', 'KF', KF); % move to workspace
            
            sim('model_estado');
        
            if flag_plot == 1
                plot(sim_ia.Time, sim_ia.Data, 'Color', curr_color(1,:));
                curr_color(1,:) = [];
            elseif flag_plot == 2
                plot(sim_ia.Time, sim_wr.Data, 'Color', curr_color(1,:));
                curr_color(1,:) = [];
            end
        
            hold on
           
            leg = [leg "s_3 = " + s3];
        end
    elseif flag_var == 4
        variant = "u_{lim}";
        ULIM = [5, 10, 24, 30, 50];
        for i = 1:5
            u_lim = ULIM(i);

            assignin('base', 'u_lim', u_lim); % move to workspace
            sim('model_estado');
        
            if flag_plot == 1
                plot(sim_ia.Time, sim_ia.Data, 'Color', curr_color(1,:));
                curr_color(1,:) = [];
            elseif flag_plot == 2
                plot(sim_ia.Time, sim_wr.Data, 'Color', curr_color(1,:));
                curr_color(1,:) = [];
            end
        
            hold on
           
            leg = [leg "u_{lim} = \pm" + u_lim];
        end
    end
    
    if flag_plot == 1
        plot_str = 'ia';
        title("Efeito de $" + variant + "$ na Corrente $i_a$",'Interpreter','latex')
        xlabel("Tempo (s)")
        ylabel("Corrente (A)")
    elseif flag_plot == 2
        plot_str = 'wr';
        title("Efeito de $" + variant + "$ na Velocidade $\omega_r$",'Interpreter','latex')
        xlabel("Tempo (s)")
        ylabel("Velocidade (rad/s)")
    end
    
    grid on
    legend(leg)

    if toPNG == 1
        variant = erase(variant, '_');
        variant = erase(variant, '{');
        variant = erase(variant, '}');
    
        % Export plot to PNG
        saveas(gcf, append('./images/plot_estado_',variant,'_',plot_str,'.png'))
    end
end
