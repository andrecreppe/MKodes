% main.m
% ========== Inicializacao ==========

close all
clear all
clc

% ========== Controle ==========

% aberto = 0 -> Circuito cruzado
% aberto = 1 -> Circuito aberto
aberto = 0;

graphics = 0; % Roda os graficos
simulation = 0; % Roda a simulacao
    outvid = 0; % Gerar gif da simulacao
    filename = 'barrasAbertas.gif';

% ========== Problema ==========

% nUSP = 118029(72)
del = (72/4);

a = (40 - del)/1000; % mm -> m
b = (120 + del)/1000;
c = (80 - del)/1000;
d = (100 + del)/1000;

BP = 0.07; 
tBP = pi/4;

t2i = 40/180* pi; 
w2 = 4* pi; 
alpha2 = 0;

% Chutes iniciais
if aberto
    t3 = 20.30/180 * pi ; t4 = 57.33/180 * pi;
else
    t3 = -60.98/180 * pi; t4 = -98.01/180 * pi;
end
 
% Numero de passos e tolerancia
N = 1000;
tol = 0.001;
t = linspace(0, 1, N)';

% Grandezas vetoriais
t2v = t2i + w2*t ;
w2v = w2*ones(size(t));
a2v = zeros(size(t));

% Metodo de Newton-Raphson
for it2 = 1:length(t2v)
    t2 = t2v(it2); 
    B = tol+1; 
    iconv = 0;
  
    while norm (B) > tol
        iconv = iconv+1;
        A = [-b*sin(t3) c*sin(t4); 
              b*cos(t3) -c*cos(t4)];
        B = [a*cos(t2)+b*cos(t3)-c*cos(t4)-d; 
             a*sin(t2)+b*sin(t3)-c*sin(t4)];
        Dt = -A \ B ;
        t3 = t3 + Dt(1); 
        t4 = t4 + Dt(2);
    end

    %if iconv >2 disp ([ it2 iconv ]) , end % Iteracoes ate convergir
    t3v(it2,1) = t3; 
    t4v(it2,1) = t4;

    % Velocidades Angulares
    w3 = (a/b)*w2*((sin(t4-t2))/(sin(t3-t4)));
    w4 = (a/c)*w2*((sin(t2-t3))/(sin(t4-t3)));
    w3v(it2,1) = w3;
    w4v(it2,1) = w4;

    % Velocidades Lineares
    vA = a*w2 ;
    vB = c*w4 ;
    vAv(it2,1) = vA;
    vBv(it2,1) = vB;

    % Aceleracoes Angulares
    A = c*sin(t4);
    B = b*sin(t3);
    C = a*alpha2*sin(t2)+a*(w2)^2*cos(t2)+b*(w3)^2*cos(t3)-c*(w4)^2*cos(t4);
    D = c*cos(t4);
    E = b*cos(t3);
    F = a*alpha2*cos(t2)-a*(w2)^2*sin(t2)-b*(w3)^2*sin(t3)+c*(w4)^2*sin(t4);

    alpha3 = ((C*D)-(A*F))/((A*E)-(B*D));
    alpha4 = ((C*E)-(B*F))/((A*E)-(B*D));
    alpha3v(it2,1) = alpha3;
    alpha4v(it2,1) = alpha4;
    
    %Aceleracoes Lineares
    aA=((w2^2*a)^2+(alpha2*a)^2)^(1/2);%acel.lin.A
    aB=((w4^2*c)^2+(alpha4*c)^2)^(1/2);%acel.lin.B
    aAv(it2,1)=aA;
    aBv(it2,1)=aB;
end

% ========== Graficos ==========

if graphics
    %Velocidade Angular Elo 3 e 4
    figure
    plot(t,w3v,'r')
    hold on
    plot(t,w4v,'b')
    hold off
    grid on
    xlabel('Tempo (s)')
    ylabel('(rad/s)')
    title('Velocidade Angular x Tempo')
    legend('\omega_3','\omega_4')

    % Aceleracao Angular Elo 3 e 4
    figure
    plot(t,alpha3v, 'color', [0.5 0 0.9])
    hold on
    plot(t,alpha4v,'g')
    hold off
    grid on
    xlabel('Tempo (s)')
    ylabel('(rad/s)')
    title('Acelerao Angular x Tempo')
    legend('\alpha_3','\alpha_4')

    % Velocidade Linear A e B
    figure
    plot(t,vAv, 'color', [1 0.75 0])
    hold on
    plot(t,vBv, 'color', [0.2 0.9 0.9])
    hold off
    grid on
    xlabel('Tempo (s)')
    ylabel('(m/s)')
    title('Velocidade Linear x Tempo')
    legend('vA','vB')

    % Aceleracao Linear A
    figure
    plot(t,aAv,'k')
    hold on
    plot(t,aBv, 'm')
    hold off
    grid on
    xlabel('Tempo(s)')
    ylabel('(m/s^2)')
    title('Acelerao Linear x Tempo')
    legend('aA','aB')
end

% Valores Minimos e Maximos
min3_velA = min( w3v )
max3_velA = max( w3v )
min3_acelA = min( alpha3v )
max3_acelA = max( alpha3v )
min4_velA = min( w4v )
max4_velA = max( w4v )
min4_acelA = min( alpha4v )
max4_acelA = max( alpha4v )
minA_vel = min( vAv )
maxA_vel = min( vAv )
minA_acel = min( aAv )
maxA_acel = max( aAv )
minB_vel = min( vBv )
maxB_vel = max( vBv )
minB_acel = min( aBv )
maxB_acel = max( aBv )

% Posicao dos pontos A,B,C,D,P
rA = zeros(length(t2v), 2);
rB = a*[cos(t2v) sin(t2v)];
rC = rB+b*[cos(t3v) sin(t3v) ];
rD = [rA(:,1)+d rA(:,2)];
rP = rB + BP*[cos(t3v+tBP) sin(t3v+tBP)];

% ========== Simulacao ==========

if ~simulation 
    return
end

posInit = [420 70 750 650];
figure(5), clf, set(5,'position', posInit)

if outvid == 1
  frame = getframe(gcf); im = frame2im(frame) ; [A, map]=rgb2ind(im,256);
  imwrite(A, map, filename , 'gif', 'LoopCount', Inf, 'DelayTime', 1e-3);
end

rT = [rA; rB; rC; rD; rP]; mx = max(max(abs(rT)));
rT = [rA; rB; rC; rD]; mx = max(max(abs(rT))); axis([-mx mx -mx mx]) ,
axis tight, axis equal, axis off,
hBP = line([rB(1,1) rP(1,1)], [rB(1,2) rP(1,2)]); set(hBP,'Color','b','LineStyle','-','Marker','o'),
hPC = line([rP(1,1) rC(1,1)], [rP(1,2) rC(1,2)]); set(hPC,'Color','b','LineStyle','-','Marker','o'),
hAB = line([rA(1,1) rB(1,1)], [rA(1,2) rB(1,2)]); set(hAB,'Color','k','linewidth',1.5,'LineStyle','-','Marker','o'),
hBC = line([rB(1,1) rC(1,1)], [rB(1,2) rC(1,2)]); set(hBC,'Color','k','linewidth',1.5,'LineStyle','-','Marker','o'),
hCD = line([rC(1,1) rD(1,1)], [rC(1,2) rD(1,2)]); set(hCD,'Color','k','linewidth',1.5,'LineStyle','-','Marker','o'),
hDA = line([rD(1,1) rA(1,1)], [rD(1,2) rA(1,2)]); set(hDA,'Color','k','linewidth',1.5,'LineStyle','-','Marker','o'), 
hABo = line([rA(1,1) rB(1,1)], [rA(1,2) rB(1,2)]); set(hABo,'Color',.7*[1 1 1],'LineStyle',':'), 
hBCo = line([rB(1,1) rC(1,1)], [rB(1,2) rC(1,2)]); set(hBCo,'Color',.7*[1 1 1],'LineStyle',':'),
hCDo = line([rC(1,1) rD(1,1)], [rC(1,2) rD(1,2)]); set(hCDo,'Color',.7*[1 1 1],'LineStyle',':'),
hDAo = line([rD(1,1) rA(1,1)], [rD(1,2) rA(1,2)]); set(hDAo,'Color',.7*[1 1 1],'LineStyle',':'),
text(rA(1,1)-mx/100, rA(1,2)-mx/20, 'A')
text(rB(1,1)-mx/100, rB(1,2)-mx/20, 'B')
text(rC(1,1)-mx/100, rC(1,2)-mx/20, 'C')
text(rD(1,1)-mx/100, rD(1,2)-mx/20, 'D')
text(rP(1,1)-mx/100, rP(1,2)-mx/20, 'P')

if outvid ==1 dts = 5; 
else dts = 1;
end

for n =2:dts:length(t)
  set(hAB,'xdata',[rA(n,1) rB(n,1)],'ydata',[rA(n,2) rB(n,2)]);
  set(hBC,'xdata',[rB(n,1) rC(n,1)],'ydata',[rB(n,2) rC(n,2)]);
  set(hCD,'xdata',[rC(n,1) rD(n,1)],'ydata',[rC(n,2) rD(n,2)]);
  set(hBP,'xdata',[rB(n,1) rP(n,1)],'ydata',[rB(n,2) rP(n,2)]);
  set(hPC,'xdata',[rP(n,1) rC(n,1)],'ydata',[rP(n,2) rC(n,2)]);
  hB = line([rB(n-1,1) rB(n,1)],[rB(n-1,2) rB(n,2)]); set(hB,'Color','r','LineStyle','--');
  hC = line([rC(n-1,1) rC(n,1)],[rC(n-1,2) rC(n,2)]); set(hC,'Color','r','LineStyle','--');
  hP = line([rP(n-1,1) rP(n,1)],[rP(n-1,2) rP(n,2)]); set(hP,'Color','g','LineStyle','--');
  if outvid ==1
    frame = getframe(gcf); im=frame2im(frame); [A, map] = rgb2ind(im,256);
    imwrite (A, map, filename,'gif','WriteMode','append','DelayTime',1e-3);
  else pause (1e-12);
  end
end
