%% Renderizacao do Movimento

% Escolha do usuario de compilar novamente ou usar os dados no Workspace
run_sim = false; 

if run_sim
    [robo, config] = criarRobo();

    r = sim("Controle_FeedForward");
    q = r.find("yout");
    q = q(:,1:3);
end

% Velocidade de Simulacao de acordo com a quantidade de pontos
rc = rateControl(1875/3); % 1875 points / 3 sec

for i = 1:size(q,1)
    robo.show(q(i,:), FastUpdate=true, PreservePlot=false);
    rc.waitfor;
end
