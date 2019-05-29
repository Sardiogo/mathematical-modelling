%% Trabalho de Laborat�rio n�2 - Optimiza��o do servomecanismo de um disco r�gido
% 
%   Autor: Diogo Vilar Sardinha
%  
%%
close all;
n=1;
% inicializa��o do contador para as figuras
%% Quest�o 1 - express�o anal�tica
%
n=1; % inicializa��o do contador para as figuras
figure(n)
n=n+1;I = imread('./figures/Scan10001.jpg');
imshow(I);
%% Quest�o 2 - Gera��o do impulso prot�tipo
%%
% beta pertence ao intervalo [0,1].  
% beta controla a suavidade dos flancos dos impulsos.
beta = 0.6;
% cria��o do vector com os instantes de tempo
t_min=-1;
t_max=1;
p=100; % n�mero de pontos para a escala do tempo
t=linspace(t_min,t_max,p); 
% geradora - Fun��o que gera o impulso prot�tipo.
impulso = geradora_pb(t,beta);

hold all;
figure(n);
n=n+1;
plot(t,impulso);
XMIN=-1; XMAX=1; YMIN=0; YMAX=1.5;
axis ([XMIN XMAX YMIN YMAX]);
grid on
xlabel('Tempo');
ylabel('Amplitude do impulso');
title('Impulso Prot�tipo');

%% Quest�o 3 - Gera��o de um sinal de controlo u(t)
%%
% Nesta quest�o pretende-se apenas testar se a fun��o para  criar u(t),
% est� correcta, definindo assim valores arbitr�rios para as amplitudes 
% U1 e U2, para alpha, beta e valores de T.

% dura��o total da forma de onda
T = 1;
alpha = 1.5;
% n�mero de pontos para a escala do tempo de cada um dos impulsos
n1 = 100;
n2 = 100; 
% Amplitudes
U1 = -1.5;
U2 = 1;
% Sinal u(t) e sua dura��o
[ut, tempo] = geradora_ut(T,alpha,beta,U1,U2,n1,n2);

figure(n);
n=n+1;
plot(tempo,ut);
grid on
xlabel('Tempo');
ylabel('Amplitude');
title('Sinal de controlo u(t)');
%% Quest�o 4 - �rea de uma vers�o escalada em amplitude e no tempo
%
n=1; % inicializa��o do contador para as figuras
figure(n)
n=n+1;I = imread('./figures/Scan10002.png');
imshow(I);
%% Quest�o 7 - Testes da din�mica do sistema para diferentes par�metros
%%
% Nesta quest�o simulamos a dinamica do sistema para diferentes valores dos
% parametros que comp�em o sinal de comcontrolo u(t) 

%%
% Diagrama de blocos que simula a din�mica do servomecanismo do disco
% r�gido
open_system('dinamicadosistema')

% dura��o total do sinal de entrada u(t) (de controlo)
T = 1;
% n�mero de pontos para a escala do tempo de cada um dos impulsos de u(t)
n1 = 100;
n2 = 100; 
% Amplitudes
U1 = -1;
U2 = 1;
%Parametros a testar
beta_aux=[1 0.3 0.5 0.0001];
alpha_aux=[0.5 1 2 1];
%Estados Iniciais
dy0=0; 
y0=1;

%%
% Sinais de controlo u(t) 

% Simula��es sem perturba��o do sistema com efeito de atrito (b=0)
b=0;
figure(n)
fig = figure(n);
set(fig, 'Position', [0, 0, 700, 500])  % x, y, largura e comprimento da figura
n=n+1;
hold all;
for k=1:4 
    beta = beta_aux(k);
    alpha = alpha_aux(k);
    [ut, tempo] = geradora_ut(T,alpha,beta,U1,U2,n1,n2);
    entrada = [tempo' ut'];
    sim('dinamicadosistema',tempo);
    plot(tempo,ut,'DisplayName', ['{\beta }=',num2str(beta),', {\alpha }=',num2str(alpha),', b=',num2str(b)]);
end
xlabel('Tempo');
ylabel('Amplitude');
title('Sinais de controlo u(t)');
grid on
legend('show')


%%
% Velocidades angulares para diferentes parametros

% Simula��es sem perturba��o do sistema com efeito de atrito (b=0)
b=0;
figure(n)
fig = figure(n);
set(fig, 'Position', [0, 0, 800, 500])  % x, y, largura e comprimento da figura
n=n+1;
subplot(1,2,1)
hold all;
for k=1:4 
    beta = beta_aux(k);
    alpha = alpha_aux(k);
    [ut, tempo] = geradora_ut(T,alpha,beta,U1,U2,n1,n2);
    entrada = [tempo' ut'];
    sim('dinamicadosistema',tempo);
    plot(tout,v,'DisplayName', ['Sinais {\beta }=',num2str(beta),', {\alpha }=',num2str(alpha),', b=',num2str(b)]);
end
xlabel('Tempo');
ylabel('Velocidade Angular');
title('Velocidades angulares sem efeito de atrito');
grid on
legend('show')   


% Simula��es com perturba��o do sistema com efeito de atrito (b=0.025)
b=0.025;
subplot(1,2,2)
hold all;
for k=1:4 
    beta = beta_aux(k);
    alpha = alpha_aux(k);
    [ut, tempo] = geradora_ut(T,alpha,beta,U1,U2,n1,n2);
    entrada = [tempo' ut'];
    sim('dinamicadosistema',tempo);
    plot(tout,v,'DisplayName', ['Sinais {\beta }=',num2str(beta),', {\alpha }=',num2str(alpha),', b=',num2str(b)]);
end
xlabel('Tempo');
ylabel('Velocidade Angular');
title('Velocidades angulares com efeito de atrito');
grid on
legend('show')   

%%
% Posi��es angulares para diferentes parametros

% Simula��es sem perturba��o do sistema com efeito de atrito (b=0)
b=0;
figure(n)
fig = figure(n);
set(fig, 'Position', [0, 0, 700, 500])  % x, y, largura e comprimento da figura
n=n+1;
subplot(1,2,1)
hold all;
for k=1:4 
    beta = beta_aux(k);
    alpha = alpha_aux(k);
    [ut, tempo] = geradora_ut(T,alpha,beta,U1,U2,n1,n2);
    entrada = [tempo' ut'];
    sim('dinamicadosistema',tempo);
    plot(tout,y,'DisplayName', ['Sinais {\beta }=',num2str(beta),', {\alpha }=',num2str(alpha),', b=',num2str(b)]);
end
xlabel('Tempo');
ylabel('Posi��o');
title('Posi��o angular sem efeito de atrito');
grid on
legend('show')   


% Simula��es com perturba��o do sistema com efeito de atrito (b=0.025)
b=0.025;
subplot(1,2,2)
hold all;
for k=1:4 
    beta = beta_aux(k);
    alpha = alpha_aux(k);
    [ut, tempo] = geradora_ut(T,alpha,beta,U1,U2,n1,n2);
    entrada = [tempo' ut'];
    sim('dinamicadosistema',tempo);
    plot(tout,y,'DisplayName', ['Sinais {\beta }=',num2str(beta),', {\alpha }=',num2str(alpha),', b=',num2str(b)]);
end
xlabel('Tempo');
ylabel('Posi��o');
title('Posi��o angular com efeito de atrito');
grid on
legend('show')   

%%
% Infelizmente devido � falta de tempo n�o foi feita a analise teorica 
% correctamente. Os valores finais da velocidade e da posi��o da cabe�a do
% disco deviam tender para zero o que n�o se verifica em todos os casos. 
% Para al�m disto o modelo n�o apresenta diferen�as significativas quando 
% se considera o efeito de atrito (b>0), o que n�o devia ser verdade pois 
% o atrito leva a que n�o seja antingida a posi��o pertendida e ocorreria 
% uma redu��o de velocidade.

%% Quest�o 8 - 
%%

open_system('P8');

y=linspace(-5,5,100); 
dy=linspace(-5,5,100);
        
sim('P8')

figure(n)
n=n+1;
surf(u);colorbar;
title('Pergunta 8 - Fun��o de Gera��o u(y,dy)')
xlabel('Posi��o')
ylabel('Velocidade')
zlabel('u')





