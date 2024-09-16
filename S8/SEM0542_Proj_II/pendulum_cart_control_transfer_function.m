function pendulum_cart_control_transfer_function(plot_pos, plot_ang, plot_anim)
    % Parâmetros do sistema
    mt = 0.250; % Massa carrinho (kg)
    ml = 0.5; % Massa da haste (kg)
    l = 0.6;  % Comprimento da haste (m)
    g = 9.81; % Aceleração da gravidade (m/s^2)
    Bt = 0.25; % Coeficiente de amortecimento da haste
    Bl = 0.1; % Coeficiente de amortecimento do carrinho

    % Definir s como variável simbólica para funções de transferência
    s = tf('s');
    
    % Função de transferência para x(s) / Ft(s)
    X_Ft = (ml*l^2*s^2 + Bl*s + ml*g*l) / ...
        (s^4*(mt*ml*l^2 + ml^2*l^3 - ml^2*l^2) + s^3*(Bl*mt + Bl*ml^2) + ...
        s^2*(mt*ml*g*l + ml^2*g*l) + s*(Bt*Bl + Bt*ml*g*l) + Bl*ml*g*l);

    % Função de transferência para theta(s) / Ft(s)
    Theta_Ft = (s*ml*l) / ...
        (-mt*ml*l^2*s^3 - s^2*(Bl*mt + Bl*ml + Bt*ml*l^2) - s*(Bt*Bl + mt*ml*g*l + ml^2*g*l) - Bt*ml*g*l);

    % Controladores PID - ajustados
    Kp_x = 20; Ki_x = 7; Kd_x = 15;
    Kp_theta = 5.8757e-05; Ki_theta = 3.2605e-04; Kd_theta = 7.3272e-05;

    PID_x = pid(Kp_x, Ki_x, Kd_x);
    PID_theta = pid(Kp_theta, Ki_theta, Kd_theta);

    % Sistema em malha fechada para o controle da posição do carrinho
    Closed_Loop_X = feedback(PID_x * X_Ft, 1);

    % Sistema em malha fechada para o controle da angulação da haste
    Closed_Loop_Theta = feedback(PID_theta * Theta_Ft, 1);

    % Simulação da resposta do sistema para um degrau de referência
    t = 0:0.01:10;
    r = 0.2; % Posição desejada do carrinho (m)
    [y_x, t_x] = step(r*Closed_Loop_X, t);
    [y_theta, t_theta] = step(Closed_Loop_Theta, t);

    % Criação das figuras para gráficos e animação
    figure_position = figure('Name', 'Posição do Carrinho x(t)');
    figure_angle = figure('Name', 'Ângulo da Haste θ(t)');
    figure_animation = figure('Name', 'Animação do Pêndulo');

    % Loop para atualizar os gráficos e a animação em tempo real
    for i = 1:length(t_x)
        % Atualizar gráfico da posição do carrinho
        if(plot_pos)
            figure(figure_position);
            plot(t_x(1:i), y_x(1:i), 'b', 'LineWidth', 2);
            title('Posição do Carrinho x(t)');
            xlabel('Tempo (s)');
            ylabel('Posição (m)');
            grid on;
        end
        
        % Atualizar gráfico do ângulo da haste
        if(plot_ang)
            figure(figure_angle);
            plot(t_theta(1:i), y_theta(1:i), 'r', 'LineWidth', 2);
            title('Ângulo da Haste θ(t)');
            xlabel('Tempo (s)');
            ylabel('Ângulo (rad)');
            grid on;
        end
        
        % Atualizar animação do pêndulo e carrinho
        if(plot_anim)
            figure(figure_animation);
            clf;
            hold on;
    
            % Desenhar o trilho
            plot([-0.3 0.3], [0 0], 'k-', 'LineWidth', 2);
    
            % Desenhar o carrinho
            rectangle('Position', [y_x(i)-0.05, -0.05, 0.1, 0.05], 'FaceColor', [0 0 0]);
    
            % Desenhar a haste do pêndulo
            plot([y_x(i), y_x(i) + l * sin(y_theta(i))], [0, -l * cos(y_theta(i))], 'r-', 'LineWidth', 2);
    
            % Desenhar a massa do pêndulo
            plot(y_x(i) + l * sin(y_theta(i)), -l * cos(y_theta(i)), 'bo', 'MarkerSize', 10, 'MarkerFaceColor', 'b');
    
            % Ajustar os eixos
            axis([-0.3 0.3 -l 0.5]);
            axis equal;
            xlabel('Posição do Carrinho (m)');
            ylabel('Altura (m)');
            title(sprintf('Tempo: %.2f s', t_x(i)));
            grid on;
    
            %pause(0.05);  % Controle de velocidade da animação
            exportgraphics(gcf, 'testAnimated.gif', 'Append', true); % fazer gif
        end
    end
end
