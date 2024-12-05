function [] = sim_buck_boost(flag_var, flag_plot, toPNG)
    leg = [];
    variant = "";
    
    curr_color = [[0 0.4470 0.7410]; [0.8500 0.3250 0.0980]; [0.9290 0.6940 0.1250]; [0.4940 0.1840 0.5560]; [0.4660 0.6740 0.1880]];
    vel_color = [[0.9290 0.6940 0.1250]; [0.4940 0.1840 0.5560]; [0.4660 0.6740 0.1880]; [0.3010 0.7450 0.9330]; [0.6350 0.0780 0.1840]];
    
    figure
    
    if flag_var == 1
        variant = "R_L";
        RLs = [2, 5, 10, 20];
        for i = 1:4
            RL = RLs(i);
            assignin('base', 'RL', RL); % move to workspace
            sim('model_buck_boost');
        
            if flag_plot == 1
                plot(out_uRL.Time, out_uRL.Data, 'Color', curr_color(1,:));
                curr_color(1,:) = [];
            elseif flag_plot == 2
                plot(out_uRL.Time, out_uC_iL_iRL.Data(:,1), 'Color', curr_color(1,:));
                curr_color(1,:) = [];
            elseif flag_plot == 3
                plot(out_uRL.Time, out_uC_iL_iRL.Data(:,2), 'Color', curr_color(1,:));
                curr_color(1,:) = [];
            elseif flag_plot == 4
                plot(out_uRL.Time, out_uC_iL_iRL.Data(:,3), 'Color', curr_color(1,:));
                curr_color(1,:) = [];
            end
        
            hold on
           
            leg = [leg "R_L = " + RL];
        end
    elseif flag_var == 2
        variant = "L_L";
        LLs = [1, 2, 5, 10] * 1e-3;
        for i = 1:4
            LL = LLs(i);
            assignin('base', 'LL', LL); % move to workspace
            sim('model_buck_boost');
        
            if flag_plot == 1
                plot(out_uRL.Time, out_uRL.Data, 'Color', curr_color(1,:));
                curr_color(1,:) = [];
            elseif flag_plot == 2
                plot(out_uRL.Time, out_uC_iL_iRL.Data(:,1), 'Color', curr_color(1,:));
                curr_color(1,:) = [];
            elseif flag_plot == 3
                plot(out_uRL.Time, out_uC_iL_iRL.Data(:,2), 'Color', curr_color(1,:));
                curr_color(1,:) = [];
            elseif flag_plot == 4
                plot(out_uRL.Time, out_uC_iL_iRL.Data(:,3), 'Color', curr_color(1,:));
                curr_color(1,:) = [];
            end
        
            hold on
           
            leg = [leg "L_L = " + LL];
        end
    end
    
    if flag_plot == 1
        plot_str = 'uRL';
        title("Efeito de $" + variant + "$ na Tens\~ao $u_{RL}$",'Interpreter','latex')
        xlabel("Tempo (s)")
        ylabel("Tensão (V)")
    elseif flag_plot == 2
        plot_str = 'uC';
        title("Efeito de $" + variant + "$ na Tens\~ao $u_C$",'Interpreter','latex')
        xlabel("Tempo (s)")
        ylabel("Tensão (V)")
    elseif flag_plot == 3
        plot_str = 'iL';
        title("Efeito de $" + variant + "$ na Corrente $i_L$",'Interpreter','latex')
        xlabel("Tempo (s)")
        ylabel("Corrente (A)")
    elseif flag_plot == 4
        plot_str = 'iRL';
        title("Efeito de $" + variant + "$ na Corrente $i_{RL}$",'Interpreter','latex')
        xlabel("Tempo (s)")
        ylabel("Corrente (A)")
    end
    
    grid on
    legend(leg)

    if toPNG == 1
        variant = erase(variant, '_');
        variant = erase(variant, '{');
        variant = erase(variant, '}');
    
        % Export plot to PNG
        saveas(gcf, append('./images/plot_bb_ma_',variant,'_',plot_str,'.png'))
    end
end
