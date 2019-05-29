%% Trabalho de Laborat�rio n�3 - Din�mica de um metr�nomo b�sico
% 
%   Autor: Diogo Vilar Sardinha
%  
%%
close all;
clear;
n=1;
% inicializa��o do contador para as figuras
%% Quest�o 1 - Equa��o diferencial
%
n=1; % inicializa��o do contador para as figuras
figure(n)
n=n+1;I = imread('./figures/10001.jpg');
imshow(I);
%% Quest�o 2 - Modelo de Estado
%
figure(n)
n=n+1;
I = imread('./figures/10002.png');
imshow(I);
%% Quest�o 3 e 4 - Fun��o de Transfer�ncia
%
figure(n)
n=n+1;
I = imread('./figures/10003.png');
J = imresize(I, 0.7);
imshow(J);
figure(n)
n=n+1;
I = imread('./figures/10004.png');
J = imresize(I, 0.7);
imshow(J);
%% Quest�o 5 
%%
% Diagrama de blocos que simula a din�mica de um metr�nomo b�sico
open_system('Q5')
%%
% De acordo com o modelo obtido na prepara��o te�rica obtemos:

% Dados do enunciado:
L=0.5;      % comprimento da haste
M=0.15;     % peso da haste
l=0.4;      % Distancia a que est� a massa da origem
m=0.2;      % peso da massa
k=3;        % constante da mola
beta=0.1;   % coeficiente de atrito
g=9.8;      % acelera��o da gravidade

% Condi��es Inicias:
teta0 = 0;  % �ngulo inicial
v0 = pi/4 ; % velocidade angular inicial

% Valores do ganhos da retroac��o da velocidade angular e do �ngulo como
% � representado no diagrama de blocos:
cte1 = (beta) / ( ((M*(L^2))/3) + m*(l^2) );
cte2 = ( m*g*l + (M*g*L/2) -k ) / ( ((M*(L^2))/3) + m*(l^2) );

U=0; % Bin�rio aplicado

sim('Q5',7)

%%
% Representa��o da evolu��o do �ngulo e velocidade angular do sistema ao 
% longo do tempo:
figure(n)
n=n+1;
hold all;
subplot(2,1,1)
plot(t,teta)
xlabel('Tempo [s]')
ylabel('{\theta}   [rad]')
grid on
title('Varia��o da Posi��o angular {\theta(t)}')
subplot(2,1,2)
plot(t,v)
xlabel('Tempo [s]')
ylabel(' {d\theta }/{dt}   [rad/s]')
grid on
title('Varia��o da Velocidade angular {d\theta(t)}/{dt} ')

%%
% Representa��o da evolu��o do �ngulo e velocidade angular do sistema no
% espa�o de estados:
figure(n)
n=n+1;
plot(teta,v)
title('Representa��o das vari�veis de estado no espa�o de estados')
xlabel('{\theta}   [rad]')
ylabel('{d\theta }/{dt}    [rad/s]')
grid on
%%
% Trata-se de um foco est�vel.

%% Quest�o 6 
%%

J = ((M*(L^2))/3) + m*(l^2); % Momento de in�rcia
A = [0 1;(m*g*l+(M*g*L/2)-k)/(((M*(L^2))/3)+m*(l^2)) -beta/J];
B = [0 1]';
C = [1 0;0 1];
D = [0 0]';
x0 = [0 pi/4]';

%%
% O diagrama de Simulink que simula o sistema recorrendo a um bloco de 
% modelo de estado pr�-definido �:

open_system('Q6')

%%
% As matrizes A e B foram obtidas na resolu��o teorica.
%
% Para efeitos de simula��o, a matriz C � definida por C=[1 0;0 1]. Desta 
% forma a sa�da Y � uma matriz que cont�m as vari�veis de estado (posi��o e
% velocidade angular).
%
% A matriz D � uma matriz nula.

%% Quest�o 7 
%%
% Representa��o grafica da resposta no tempo para $\enspace$ ${\beta}$=0 e 
% $\enspace$ ${\beta}$=1.

beta_aux=[0 1];
figure(n)
fig = figure(n);
set(fig, 'Position', [0, 0, 900, 500])  % x, y, largura e comprimento da figura
n=n+1;
hold all;
for p=1:2
    beta=beta_aux(p);
    A = [0 1;(m*g*l+(M*g*L/2)-k)/(((M*(L^2))/3)+m*(l^2)) -beta/J];
    sim('Q6',4)
    
    subplot(2,2,p)
    plot(t,Y(:,1)) % Y(todas as linahs, coluna 1)
    title(['Respostas no tempo da Posi��o angular {\theta(t)} para {\beta}=',num2str(beta)])
    xlabel('Tempo [s]')
    ylabel('{\theta}  [rad]')
    grid on
    
    subplot(2,2,p+2)
    plot(t,Y(:,2)) % Y(todas as linahs, coluna 2)
    title(['Respostas no tempo da velocidade angular para {\beta}=',num2str(beta)])
    xlabel('Tempo [s]')
    ylabel('{d\theta }/{dt}  [rad/s]')
    grid on 
end

%%
% Representa��o grafica da evolu��o do sistema no plano de estado para 
% $\enspace$ ${\beta}$=0 e $\enspace$ ${\beta}$=1.

beta_aux=[0 1];
figure(n)
fig = figure(n);
set(fig, 'Position', [0, 0, 900, 350])  % x, y, largura e comprimento da figura
n=n+1;
hold all;
for p=1:2
    beta=beta_aux(p);
    A = [0 1;(m*g*l+(M*g*L/2)-k)/(((M*(L^2))/3)+m*(l^2)) -beta/J];
    sim('Q6',4)
    subplot(1,2,p)
    plot(Y(:,1),Y(:,2))
    title(['Evolu��o do sistema no plano de estado para {\beta}=',num2str(beta)])
    xlabel('{\theta}   [rad]')
    ylabel('{d\theta }/{dt}    [rad/s]')
    grid on
end

%%
% Representa��o grafica da evolu��o do sistema no plano de estado para 
% $\enspace$ ${\beta}$=0 e $\enspace$ ${\beta}$=1 considerando v�rias 
% condi��es in�ciais.

p=20; %numero de condi��es iniciais a testar
col1= linspace(-pi,pi,p); % intervalo de posi��es angulares iniciais a testar
col2= linspace(-2*pi,2*pi,p); %intervalo de velocidades nagulares iniciais a testar
x0= [col1; col2]; %inicializa��o de x0
x0_aux =  transpose(x0);
aux = size(x0_aux); %aux guarda o numero de colunas e numero de linhas
p_aux = aux(1); %p_aux guarda o n�mero de linhas

for beta=[0 0.1 1]
    figure(n)
    fig = figure(n);
    set(fig, 'Position', [0, 0, 1200, 500])  % x, y, largura e comprimento da figura
    n=n+1;
    hold all;
    for p=1:p_aux
        A = [0 1;(m*g*l+(M*g*L/2)-k)/(((M*(L^2))/3)+m*(l^2)) -beta/J];
        x0=x0_aux(p,:);
        sim('Q6',4)
        plot(Y(:,1),Y(:,2),'DisplayName',['[{\theta} , {d\theta }/{dt}] = ', num2str(x0) ])
    end
    xlabel('{\theta}   [rad]')
    ylabel('{d\theta }/{dt}    [rad/s]')
    grid on
    title(['Evolu��o do sistema no plano de estado para {\beta}=',num2str(beta)])
    legend('show')
    %Inicializa��o das matrizes que guardam as componentes horizontais e
    %verticais que constituem cada vector do campo vectorial:
    cx= zeros(p_aux,p_aux); %componente em x
    cy= zeros(p_aux,p_aux); %componente em y
    Max = max(Y);
    mini = min(Y);
    %intervalos de pontos na horizontal do campo vectorial
    xx = col1;
    %intervalos de pontos na vertical do campo vectorial:
    if abs(Max(2))<=abs(mini(2))
        yy = linspace(-mini(2),mini(2),p); 
    end
    if abs(Max(2))>=abs(mini(2))
        yy = linspace(-Max(2),Max(2),p); 
    end 
    % Cria��o da matriz que contem as componetes horizontais e
    % verticais de cada vector do campo vectorial:
    for i=1:p
        for j=1:p
            aux1=A*[xx(i);yy(j)];
            cx(j,i)=aux1(1);
            cy(j,i)=aux1(2);
        end
    end
    quiver(xx,yy,cx,cy)
    %V ectores e valores pr�prios da matriz A:
    [eigenvectors,eigenvalues] = eig(A,'matrix');
    disp(' ');
    disp(strcat('Para beta = ',num2str(beta),':'));
    disp(' ');
    disp('Matriz Modal cujas colunas s�o os Vectores Pr�prios de A:');
    disp(eigenvectors);
    disp('Matriz Diagonal dos Valores Pr�prios de A:');
    disp(eigenvalues);
end
%%
% Quando $\enspace$ ${\beta}$=0, os valores pr�prios s�o puramente 
% imagin�rios, o que origina uma resposta oscilat�ria constante, 
% representada por uma circunfer�ncia no plano de estado. 
%
% Quando $\enspace$ ${\beta}$=0.1, os valores pr�prios s�o complexos com 
% parte real negativa, o que resulta numa resposta oscilat�ria a tender 
% para a origem.
%
% Quando $\enspace$ ${\beta}$=1, os valores pr�prios s�o reais e negativos,
% o que origina uma resposta com forma exponecial a tender para zero sem 
% oscila��o.

%% Quest�o 8 
%%
% Representa��o da evolu��o no plano de estados de duas trajectorias
% rectilineas com $\enspace$ ${\beta}$=1. 
% 
% Se a condi��o inicial x0 for um m�ltiplo escalar de um dos vectores 
% pr�prios v1 ou v2, a evolu��o da trajectoria nos espa�o de estados � 
% rect�l�nea.

figure(n)
n=n+1;
I = imread('./figures/10008.png');
imshow(I);

figure(n)
n=n+1;
hold all;
for i=1:2
    x0=3*eigenvectors(:,i);
    sim('Q6',6)
    plot(Y(:,1),Y(:,2))
end
legend('x0 = 3*v1','x0 = 3*v2')
xlabel('{\theta}   [rad]')
ylabel('{d\theta }/{dt}    [rad/s]')
grid on
title(['Evolu��o do sistema no plano de estado com trajectorias rect�lineas para {\beta}=',num2str(beta)])

%% Quest�o 9 
%%
% Estimar os parametros l e m da massa na haste do metronomo

L = 0.25; %Comprimento da haste
M = 0.1; %Peso da haste
k = 0.35; %Constante da mola
beta = 0.001; %Coeficiente de atrito
g = 9.8; %Acelera��o da gravidade
U=0; %bin�rio aplicado � nulo
x0=[pi/10 pi]';

p=30; %numero de condi��es iniciais a testar
m_temp = linspace(0,0.2,p);
l_temp = linspace(0.05,L,p);
wa=zeros(p,p);

for i=1:p
    for j=1:p
        m = m_temp(i);
        l = l_temp(j);
        J = ((M*(L^2))/3) + m*(l^2); % Momento de in�rcia
        cte= m*g*l+M*g*L/2;
        wn = sqrt((k-cte)/J);
        qsi = beta/(2*J*sqrt((k-cte)/J));
        aux  = wn*sqrt(1-power(qsi,2));
        wa(i,j) = abs(aux);
    end
end

figure(n);
n = n+1;
contour(m_temp,l_temp,wa,'ShowText','on');
xlabel('massa(m)'); ylabel('Distancia da massa(l)'); colorbar;
%%
% Temos wa=2*pi*f; bpm = f*60*2; logo obtemos:
wa_50 = ((2*pi)*50)/120;  % frequ�ncia para 50bpm
wa_150 = ((2*pi)*150)/120; % frequ�ncia para 150bpm
wa_76 = ((2*pi)*76)/120;   % frequ�ncia para 76bpm
wa_124 = ((2*pi)*124)/120; % frequ�ncia para 124bpm
%%
% 150BPM equivale a uma velocidade angular de 5pi/2 rad/s ~ 7.854 rad/s
%
% 50 BPM equivale a uma velocidade angular de pi/4 rad/s ~ 0.785 rad/s
%
% 124BPM equivale a uma velocidade angular de ~ 6.4926 rad/s
%
% 76 BPM equivale a uma velocidade angular de ~ 3.9794 rad/s
%
% Analisando as curvas de nivel do gr�fico para diferentes frequencias 
% podemos dizer que m=0.09 � um valor aceitavel para a massa m.
%
% Utilizando este valor para a massa podemos determinar dois valores para a
% a distancia l (l>= 0.05) a que se encontra a massa, que permitam obter no 
% metr�nomo as velocidades angulares correspondentes a 50 BPM (lento), 
% 150 BPM (allegro), 76 BPM e 124bpm.

m=0.09;
for i=1:p
    l = l_temp(i);
    J = ((M*(L^2))/3) + m*(l^2); % Momento de in�rcia
    cte= m*g*l+M*g*L/2;
    wn = sqrt((k-cte)/J);
    qsi = beta/(2*J*sqrt((k-cte)/J));
    aux  = wn*sqrt(1-power(qsi,2));
    wa_new(i) = abs(aux);
end

figure(n);
n = n+1;
plot(l_temp,wa_new)
ylabel('Velocidade angular (wa) (rad/s)');
xlabel('Distancia da massa (l)');
grid on;

%C�lculo do comprimento da posi��o da massa para a cad�ncia de 50 BMP
[m1,ind1] = min(abs(wa_50-wa_new));
disp(strcat('Posi��o da massa para 50 BPM: l= ', num2str(l_temp(ind1))));
%C�lculo do comprimento da posi��o da massa para a cad�ncia de 150 BPM
[m2,ind2] = min(abs(wa_150-wa_new));
disp(strcat('Posi��o da massa para 150 BPM: l= ', num2str(l_temp(ind2))));
%C�lculo do comprimento da posi��o da massa para a cad�ncia de 76 BMP
[m3,ind3] = min(abs(wa_76-wa_new));
disp(strcat('Posi��o da massa para 76 BPM: l= ', num2str(l_temp(ind3))));
%C�lculo do comprimento da posi��o da massa para a cad�ncia de 124 BPM
[m4,ind4] = min(abs(wa_124-wa_new));
disp(strcat('Posi��o da massa para 124 BPM: l= ', num2str(l_temp(ind4))));

%%
% Concluimos que com m=0.09kg, se verifica:
%
% Para 150 BPM : l=0.077586.
%
% Para 50 BPM : l=0.20862.
%
% Para 124 BPM : l=0.10517.
%
% Para 76 BPM : l=0.17414.
%%
% Realizando a simula��o vamos sobrepor graficamente a evolu��o da
% oscila��o da posi��o angular e a envolvente teorica e determinar a
% frequencia de oscila��o empirica para cada uma das situa��es

U=0; % bin�rio aplicado � nulo
m = 0.1;
bpm = [50 150 76 124];
x0 = [pi/4 0]';
aux = 1; % contador auxiliar para o ciclo for

figure(n);
fig = figure(n);
set(fig, 'Position', [0, 0, 900, 500])  % x, y, largura e comprimento da figura
n = n+1;
for l=[l_temp(ind1) l_temp(ind2) l_temp(ind3) l_temp(ind4)]
    J = ((M*(L^2))/3) + m*(l^2); % Momento de in�rcia
    cte= m*g*l+M*g*L/2;
    wn = sqrt((k-cte)/J);
    qsi = beta/(2*J*sqrt((k-cte)/J));
    A = [0 1;(m*g*l+(M*g*L/2)-k)/(((M*(L^2))/3)+m*(l^2)) -beta/J];
    B = [0 1]';
    sim('Q6', 20);
    tau = exp(-qsi*wn*t); % constantes de tempo de decaimento
    subplot(2,2,aux)
    hold all;
    plot(t,Y(:,1));
    % Representar os decaimentos superior e inferior:
    plot(t, tau);
    plot(t, -tau);
    xlabel('Tempo (s)');
    ylabel('{\theta}   [rad]')
    title(strcat('Varia��o de {\theta} para ',num2str(bpm(aux)),' BPM'));
    grid on;
    % Determina��o dos valores dos picos e os seus �ndices de forma a 
    % determinar os instantes em que ocorrem:
    [picos, loc] = findpeaks(Y(:,1));   
    t_picos = zeros(1,length(loc));
    % frequencia de oscila��o entre dois picos:
    wa_e = zeros(1,length(t_picos)-1);
    % inicializa��o da variavel que guarda a soma das frequencias de
    % oscila��o entre cada par de picos:
    soma_wa = 0; 
    % Instantes de tempo em que se encontram os picos:
    for i = 1:length(t_picos)
        t_picos(i) = t(loc(i));
    end
    % calacular a frequencia em cada intervalo de tempo (t_picos(i+1) - t_picos(i))
    for i = 1:length(wa_e)
        % sabendo que : wa = 2*pi*f = (2*pi)/(tempo):
        wa_e(i) = (2*pi) ./ (t_picos(i+1) - t_picos(i));
        % Somar as frequenciasobtidas em cada intervalo de tempo:
        soma_wa = soma_wa + wa_e(i);
    end
    % Por fim realizar a media das frequencias todas calculadas e
    % determinar a frequencia de oscila��o empirica:
    media = soma_wa/length(wa_e);
    disp(strcat('Frequ�ncia angular para ',num2str(bpm(aux)),' BPM = ',num2str(media),'rad/s ' ));
    aux = aux+1;
end

%%
% Atrav�s da an�lise dos gr�ficos, � poss�vel concluir que o �ngulo
% apresenta varia��es de acordo com o esperado para ambas as frequ�ncias
% embora com uma pequena discrep�ncia entre a envolvente e a varia��o do
% �ngulo.

%% Quest�o 10
%%
% Simula��o para o modelo n�o linear do metronome cosiderando os valores da
% quest�o 9.

open_system('Q10');
%%
% Usamos agora o dimensionamento da quest�o anterior:
m = 0.09;
l_150 = 0.077586; % comprimento l para 150 BPM 
l_50 = 0.20862; % comprimento l para 50 BPM
l_124 = 0.10517;% comprimento l para 124 BPM
l_76 = 0.17414; % comprimento l para 76 BPM
bpm = [50 150 76 124];
aux = 1;% contador auxiliar para o ciclo for
% Bin�rio externo nulo:
U = 0;
% Condi��es Inicias:
teta0 = pi/4;  % �ngulo inicial
v0 = 0 ; % velocidade angular inicial


% Simula��o do sistema n�o linear para o comprimento l correspondente aos
% 150 BPM, 50 BPM, 74 BPM e 124 BPM:
figure(n);
fig = figure(n);
set(fig, 'Position', [0, 0, 900, 500])  % x, y, largura e comprimento da figura
n = n+1;

for l= [l_50 l_150 l_76 l_124]
    cte3 = m*g*l + M*g*L/2;
    cte4 = 1/(((M*(L^2))/3 + m*(l^2)));
    sim('Q10', 20);
    subplot(2,2,aux)
    plot(t,teta(:,1));
    xlabel('Tempo (s)');
    ylabel('{\theta}   [rad]')
    title(strcat('Varia��o de {\theta} para',num2str(bpm(aux)),' BPM no modelo n�o linear'));
    grid on;
    % Determina��o dos valores dos picos e os seus �ndices de forma a 
    % determinar os instantes em que ocorrem:
    [picos, loc] = findpeaks(teta(:,1));   
    t_picos = zeros(1,length(loc));
    % wa_e � um vector em que cada indice guarda a frequencia de oscila��o 
    % entre dois picos:
    wa_e = zeros(1,length(t_picos)-1);
    % inicializa��o da variavel que guarda a soma das frequencias de
    % oscila��o entre cada par de picos:
    soma_wa = 0; 
    % Instantes de tempo em que se encontram os picos:
    for i = 1:length(t_picos)
        t_picos(i) = t(loc(i));
    end
    % calacular a frequencia em cada intervalo de tempo (t_picos(i+1) - t_picos(i))
    for i = 1:length(wa_e)
        % sabendo que : wa = 2*pi*f = (2*pi)/(tempo):
        wa_e(i) = (2*pi) ./ (t_picos(i+1) - t_picos(i));
        % Somar as frequenciasobtidas em cada intervalo de tempo:
        soma_wa = soma_wa + wa_e(i);
    end
    % Por fim realizar a media das frequencias todas calculadas e
    % determinar a frequencia de oscila��o empirica:
    media = soma_wa/length(wa_e);
    disp(strcat('Frequ�ncia angular para ', num2str(bpm(aux)),' BPM = ', num2str(media),'rad/s ' ));
    aux = aux+1;
end

%%
% Conforme era esperado as frequ�ncias angulares s�o um pouco diferentes
% comparadas com a simula��o considerando um modelo linear. 
%
% Uma forma de redimensionar as posi��es da massa m para que as cad�ncias 
% de oscila��o se aproximem mais dos valores pretendidos consiste em 
% determinar o m�dulo da diferen�a entre a frequ�ncia pretendida e 
% frequ�ncia calculada com o sitema n�o linear.

%Vector que cont�m os comprimentos que se v�o obter
% ln = zeros(1, 2);
% aux = 1;

p=30; %numero de condi��es iniciais a testar
ls = linspace(0.05,0.25,p);
was = zeros(1,length(ls));
aux = 1;% contador auxiliar para o ciclo for
% Inicializa��o do vector que vai guardar os l que optimizam as
% frequanecias:
ls_opt= zeros(1,4);

for f = [2*pi*50/120 2*pi*150/120 2*pi*76/120 2*pi*124/120]
    
    for p = 1:length(ls)
        l=ls(p);
        cte3 = m*g*l + M*g*L/2;
        cte4 = 1/(((M*(L^2))/3 + m*(l^2)));
        sim('Q10', 20);
        % Determina��o dos valores dos picos e os seus �ndices de forma a
        % determinar os instantes em que ocorrem:
        [picos, loc] = findpeaks(teta(:,1));
        t_picos = zeros(1,length(loc));
        % wa_e � um vector em que cada indice guarda a frequencia de oscila��o
        % entre dois picos:
        wa_e = zeros(1,length(t_picos)-1);
        % inicializa��o da variavel que guarda a soma das frequencias de
        % oscila��o entre cada par de picos:
        soma_wa = 0;
        % Instantes de tempo em que se encontram os picos:
        for i = 1:length(t_picos)
            t_picos(i) = t(loc(i));
        end
        % calacular a frequencia em cada intervalo de tempo (t_picos(i+1) - t_picos(i))
        for i = 1:length(wa_e)
            % sabendo que : wa = 2*pi*f = (2*pi)/(tempo):
            wa_e(i) = (2*pi) ./ (t_picos(i+1) - t_picos(i));
            % Somar as frequenciasobtidas em cada intervalo de tempo:
            soma_wa = soma_wa + wa_e(i);
        end
        % Por fim realizar a media das frequencias todas calculadas e
        % determinar a frequencia de oscila��o empirica:
        media = soma_wa/length(wa_e);     
        was(p)=abs(f - media);
    end
    % O m�nimo local obtido pela fun��o fminsearch �: 
    [minimo,ind] = min(was);
    disp(strcat('Distancia l obtida para ',num2str(bpm(aux)),' BPM = ',num2str(ls(ind))));
    ls_opt(aux)=ls(ind);
    h = waitbar(aux/4, 'A calcular... Est� quase...');
    % barra de loading a apresentar durante simula��o
    delete(h)
    aux=aux+1;
end

%%
% Agora realizam-se de novo os c�lculos das frequ�ncias angulares, 
% utilizando os novos valores optimizados para l :

% Simula��o do sistema n�o linear para valores de comprimento l optimizados
figure(n);
fig = figure(n);
set(fig, 'Position', [0, 0, 900, 500])  % x, y, largura e comprimento da figura
n = n+1;
aux=1;

for l= ls_opt
    cte3 = m*g*l + M*g*L/2;
    cte4 = 1/(((M*(L^2))/3 + m*(l^2)));
    sim('Q10', 20);
    subplot(2,2,aux)
    plot(t,teta(:,1));
    xlabel('Tempo (s)');
    ylabel('{\theta}   [rad]')
    title(strcat('Varia��o de {\theta} para',num2str(bpm(aux)),' BPM no modelo n�o linear'));
    grid on;
    % Determina��o dos valores dos picos e os seus �ndices de forma a 
    % determinar os instantes em que ocorrem:
    [picos, loc] = findpeaks(teta(:,1));   
    t_picos = zeros(1,length(loc));
    % wa_e � um vector em que cada indice guarda a frequencia de oscila��o 
    % entre dois picos:
    wa_e = zeros(1,length(t_picos)-1);
    % inicializa��o da variavel que guarda a soma das frequencias de
    % oscila��o entre cada par de picos:
    soma_wa = 0; 
    % Instantes de tempo em que se encontram os picos:
    for i = 1:length(t_picos)
        t_picos(i) = t(loc(i));
    end
    % calacular a frequencia em cada intervalo de tempo (t_picos(i+1) - t_picos(i))
    for i = 1:length(wa_e)
        % sabendo que : wa = 2*pi*f = (2*pi)/(tempo):
        wa_e(i) = (2*pi) ./ (t_picos(i+1) - t_picos(i));
        % Somar as frequenciasobtidas em cada intervalo de tempo:
        soma_wa = soma_wa + wa_e(i);
    end
    % Por fim realizar a media das frequencias todas calculadas e
    % determinar a frequencia de oscila��o empirica:
    media = soma_wa/length(wa_e);
    disp(strcat('Frequ�ncia angular para ', num2str(bpm(aux)),' BPM = ', num2str(media),'rad/s ' ));
    aux = aux+1;
end

%%
% A forma utilizada para refinar o dimensionamento das distancias l,  
% parecem adequadas, uma vez que, as novas posi�oes da massa m permitem 
% obter valores para as cadencias proximos dos valores desejados.

%% Quest�o 11
%%
% Simula��o de um mecanismo de relojoaria no metr�nomo que impulsiona 
% o p�ndulo quando este passa na vertical de modo a contrariar o decaimento 
% para zero da amplitude das oscila��es. 

open_system('Q11');

%%
% Neste diagrama realiza-se a dete��o das passagens por zero do �ngulo teta
% e aplica um impulso positivo na entrada nas transi��es negativo->positivo.

aux=1;
for l= ls_opt
    cte3 = m*g*l + M*g*L/2;
    cte4 = 1/(((M*(L^2))/3 + m*(l^2)));
    sim('Q11', 20);
    figure (n)
    fig = figure(n);
    set(fig, 'Position', [0, 0, 900, 500])  % x, y, largura e comprimento da figura
    n = n+1;
    plot(t,teta,t,impulsos);
    xlabel('Tempo (s)');
    ylabel('{\theta}   [rad] | Impulsos T [Nm]')
    title(strcat(' BPM = ', num2str(bpm(aux)),' Varia��o de {\theta} do sistema dimensionado para l = ',num2str(ls_opt(aux)),' com aplica��o de bin�rio externo'));
    grid on;
    % Determina��o dos valores dos picos e os seus �ndices de forma a 
    % determinar os instantes em que ocorrem:
    [picos, loc] = findpeaks(teta(:,1));   
    t_picos = zeros(1,length(loc));
    % wa_e � um vector em que cada indice guarda a frequencia de oscila��o 
    % entre dois picos:
    wa_e = zeros(1,length(t_picos)-1);
    % inicializa��o da variavel que guarda a soma das frequencias de
    % oscila��o entre cada par de picos:
    soma_wa = 0; 
    % Instantes de tempo em que se encontram os picos:
    for i = 1:length(t_picos)
        t_picos(i) = t(loc(i));
    end
    % calacular a frequencia em cada intervalo de tempo (t_picos(i+1) - t_picos(i))
    for i = 1:length(wa_e)
        % sabendo que : wa = 2*pi*f = (2*pi)/(tempo):
        wa_e(i) = (2*pi) ./ (t_picos(i+1) - t_picos(i));
        % Somar as frequenciasobtidas em cada intervalo de tempo:
        soma_wa = soma_wa + wa_e(i);
    end
    % Por fim realizar a media das frequencias todas calculadas e
    % determinar a frequencia de oscila��o empirica:
    media = soma_wa/length(wa_e);
    disp(strcat('Frequ�ncia angular para ', num2str(media),' BPM = ', num2str(bpm(aux)),'rad/s para a distancia l=',num2str(ls_opt(aux)) ));
    aux = aux+1;
end

%%
% Os valores das frequ�ncias de oscila��o nas condi��es dimensionadas 
% sofrem um pequeno aumento na presen�a do mecanismo de relojoaria. 
% O que permite concluir que a presen�a deste mecanismo afecta um pouco a
% frequ�ncia de oscila��o.

%% Quest�o 12
%%
