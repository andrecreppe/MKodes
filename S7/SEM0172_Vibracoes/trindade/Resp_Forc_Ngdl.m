%%%--- Inicializacao
clear all, close all, clc, warning off,
inp='s';

%%%--- Entrada de dados do sistema
%M=eye(2); K=[2 -1;-1 2]; c=eye(size(M));
%M=eye(3); K=[2 -1 0;-1 2 -1;0 -1 2]; c=eye(size(M));
%M=eye(5); K=[2 -1 0 0 0;-1 2 -1 0 0;0 -1 2 -1 0;0 0 -1 2 -1;0 0 0 -1 2]; c=eye(size(M));
%M=eye(7); K=[2 -1 0 0 0 0 0;-1 2 -1 0 0 0 0;0 -1 2 -1 0 0 0;0 0 -1 2 -1 0 0;0 0 0 -1 2 -1 0;0 0 0 0 -1 2 -1;0 0 0 0 0 -1 2]; c=eye(size(M));
M=eye(9); K=[2 -1 0 0 0 0 0 0 0;-1 2 -1 0 0 0 0 0 0;0 -1 2 -1 0 0 0 0 0;0 0 -1 2 -1 0 0 0 0;0 0 0 -1 2 -1 0 0 0;0 0 0 0 -1 2 -1 0 0;0 0 0 0 0 -1 2 -1 0;0 0 0 0 0 0 -1 2 -1;0 0 0 0 0 0 0 -1 2]; c=eye(size(M));

%%%--- Calculo de autovalores e autovetores
disp('--- Autovalores e autovetores ---')
[v,d]=eig(K,M); d=sqrt(diag(d)); 
disp('Frequencias naturais, omega (rad/s)')
omega=(d'); disp(omega)
disp('Modos de vibracao, phi (normalizados pela massa)')
disp(v)

%%%--- Definicao da matriz de amortecimento
%D=.005*M+.005*K; %proporcional
D=2*.01*(M*v*diag(d)*v'*M); %modal
%D=0.00000001*M; %"nula"
Lambda=v'*D*v; zeta=(1/2)*diag(Lambda)./d;

if inp=='s'
%%%--- Rotina para mostrar animacao dos modos de vibracao
disp('--- Animacao dos modos de vibracao ---')
figure(3), set(3,'position',[1046 64 560 420])
Nr=1; %numero de repeticoes
nm=size(v,2); if nm>9 nm=9; end, %numero de modos a serem mostrados
for jd=1:Nr
    for id=[.8:-.2:-1 -.8:.2:-.2 0:.2:1]/2
        clf, hold on,
        for m=1:nm
            text(1,1.5+1-m,[num2str(m) '$^{o}$ modo'])
            plot([1:length(d)]'+v(:,m)*0,ones(length(d),1)+1-m,'r--o',[1:length(d)]'+id*v(:,m),ones(length(d),1)+1-m,'b-s')
        end
        axis([0.5 3.5-3+length(d) -1.5+3-nm 2]), hold off, pause(1e-1*3/length(d))
    end
end
pause
end

%%%--- Posicao do forcamento
b=zeros(size(M,1),1); b(1)=1; % Forca na primeira massa
%b=v(:,1); % Forca paralela a modos de vibracao
%b=v(:,2); % Forca paralela a modos de vibracao
%b=1*v(:,1)+1*v(:,2)+1*v(:,3); % Forca paralela a modos de vibracao

%%%--- Posicao da medicao de deslocamento
cid=1; % Massa cujo deslocamento e medido

%%%--- Montagem do sistema no espaco de estados
A=[zeros(size(M)) eye(size(M)); -M\K -M\D];
B=[zeros(size(b)); M\b];
C=[c zeros(size(c))];
sys=ss(A,B,C,0);

%%%--- Calculo e plot da FRF usando sistema de 2a ordem
disp('--- Resposta em frequencia usando 2a ordem ou Espaco de Estados ---')
figure(2), set(2,'position',[1046 558 875 420])
%subplot(131)
om=[min(d)/10:.001:max(d)*2];
for i1=1:length(om)
    H(i1)=c(cid,:)*((-om(i1)^2*M+i*om(i1)*D+K)\b);
end
h1a=plot(om,db(H),'g-'); %axis([min(om) max(om) -100 50]);
xlabel('Frequencia (rad/s)'), ylabel('Amplitude (dB)'),
%title('FRF calculada usando sistema de 2a ordem')

hold on, %subplot(132)
H=zeros(size(om)); cv=c(cid,:)*v; vb=v'*b;
for i1=1:length(om)
    for j1=1:length(d)
        H(i1)=H(i1)+(cv(j1)*vb(j1))/(-om(i1)^2+d(j1)^2+2*i*zeta(j1)*om(i1)*d(j1));
    end
end
h1b=plot(om,db(abs(H)),'b--'); %axis([min(om) max(om) -100 50]);
xlabel('Frequencia (rad/s)'), ylabel('Amplitude (dB)'),
%title('FRF calculada usando superposicao modal')

%%%--- Calculo e plot da FRF usando sistema no espaco de estados
hold on, %subplot(133)
aH=bode(sys(cid,1),om); aH=aH(:);
h1c=plot(om,db(aH),'r-.'); %axis([min(om) max(om) -100 50]);
xlabel('Frequencia (rad/s)'), ylabel('Amplitude (dB)'),
%title('FRF calculada usando sistema no espaco de estados')

legend('Sistema de 2a ordem','Superposicao modal','Sistema no espaco de estados')
grid on,
pause

%%%--- Resposta transitoria
disp('--- Resposta transitoria sujeito a forcamento impulsivo ---')
for id=1:4
%%%--- Posicao do forcamento
if     id==1 b=zeros(size(M,1),1); b(1)=1; disp('++ Entrada na primeira massa')
elseif id==2 b=v(:,1); disp('++ Entrada paralela ao 1o modo de vibracao')
elseif id==3 b=v(:,2); disp('++ Entrada paralela ao 2o modo de vibracao')
elseif id==4 if size(v,2)>2 b=0*v(:,1)+1*v(:,2)+1*v(:,3); disp('++ Entrada paralela aos modos 2 e 3'); end
end

%%%--- Posicao da medicao de deslocamento
cid=1; % Massa cujo deslocamento e medido

%%%--- Montagem do sistema no espaco de estados
A=[zeros(size(M)) eye(size(M)); -M\K -M\D];
B=[zeros(size(b)); M\b];
C=[c zeros(size(c))];
sys=ss(A,B,C,0);

[y,t]=impulse(sys); tmax=min([max(t) 50]); [y,t]=impulse(sys,[0:1e-1:tmax]);
figure(1), set(1,'position',[485 558 560 914])
simmma(t,y(:,1:size(M,1)))
pause

end

%%%--- Resposta transitoria
disp('--- Resposta sujeito a forcamento harmonico ---')
b=zeros(size(M,1),1); b(1)=1; disp('++ Forca na primeira massa')
%%%--- Montagem do sistema no espaco de estados
A=[zeros(size(M)) eye(size(M)); -M\K -M\D];
B=[zeros(size(b)); M\b];
C=[c zeros(size(c))];
sys=ss(A,B,C,0);

omex=omega(2);
[y,t]=impulse(sys); tmax=min([max(t) 60]); th=[0:1e-1:tmax]; [y,t]=lsim(sys,sin(omex*th),th);
figure(1), set(1,'position',[485 558 560 914])
simmma(t,y(:,1:size(M,1)))
pause

%%%--- Resposta transitoria
disp('--- Resposta sujeito a bump meio seno ---')
b=zeros(size(M,1),1); b(1)=1; disp('++ Forca na primeira massa')
T=2*pi/omega(1)*4; T=30; ti=5; Amp=10;
th=[0:1e-1:60]; [y,t]=lsim(sys,meioseno(th,ti,Amp,T),th);
figure(1), set(1,'position',[485 558 560 914])
simmma(t,y(:,1:size(M,1)))
