%% Trabalho de Laborat�rio - Simula��o B�sica em Matlab/Simulink
% 
%   Autor:  Diogo Vilar Sardinha 
%  
%% Quest�o 1.1 - Modelo para simula��o do movimento livre de uma viatura
%
n=1; % inicializa��o do contador para as figuras
figure(n)
n=n+1;I = imread('./figures/1.1.jpg');
imshow(I);
%% Quest�o 1.2 - Evolu��o qualitativa da velocidade no tempo
%
figure(n)
n=n+1;
I = imread('./figures/1.2.jpg');
imshow(I);
%% Quest�o 1.3 - Equa��o diferencial
%
figure(n)
n=n+1;
I = imread('./figures/1.3.jpg');
imshow(I);
%% Quest�o 1.4 - Equa��o diferencial que rege a posi��o do ve�culo
%
figure(n)
n=n+1;
I = imread('./figures/1.4.jpg');
imshow(I);
%% Quest�o 1.5 - Simula��o do movimento livre de uma viatura
% A equa��o diferencial 
% $m\frac{dv\left(t\right)}{dt}=-\beta v\left(t\right)$
% mais o c�lculo da posi��o $y\left(t\right)$ s�o 
% representados pelo seguinte diagrama de Blocos no Simulink:
%
open_system('viatura')
%%
% Simula��o de um movimento livre de uma viatura
% para diferentes valores de m, beta e V0

y0=5;
v0=0;
beta=5;
m=0;
%%
% Gr�ficos de posi��o
figure(n)
n=n+1;
hold all;
for m=[30 60 3]   
    for v0=[3 -3]
        sim('viatura', 25)
        plot(t, y, 'DisplayName', ['m/beta=',num2str(m/beta),'s; v0=',num2str(v0),'m/s'])
    end
end
legend('show')
title('Curvas da Posi��o do Ve�culo')
ylabel('Posi��o')
xlabel('Tempo(s)')
grid on
%%
% Gr�ficos de Velocidade
figure(n)
n=n+1;
hold all;
for m=[30 60 3]
    for v0=[3 -3]
        sim('viatura', 25)
        plot(t,v, 'DisplayName', ['m/beta=',num2str(m/beta),'s; v0=',num2str(v0),'m/s'])
    end
end
legend('show')
title('Curvas da Velocidade do Ve�culo')
ylabel('Velocidade')
xlabel('Tempo(s)')
grid on

%% Quest�o 2.1 Modelo Predador-Presa
%
figure(n)
n=n+1;
I = imread('./figures/2.1.1.jpg');
J = imresize(I, 0.7);
imshow(J);
figure(n)
n=n+1;
I = imread('./figures/2.1.2.jpg');
J = imresize(I, 0.7);
imshow(J);
%% Quest�es 2.2 e 2.3 - Simula��es do Modelo Predador-Presa
% O sistema de equa��es:
% $\enspace$
% $\frac{d{N}_{1}\left(t\right)}{dt}={\delta}_{1}{N}_{1}\left(t\right)-{\alpha }_{1}{N}_{1}\left(t\right){N}_{2}\left(t\right)$
% $\enspace \enspace  ,  \enspace \enspace$
% $\frac{d{N}_{2}\left(t\right)}{dt}={\delta}_{2}{N}_{2}\left(t\right)+{\alpha }_{2}{N}_{1}\left(t\right){N}_{2}\left(t\right)$ 
% $\enspace$ � representado pelo seguinte diagrama Simulink: 
%
open_system('predador_presa')
%%
%%
% Considerando alpha1=alpha2=1, simula-se o sistema descrito pelo diagrama
% para diferentes valores das condi��es iniciais: N1(0), N2(0), delta 1 e
% delta 2:
alpha1=1;
alpha2=1;

%% Quest�es 2.2 e 2.3 - Solu��es de Equil�brio 
% Neste caso constata-se que o numero de individuos de cada uma das 
% popula��es mantem-se constante atrav�s da verifica��o das seguintes
% condi�o~es: ${N}_{2\left(t\right)}=\frac{{\delta }_{1}}{{\alpha }_{1}} \enspace e \enspace {N}_{1}\left(t\right)=-\frac{{\delta }_{2}}{{\alpha }_{2}}$
figure(n)
fig = figure(n);
set(fig, 'Position', [0, 0, 700, 500])  % x, y, largura e comprimento da figura
n=n+1;
hold all;
N10_aux=[2 10 50 100];
N20_aux=[2 10 50 100];
delta1_aux=[2 10 50 100];
delta2_aux=[-2 -10 -50 -100];
for k=1:4   
    N10 = N10_aux(k);
    N20 = N20_aux(k);
    delta1 = delta1_aux(k);
    delta2 = delta2_aux(k);
    sim('predador_presa',20)
    subplot(2,2,k)
    hold all;
    plot(t, N1,'--','DisplayName', 'N1 Presa')
    plot(t, N2, 'DisplayName', 'N2 Predador')
    title(['N1(0) = ',num2str(N10),', N2(0) = ',num2str(N20),', {\delta }_{1}=',num2str(delta1),', {\delta }_{2}=',num2str(delta2)])
    ylabel('N�mero de indiv�duos')
    xlabel('Tempo(s)')
    grid on
    legend('show')
end

%% Quest�es 2.2 e 2.3 - Solu��es Oscilat�rias
% As solu��es oscilat�rias verificam-se caso: $\enspace$ ${\delta }_{1}>0 \enspace e \enspace {\delta }_{2}<0$
% $\enspace$ Para al�m disto: $\enspace {N}_{2}\left(t\right)\ne \frac{{\delta }_{1}}{{\alpha }_{1}} \enspace e \enspace {N}_{1}\left(t\right)\ne -\frac{{\delta }_{2}}{{\alpha }_{2}}$
%%
% Solu��es para delta1 = 1.5 e delta2 = -1.5
figure(n)
fig = figure(n);
set(fig, 'Position', [0, 0, 700, 500])  % x, y, largura e comprimento da figura
n=n+1;
hold all;
delta1=1.5;
delta2=-1.5;
k=1;
for N10=[2 20]   
    for N20=[2 20]
        sim('predador_presa', 15)
        subplot(2,2,k)
        hold all;
        k=k+1;
        plot(t, N1,'--','DisplayName', 'N1 Presa')
        plot(t, N2, 'DisplayName', 'N2 Predador')
        title(['N1(0) = ',num2str(N10),', N2(0) = ',num2str(N20),', {\delta }_{1}=',num2str(delta1),', {\delta }_{2}=',num2str(delta2)])
        ylabel('N�mero de indiv�duos')
        xlabel('Tempo(s)')
        grid on
        legend('show')
    end
end

%%
% Solu��es para delta1 = 3.5 e delta2 = -2.5
figure(n)
fig = figure(n);
set(fig, 'Position', [0, 0, 700, 500])  % x, y, largura e comprimento da figura
n=n+1;
hold all;
delta1=3.5;
delta2=-2.5;
k=1;
for N10=[2 20]   
    for N20=[2 20]
        sim('predador_presa', 15)
        subplot(2,2,k)
        hold all;
        k=k+1;
        plot(t, N1,'--','DisplayName', 'N1 Presa')
        plot(t, N2, 'DisplayName', 'N2 Predador')
        title(['N1(0) = ',num2str(N10),', N2(0) = ',num2str(N20),', {\delta }_{1}=',num2str(delta1),', {\delta }_{2}=',num2str(delta2)])
        ylabel('N�mero de indiv�duos')
        xlabel('Tempo(s)')
        grid on
        legend('show')
    end
end

%% Quest�es 2.2 e 2.3 - Solu��es em que a Presa se extingue e o Predador mantem-se constante
% Dois conjuntos de condi��es iniciais que conduzem a evolu��es identicas do sistema.
% $\forall {\delta }_{1}  \enspace e \enspace   {\delta }_{2}=0$

figure(n)
fig = figure(n);
set(fig, 'Position', [0, 0, 1000, 500])  % x, y, largura e comprimento da figura
n=n+1;
hold all;
N10_aux=[10 50 10 50 10 50];
N20_aux=[10 50 10 50 10 50];
delta1_aux=[-1 -1 0 0 1 1];
delta2=0;
tsim=2;
for k=1:6   
    N10 = N10_aux(k);
    N20 = N20_aux(k);
    delta1 = delta1_aux(k);
    sim('predador_presa')
    subplot(3,2,k)
    hold all;
    plot(t, N1,'--','DisplayName', 'N1 Presa')
    plot(t, N2, 'DisplayName', 'N2 Predador')
    title(['N1(0) = ',num2str(N10),', N2(0) = ',num2str(N20),', {\delta }_{1}=',num2str(delta1),', {\delta }_{2}=',num2str(delta2)])
    ylabel('N�mero de indiv�duos')
    xlabel('Tempo(s)')
    grid on
    legend('show')
end

%% Quest�es 2.2 e 2.3 - Solu��es em que a Presa e o Predador se extinguem
% ${\delta }_{1}=0  \enspace e \enspace   {\delta }_{2}<0$
%%
% Solu��es para delta1 = 3.5 e delta2 = -2.5
figure(n)
fig = figure(n);
set(fig, 'Position', [0, 0, 700, 500])  % x, y, largura e comprimento da figura
n=n+1;
hold all;
delta1=0;
delta2=-1.5;
k=1;
for N10=[2 20]   
    for N20=[2 20]
        sim('predador_presa',30)
        subplot(2,2,k)
        hold all;
        k=k+1;
        plot(t, N1,'--','DisplayName', 'N1 Presa')
        plot(t, N2, 'DisplayName', 'N2 Predador')
        title(['N1(0) = ',num2str(N10),', N2(0) = ',num2str(N20),', {\delta }_{1}=',num2str(delta1),', {\delta }_{2}=',num2str(delta2)])
        ylabel('N�mero de indiv�duos')
        xlabel('Tempo(s)')
        grid on
        legend('show')
    end
end

%% Quest�es 2.2 e 2.3 - Solu��es em que a Presa se extingue e o Predador cresce indefinidamente
% ${\delta }_{1}=0  \enspace e \enspace   {\delta }_{2}>0$
%%
% Solu��es para delta1 = 3.5 e delta2 = -2.5
figure(n)
fig = figure(n);
set(fig, 'Position', [0, 0, 700, 500])  % x, y, largura e comprimento da figura
n=n+1;
hold all;
delta1=0;
delta2=1;
k=1;
tsim=0.5;
for N10=[2 20]   
    for N20=[2 20]
        sim('predador_presa')
        subplot(2,2,k)
        hold all;
        k=k+1;
        plot(t, N1,'--','DisplayName', 'N1 Presa')
        plot(t, N2, 'DisplayName', 'N2 Predador')
        title(['N1(0) = ',num2str(N10),', N2(0) = ',num2str(N20),', {\delta }_{1}=',num2str(delta1),', {\delta }_{2}=',num2str(delta2)])
        ylabel('N�mero de indiv�duos')
        xlabel('Tempo(s)')
        grid on
        legend('show')
    end
end
%% Quest�es 2.2 e 2.3 - Gr�fico do espa�o de fases N1 e N2 para direntes valores de N01 e N02

delta1 =5;
delta2 =-5;
tsim = 5;
figure(n)
n=n+1;
hold all;
for N10 =  [20 2]
   for N20 = [15 4]
        sim('predador_presa');
        factor=N10/N20;
        plot(N1, N2,'DisplayName',['N1(0)/N2(0) = ', num2str(factor)])
   end
end  
xlabel('N�mero de Presas (N1)')
ylabel('N�mero de Predadores (N2)')
title('Gr�fico em espa�o de fase (N1,N2)')
legend('show')


%% Quest�o 2.4.a) Aproxima��o por tentativa e erro
% Simulando o sistema para diferentes valores das caracter�sticas N2(0) e
% ${\alpha}_{2}$ dos predadores, obteve-se, por tentativa e erro, 
% uma evolu���o temporal do n�mero de presas aproximada � curva fornecida.
%%
load('presas.mat')
% carregamento do ficheiro presas.mat que contem valores para uma populacao
% de presas ao longo do tempo
delta1=3.1;
alpha1=1.4;
delta2=-1.5;
N10=4;
figure(n)
fig = figure(n);
set(fig, 'Position', [0, 0, 700, 500])  % x, y, largura e comprimento da figura
n=n+1;
hold all;
alpha2_aux=[0.7  0.7];
N20_aux=[1.6 1.6];
hold all;
plot(tr, yr, 'DisplayName', 'Presas(N1) (dados)')
for k=1:1   
    N20 = N20_aux(k);
    alpha2 = alpha2_aux(k);
    sim('predador_presa',tr)
    plot(tr, N1,'--','DisplayName',['Presas(N1) (simula��o), {\alpha }_{2}=',num2str(alpha2),', N2(0) = ',num2str(N20)])
end
XMIN=0; XMAX=20; YMIN=0; YMAX=6;
axis ([XMIN XMAX YMIN YMAX]);
legend('show')
title('Aproxima��o dos dados recolhidos por simula��o')
ylabel('N�mero de indiv�duos N1(t) ')
xlabel('Tempo(s)')
grid on
%%
% foi obtida por tentativa e erro a Seguinte aproxima��o: 
% 
% N2(0)= 1.6 e ${\alpha}_{2}$= 0.7

%% Quest�o 2.4.b) Ajuste de parametros por estima��o do erro absoluto
% De forma a obter uma estimativa dos valores de N2(0) e ${\alpha}_{2}$ da 
% popula��o de predadores come�a-se por fazer um varrimento de poss�veis 
% valores destes par�metros e, para cada par de valores, estimar o erro 
% absoluto ou soma dos valores absolutos das diferen�as entre os valores 
% fornecidos e os calculados.
% Os valores s�o escolhidos tendo em conta que, na al�nea anterior, foi
% obtida uma aproxima��o aos valores de N2(0) e ${\alpha}_{2}$ por 
% tentativa e erro.
% Na al�nea anterior foram obtidos dois pares de valores: 
% N2(0)= 1.6 e ${\alpha}_{2}$=0.7
%%

p=15; % numero de valores de N0 e alpha a testar
erros = zeros(p, p); % icializa��o da matriz com os valores de erro    
N20_min=1.4;
N20_max=1.8;
alpha2_min=0.5;
alpha2_max=0.9;
%%
% Pelas aproximacoes feitas na alinea 2.4a) sabemos que
% valores de ${\alpha}_{2}$ e N2(0) est�o dentro destes parametros, e os
% intervalos foram escolhidos de modo a haver coerencia entre os dados 
% fornecidos pelo ficheiro presas.mat
N20_aux=linspace(N20_min,N20_max,p); 
% N2(0) -> espa�o linear, vector de p pontos entre N20_min e N20_max
alpha2_aux=linspace(alpha2_min,alpha2_max,p); 
% alpha2 -> espa�o linear, vector de p pontos entre alpha2_min e alpha2_max

h = waitbar(0, 'A calcular erros... Est� quase...');
set(h,'HandleVisibility','off')
for i=1:p
    for j=1:p
        alpha2 = alpha2_aux(i);
        N20 = N20_aux(j);
        % erros(i,j)=erro([N20_aux(j) alpha2_aux(i)]);
        erros(i,j)=erro([N20 alpha2]);
    end
    delete(h);
    h = waitbar(i/p, 'A calcular erros... Est� quase...');
    % barra de loading a apresentar durante simula��o
end
delete(h);

figure(n)
fig = figure(n);
set(fig, 'Position', [0, 0, 700, 500])  % x, y, largura e comprimento da figura
n=n+1;
subplot(2,1,1)
surfc(alpha2_aux,N20_aux,erros);
xlabel('{\alpha }_{2}'); ylabel('N2(0)'); zlabel('Erro'); colorbar;
title('Superf�cie de Erro')
subplot(2,1,2)
contour(alpha2_aux,N20_aux,erros,100);% 100 linhas de contorno
xlabel('{\alpha }_{2}'); ylabel('N2(0)'); colorbar;
title('Curvas de n�vel')
%%
% Os valores de ${\alpha}_{2}$ e N2(0) n�o s�o facilmente estimados pela 
% observa��o dos gr�ficos anteriores, sendo apenas poss�vel estimar um 
% intervalo de valores. 
% A precis�o da estima��o depende do n�mero (p) de valores a testar e 
% do intervalo entre o valor m�nimo e o m�ximo.
% Os intervalos de valores para ${\alpha}_{2}$ e N2(0) foram escolhidos 
% obsevando a surferficie de erro obtida vista de cima e analisando dentro 
% da curva mais estreita do grafico contour, obtendo-se: 
%
% N2(0)= [1.586 , 1.614] e ${\alpha}_{2}$ = [0.614 , 0.74]
%
% Com base neste intervalaos vamos estimar de novo intervalos de valores
% mais precisos

N20_min=1.586;
N20_max=1.614;
alpha2_min=0.674;
alpha2_max=0.74;
N20_aux=linspace(N20_min,N20_max,p); 
alpha2_aux=linspace(alpha2_min,alpha2_max,p); 

h = waitbar(0, 'A calcular erros... Est� quase...');
set(h,'HandleVisibility','off')
for i=1:p
    for j=1:p
        alpha2 = alpha2_aux(i);
        N20 = N20_aux(j);
        erros(i,j)=erro([N20 alpha2]);
    end
    delete(h);
    h = waitbar(i/p, 'A calcular erros... Est� quase...');
end
delete(h);

figure(n)
fig = figure(n);
set(fig, 'Position', [0, 0, 700, 500])  % x, y, largura e comprimento da figura
n=n+1;
subplot(2,1,1)
surfc(alpha2_aux,N20_aux,erros);
xlabel('{\alpha }_{2}'); ylabel('N2(0)'); zlabel('Erro'); colorbar;
title('Superf�cie de Erro')
subplot(2,1,2)
contour(alpha2_aux,N20_aux,erros,100);% 100 linhas de contorno
xlabel('{\alpha }_{2}'); ylabel('N2(0)'); colorbar;
title('Curvas de n�vel')
%%
% Pelo que se conclui que o m�nimo global �, aproximadamente: 
% ${\alpha}_{2}$ = 0.71 e N2(0)=1.597

%% Quest�o 2.4.c) Obten��o dos parametros por calculo exacto do erro m�nimo
% Utilizando um m�todo de optimiza��o, pretende-se calcular o m�nimo erro 
% de forma mais eficientea que na al�nea anterior.
% Recorrendo � fun��o fminsearch, que calcula o m�nimo local, vamos obter 
% os valores m�nimos de ${\alpha}_{2}$ e N02 partindo dos valores obtidos 
% na al�nea anterior: ${\alpha}_{2}$ = 0.71 e N2(0)=1.597
%%

optimo = fminsearch(@erro, [1.597 0.71]);
%%
% optimo contem o valor preciso de alpha2 e N2(0) que melhor optimizam a 
% evolucao temporal do modelo. Com esta fun��o podemos obter um resultado 
% mais exacto do que na alinea anterior, caso os valores inicias dos pares 
% alpha2 e N2(0) forem o mais correctos.
% Se n�o forem bem escolhidos o valor returnado ser� um m�nimo local em vez
% de um m�nimo absoluto da fun��o.

disp(strcat('N2(0)=',num2str(optimo(1))));
disp(strcat('alpha2=',num2str(optimo(2))));
%%
% Os resultados obtidos nesta al�ena diferem quase nada dos ecolhidos dos 
% gr�ficos, sendo N02 = 1.6042 e ${\alpha}_{2}$= 0.70033. 
% Por observa��o dos gr�ficos concluimos que este valores obtidos 
% estes se encontram na gama de valores das curvas de n�vel com menor erro.
% Se forem dados valores inciais afastados das curvas de erro m�nimo a 
% fun��o retorna um valor muito diferente. Por exemplo, para N2(0)=10 e 
% ${\alpha}_{2}$=1
% O m�nimo local obtido pela fun��o fminsearch �: 

optimo2 = fminsearch(@erro, [10 1]);
disp(strcat('N2(0)=',num2str(optimo2(1))));
disp(strcat('alpha2=',num2str(optimo2(2))));
%%
% Tal como esperado obtemos valores que n�o correspodem a uma boa 
% aproxima��o N02 = 4.1239 e ${\alpha}_{2}$ = 2.5442

%% Quest�o 2.4.d) Valida��o do modelo por obten��o do erro m�nimo
% Simulando o sistema de equa��es para os valores de erro m�nimo, obt�m-se 
% o seguinte gr�fico:
%%
alpha1=1.4;
delta1=3.1;
delta2=-1.5;
N10 = 4;
load('presas.mat')
alpha2 = optimo(2);
N20 = optimo(1);
sim('predador_presa', tr)

figure(n)
n=n+1;
plot(tr,N1,tr,yr,'o')
title('Simula��o para valores de N2(0) e {\alpha }_{2} de erro m�nimo')
xlabel('Tempo(s)')
ylabel('N�mero de Ind�v�duos N1(t)')
legend('Presa (simula��o)', 'Presa (dados)')
grid on
%%
% Como podemos averiguar os valores dos par�metros estimados N2(0) e 
% ${\alpha}_{2}$ permitem-nos obter uma boa aproxima��o da curva 
% proveniente dos dados.
% A solu��o do sistema para os valores estimados inclui os pontos da curva 
% fornecida por simula��o excepto os valores afectados pelo ru�do. 


%% Quest�o 3.1 Sistema Ca�tico
% Como estamos em repouso inicial, consideramos que t10' = t20' = 0, 
% sendo t10' e t20� as velocidades angulares iniciais de cada um dos
% bra�os. Por conseguinte, obtemos p1 = p2 = 0.

open_system('pendulo')

p10 = 0;
p20 = 0;

% Simula��o de teste com t10 = t10 = pi/10:
t10 = pi/10;
t20 = pi/10;

sim('pendulo', 15)
figure(n);
plot(t,t1,t,t2);
title('Simula��o de Teste');
legend('Teta1','Teta2')

n=n+1;

%% Quest�o 3.2 Curva de Lissajous
% Para obter uma figura que se parecesse com a curva de Lissajous, opta-se
% por tomar t10 = t20 = pi/10.

sim('pendulo', 3)
figure(n);
plot(t1,t2);
title('Curva de Lissajous');
xlabel('Teta1');
ylabel('Teta2');

n=n+1;
%%
% Aumentando a amplitude da deflex�o inicial do p�ndulo obtemos:

for i = [pi/5 pi/2 3]
    
    t10 = i;
    t20 = i;

    sim('pendulo', 3)
    figure(n);
    plot(t1,t2);
    xlabel('Teta1');
    ylabel('Teta2');
    n = n+1;

end
%%
% Como podemos claramente verificar, � medida que aumentamos o Teta1 e
% Teta2 iniciais, a figura fica cada vez mais irregular.

%% Quest�o 3.3 Solu��es pos�veis 
%
figure(n)
n=n+1;
I = imread('./figures/3.3.1.jpg');
J = imresize(I, 0.6);
imshow(J);
figure(n)
n=n+1;
I = imread('./figures/3.3.2.jpg');
J = imresize(I, 0.6);
imshow(J);
%% Quest�o 3.4 - Determina��o do tempo que decorre at� uma das  barras �fazer um looping�%% 
%
m=1;
l=0.5;
%%
%Come�amos por criar 2 vectores x e y com as coordenadas x e y,
%respectivamente, da posi��o inicial da ponta do p�ndulo
%%
x0=[-0.5 0.01 -0.1 0.00001];
y0=[-0.5 0.01 0.5 0.9999];

j=1;

for i=1:length(x0)
    
    x=x0(i);
    y=y0(i);
    
    %C�lculo dos �ngulos teta1 e teta2 iniciais
    %correspondentes as valores x e y inicias.
    teta10(i)=acos((((power(x,2)+power(y,2))/(2*x))*(y/x)+sqrt(power(y/x,2)*power(l,2)+power(l,2)-power((power(x,2)+power(y,2))/(2*x),2)))/((power(y/x,2)+1)*l));
    teta20(i)=acos((y-(((power(x,2)+power(y,2))/(2*x))*(y/x)+sqrt(power(y/x,2)*power(l,2)+power(l,2)-power((power(x,2)+power(y,2))/(2*x),2)))/((power(y/x,2)+1)))/l);
    
    %C�lculo do p1 e p2 correspondentes a cada um dos �ngulos iniciais e para teta1'(0) = 0�/s e teta2'(0) = -30�/s 
    p1_ref(i)=-10*m*power(l,2);
    p2_ref(i)=-15*m*power(l,2)*cos(teta10(i)-teta20(i));
      
    t10=teta10(i);
    t20=teta20(i);
    p1=p1_ref(i);
    p2=p2_ref(i);
    
    %Simula��o do sistema:
    sim('pendulo', 250)
    figure(n);
    plot(t1,t2);
    xlabel('Teta1');
    ylabel('Teta2');
    n=n+1;
    
    % Antes de se iniciar a pr�xima simula��o com outro ponto de partida 
    % inicial da ponta do p�ndulo, vamos verificar o tempo que se demorou at� acontecer o primeiro
    % looping em uma das barras. Na primeira linha da matriz t_loop, guardamos os tempos de
    % loop de cada simula��o. Para cada tempo de loop, se estiver impresso
    % um "1" na mesma coluna deste tempo na segunda linha, significa que o
    % loop realizou-se no bra�o 1. Se estiver um "1" na terceira linha,
    % significa que se realizou o loop no bra�o 2. Na 4.� linha de cada
    % coluna tempos o valor do �ngulo onde ocorreu o looping.
    
    
    for i=1:length(t1)
       
        % Verifica��o de looping no bra�o 1:
       
            if(t1(i) > (t10+2*pi))
                % SUCESSO: Looping no bra�o 1!
                t_loop(1,j)=t(i);
                t_loop(2,j)=1;
                t_loop(4,j)=t1(i);
                break
            end
            if(t1(i) < (t10-2*pi))
               % SUCESSO: Looping no Bra�o 1!
               t_loop(1,j)=t(i);
               t_loop(2,j)=1;
               t_loop(4,j)=t1(i);
               break
            end
        
        % Verifica��o de looping no bra�o 2:
        
            if(t2(i) > (t20+2*pi))
                % SUCESSO: Looping no bra�o 2!
                t_loop(1,j)=t(i);
                t_loop(3,j)=1;
                t_loop(4,j)=t2(i);
                break
            end
            if(t2(i) < (t20-2*pi))
               % SUCESSO: Looping no Bra�o 2!
               t_loop(1,j)=t(i);
               t_loop(3,j)=1;
               t_loop(4,j)=t2(i);
               break
            end
    end
    j=j+1;
   
end

%Tempos de simula��o apropriados
sim_temp = [10, 50, 100];
%%
% Simula��o dos pontos inciais novamente de modo a obter gr�ficos das
% evolu��es temporais do teta1 ou teta2 com os instantes onde ocorre
% looping assinalados.
%%
%%
%
for i=1:2
   
    % Aqui Fazemos apenas 2 simula��es porque apenas conseguimos 2 das 3
    % configura��es pretendidas. As configura��es em que os loopings est�o
    % contidos em [0,30]s e [30,100]s.
    
    x=x0(i);
    y=y0(i);
    
    teta10(i)=acos((((power(x,2)+power(y,2))/(2*x))*(y/x)+sqrt(power(y/x,2)*power(l,2)+power(l,2)-power((power(x,2)+power(y,2))/(2*x),2)))/((power(y/x,2)+1)*l));
    teta20(i)=acos((y-(((power(x,2)+power(y,2))/(2*x))*(y/x)+sqrt(power(y/x,2)*power(l,2)+power(l,2)-power((power(x,2)+power(y,2))/(2*x),2)))/((power(y/x,2)+1)))/l);

    p1_ref(i)=-10*m*power(l,2);
    p2_ref(i)=-15*m*power(l,2)*cos(teta10(i)-teta20(i));
      
    t10=teta10(i);
    t20=teta20(i);
    p1=p1_ref(i);
    p2=p2_ref(i);

    sim('pendulo', sim_temp(i))
    figure(n);
    
    if t_loop(2,i)==1
        plot(t,t1);
        hold on;
        plot(t_loop(i,1),t_loop(i,4),'ro');
        xlabel('Tempo');
        ylabel('Teta1');
        n=n+1;
    end
    if t_loop(3,i)==1
        plot(t,t2);
        hold on;
        plot(t_loop(1,i),t_loop(4,i),'ro');
        xlabel('Tempo');
        ylabel('Teta2');
        n=n+1;
    end
end









