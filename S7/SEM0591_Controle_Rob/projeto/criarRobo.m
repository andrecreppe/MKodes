function [meuRobo, configuracoes] = criarRobo()
% Cria um robô a partir da definição das juntas
% utilizando a função do matlab RigidBodyTree
%
% MEUROBO = criarRobo retorna um robô com três juntas, 
% sendo uma delas prismática.
%
% [MEUROBO, CONFIGURACOES] = criarRobo também retorna algumas 
% configurações (posições) do robô em CONFIGURACOES.
%
% Notas::
% - As unidades em Sistema Internacional (SI).
%
% Exemplos:
%   meuRobo = criarRoboTresJuntas('row')
%   [meuRobo, configuracoes] = criarRoboTresJuntas('column')
% Parâmetros de Denavit-Hartenberg (DH):
%
% Cada junta é associada a quatro parâmetros:
% - a: Distância entre a origem do link anterior e a origem do link atual ao longo do eixo x do link anterior.
% - alpha: Ângulo entre o eixo z do link anterior e o eixo z do link atual ao longo do eixo x do link anterior.
% - d: Distância entre a origem do link anterior e a origem do link atual ao longo do eixo z do link atual.
% - theta: Ângulo entre o eixo x do link anterior e o eixo x do link atual ao longo do eixo z do link atual.
%
% Esses parâmetros são usados para definir a transformação entre cada par de links consecutivos (setFixedTransform).

% Inicializando o robô
meuRobo = rigidBodyTree(DataFormat='row');

% Definindo o corpo base do robô
corpoBase = rigidBody('base_base');

% Definindo distancias dos ekis
l1 = 0.130;  l2 = 0.100;  l3 = 0.030;

% Juntas e links

% Link 1 - Junta Prismática
link1 = rigidBody('link1');
junta1 = rigidBodyJoint('j1', 'revolute');
junta1.setFixedTransform([0 pi/2 l1 0], 'dh'); % DH: [a alpha d theta]
junta1.PositionLimits = deg2rad([-90 90]); % Limites de posição em graus
link1.Joint = junta1;
% Definindo a inércia do Link 1
link1.Mass = 0.554; % Massa em kg
link1.CenterOfMass = [0, 0, 0.0456]; % Centro de massa em metros

% Link 2 - Junta Revoluta
link2 = rigidBody('link2');
junta2 = rigidBodyJoint('j2', 'revolute');
junta2.setFixedTransform([0 -pi/2 l2 0], 'dh'); % DH: [a alpha d theta]
junta2.PositionLimits = deg2rad([0 180]); % Limites de posição em graus
link2.Joint = junta2;
% Definindo a inércia do Link 2
link2.Mass = 0.137; % Massa em kg
link2.CenterOfMass = [0, 0.025, 0.015]; % Centro de massa em metros
link2.Inertia = rvc.internal.inertiaToBodyFrame([221091.55e-9, 66300.35e-9, 205442e-9, 0, 0, 0], link2.Mass, link2.CenterOfMass); % Inércia [Ixx Iyy Izz Iyz Ixz Ixy]

% Link 3 - Junta Revoluta
link3 = rigidBody('link3');
junta3 = rigidBodyJoint('j3', 'revolute');
junta3.setFixedTransform([0 0 l3 0], 'dh'); % DH: [a alpha d theta]
junta3.PositionLimits = deg2rad([-90 90]); % Limites de posição em graus
link3.Joint = junta3;
% Definindo a inércia do Link 3
link3.Mass = 0.0603; % Massa em kg
link3.CenterOfMass = [0, 0, 0.015]; % Centro de massa em metros
link3.Inertia = rvc.internal.inertiaToBodyFrame([27520.35e-9, 27520.35e-9, 18849.5e-9, 0, 0, 0], link3.Mass, link3.CenterOfMass); % Inércia [Ixx Iyy Izz Iyz Ixz Ixy]

% Montando o robô
meuRobo.addBody(corpoBase, 'base');
meuRobo.addBody(link1, 'base');
meuRobo.addBody(link2, link1.Name);
meuRobo.addBody(link3, link2.Name);

% Configurações do robô
configuracoes.inicial = [0, 0, 0]; % Configuração contraída
configuracoes.lixeira = [pi/2, -2*pi/3, pi/6]; % Configuração de pegar lixo
configuracoes.cacamba = [0, pi/6, pi/6]; % Configuração de esvaziar lixo

% Adicionando Malhas STL para Renderização

link1.addVisual('Mesh', 'D:\Programming\MKodes\S7\SEM0591_Controle_Rob\trabalho\junta1.stl');
link2.addVisual('Mesh', 'D:\Programming\MKodes\S7\SEM0591_Controle_Rob\trabalho\junta2.stl');
link3.addVisual('Mesh', 'D:\Programming\MKodes\S7\SEM0591_Controle_Rob\trabalho\junta3.stl');

end

% Exemplo de uso:
% [robo, config] = criarRobo();
% showdetails(robo);
% show(robo, config.extendido);

% Cores do Plot
% Verde / Amarelo -> Junta 1
% Magenta / Azul -> Junta 2
% Ciano / Vermelho -> Junta 3
