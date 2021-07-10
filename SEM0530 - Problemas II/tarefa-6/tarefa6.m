% tarefa6.m
clear all
close all

% Ajustes de
% velocidade
    tick = 0.01;    % visualizacao
    %tick = 0.005   % gravacao

% Rotacao
    isSteps = true; % rotacao em etapas (steps) ou junta

% Gravacao
    canRecord = false;          % faz o video
    fileName = 'plotAnimado';   % nome.avi

% Enunciado
gradmax = -((90 + 72) / 4); % 119029(72)
thmax = gradmax * (pi/180);
th = [0:-tick:thmax];

% Preparo 
if isSteps
    % Rotacao em Passos
    thxv = [th th(end)+0*th th(end)+0*th]; 
    thyv = [0*th th th(end)+0*th];
    thzv = [0*th 0*th th];
else 
    % Rotacao Simultanea
    thxv = th;
    thyv = th;
    thzv = th;
end

% Rotacao 
for id=1:length(thxv)
    thix = thxv(id);
    thiy = thyv(id);
    thiz = thzv(id);
    
    Rx = [
        1 0 0;
        0 cos(4*thix) -sin(4*thix);
        0 sin(4*thix) cos(4*thix)
    ];
    Ry = [
        cos(thiy) 0 sin(thiy);
        0 1 0;
        -sin(thiy) 0 cos(thiy)
    ];
    Rz = [
        cos(thiz) -sin(thiz) 0;
        sin(thiz) cos(thiz) 0;
        0 0 1
    ];
    
    R(:,:,id) = Rz*Ry*Rx;
end

% Visualizacao
fcnrot3d(R, canRecord, fileName)
