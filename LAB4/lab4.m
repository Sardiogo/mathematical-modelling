%% Trabalho de Laboratório nº4 - Detecção de Hotspots Wifi
% 
%   Autor: Diogo Vilar Sardinha
%  
%% Questão 2.a) 
% Decomposição da matriz P trasnposta em valores e vectores próprios. 
% Obtenção da distribuição de equilíbrio da cadeia de Markov por 
% normalização de um dos vectores próprios e ilustração da mesma usando o 
% comando bar.
%%
load('MarkovChain.mat')

Ptrans = transpose(P);
[VecP,ValP] = eig(transpose(P)); % [eigenvectors,eigenvalues] = [VecP,ValP]
% A função eig(Ptrans) calcula os valores próprios da matriz transposta de 
% P e coloca-os numa matriz diagonal ValP e coloca na matriz VecP os 
% vectores próprios por colunas.

disp(ValP)
%%
% De acordo com a matriz diagonal de valores próprios ValP, há uma entrada
% nesta matriz cujo valor é 1. 
% 
% A cadeia de Markov evolui para uma distribuição de equilíbrio 
% estacionária dada pelo vector próprio associado ao valor próprio 1:
disp(VecP(:,1))

%%
% Normalização do vector próprio que contem a distribuição de equilíbrio:
Deq = VecP(:,1)/sum(VecP(:,1)); 

disp('Distribuição de Equilíbrio da cadeia de Markov:');
disp(' ')
for i = 1:length(Deq)
    disp(strcat('Estado ', num2str(i),' -> ', num2str(Deq(i))));
end
[M,I] = min(Deq);
disp(' ')
disp(strcat('Estado menos provável: Estado ', num2str(I)));
[M,I] = max(Deq);
disp(strcat('Estado mais provável: Estado ', num2str(I)));
%%
% Distribuição de Equilíbrio da cadeia de Markov:
count=1;
figure(count)
count=count+1;
bar(Deq,0.4)
xlabel('Número de cada agente');
ylabel('Probabilidade de equilíbrio')
title(strcat('Distribuição de Equilíbrio da cadeia de Markov')); 
grid on
%%
% Grafo de comunicação entre agentes:
MarkovChainDraw(count)
count=count+1;

%%
% Observando a Distribuiçao de Equilíbrio Estacionária da Cadeia de Markov,
% concluímos, que os estados variam em probabilidade de equilíbrio consoate 
% o número de ramos de ligação e a probabilidade de transição associada a 
% cada ramo. 
%
% Á medida que nos aproximamos de uma situação esatcionária 
% o agente que estará na posse do token corresponderá ao estado com
% probabilidade de equílibrio mais elevada.

%% Questão 2.b) 
% Geração de observações de RSS para a localização da fonte fornecida com
% P0=100, sigma^2=10^-2 e ni~N(0,sigma^2).
%
% Tendo como base o código fornecido no ficheiro rssiloc.m e fazendo
% algumas alterações temos o seguinte código:

figure(count)
count=count+1;
% Simulation setup
N = 20;					% No. of anchors
n = 2;					% Embedding dimension
sidelength = 100;
aux1 = transpose(nodePos);
aux2=[aux1(2,:);aux1(3,:)];
a = aux2;		% Anchor positions
x = sourcePos';		% Source position

M=1000; % Número de observações
as=zeros(2,M);
as_aux=zeros(2,M);
for count2=1:length(Deq')
    for i = 1:round(Deq(count2)*M)
        as_aux(:,i)=a(:,count2);
    end
    if count2==1
       as=as_aux;
    end
    if count2>1
       as=[as,as_aux];
    end
    if count2<length(Deq'),
       clear as_aux
    end
end

D = squareform(pdist([x zeros(size(x)) as]'));
d = D(1,3:end);				% Source-anchor distances
an = D(2,3:end);			% Anchor norms

% Generate observations
P0 = 100;				% Source power
P_2 = P0./(d.^2);				% Noiseless RSSI

stdev = 20e-2;				% Log-noise standard deviation
%stdev = 0;
P_2 = P_2.*exp(stdev*randn(size(P_2)));	% Introduce noise
QP = 1e-2;
P_2 = QP*round(P_2/QP);			% Quantize power measurements

% Localize source by least-squares
A = [-2*repmat(P_2,[n 1]).*as; -ones(size(P_2)); P_2]';
b = (-P_2.*(an.^2))';

z = A\b;
xe = z(1:n);
aux=norm(x-xe);
disp(strcat('Erro:', num2str(aux)));

if n==2,
  plot(a'*[1; 1i],'o'); hold all
  plot(x'*[1; 1i],'rh'); plot(xe'*[1; 1i],'x'); hold off
  title('Posição dos agentes(o), da fonte exacta(rh) e estimada(x)');
end

%% Questão 2.c) 
% Evolução das probabilidades dos diversos estados da cadeia de Markov ao 
% longo do tempo para diferentes condições iniciais pi(0).

% Tempo de simulação:
N=120;

%Vector do Tempo:
tempo = 1:N;

% Condições iniciais a testar:
f_pi_ini = [0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0; 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.5 0.5; 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0]; 
% 1.ª Linha - Token está no agente 2;
% 2.ª Linha - Igual probabilidade de o token estar no no agente 19 ou 20;
% 3.ª Linha - Token está no agente 7.

for ini=1:3
    clear f_pi;
    % Criação da matriz pi(t):
    f_pi = f_pi_ini(ini,:);
    for t=2:N
        aux_pi = f_pi_ini(ini,:)*(P^(t-1));
        if sum(aux_pi) ~= 1 
        % Se para este instante do tempo, a soma das probabilidades dos 
        % diferentes estados for diferente de 1...
            aux_pi = aux_pi/sum(aux_pi);
        end
            
        f_pi=[f_pi; aux_pi];   
    end

    % Impressão de pi(t), para cada estado em função do tempo:
    figure(count)
    for j=1:20
        estado=ones(1,N)*j;
        plot3(tempo,estado,f_pi(:,j));
        xlabel('Tempo')
        ylabel('N.º do Agente (Estado)')
        zlabel('pi(tempo)')
        title(['Evolução temporal das probabilidades dos diversos estados para f_pi_ini {\ini}=',num2str(ini)])
        hold on;
    end
    count=count+1;
end

% Verificamos que a partir de um certo tempo a função pi(t) estabiliza, ou
% seja, as probabilidades de cada estado deixam de variar com a passagem do
% tempo.

% Diferentes condições iniciais afectam bastante a evolução temporal das
% probabilidades dos diferentes estados durante os primeiros instantes da
% simulação. Mas independentemente das condições iniciais escolhidas,
% quando a função pi(t) estabiliza, esta tende para os valores da
% distribuição de equilíbrio da cadeia de markov anteriormente calculada.

%% Questão 2.d) 
% Dividimos os estados da cadeia em 4 subconjuntos:
% A -> 6-11-16
% B -> 1-7-14-16-18-20
% C -> 2-4-13-19
% D -> 8-9-10-12-17

% Para dificultar a circulação do token, consideramos as
% seguintes alterações na matriz P de modo a que o token fique 
% "aprisionado" no subconjunto D:
P(3,19)=0.05;
P(3,12)=0.95;

% Imprimimos de novo a nova distribuição de equilíbrio da cadeia de Markov:
[VecP,ValP] = eig(transpose(P));
Deq = VecP(:,1)/sum(VecP(:,1)); 

figure(count)
count=count+1;
bar(Deq,0.4)
xlabel('Número de cada agente');
ylabel('Probabilidade de equilíbrio')
title(strcat('Distribuição de Equilíbrio da cadeia de Markov com pior circulação')); 
grid on

% Como podemos verificar, os estados com maior probabilidade são sobretudo
% os do subconjunto D que era o pretendido.

% Para melhorar a eficácia de circulação global do token, consideramos as
% seguintes alterações na matriz P:

% Melhoramento na comunicação entre A e B:
P(6,1)=0.5;
P(6,11)=0.25;
P(6,15)=0.25;

P(1,6)=0.5;
P(1,7)=0.25;
P(1,20)=0.25;

% Melhoramento na comunicação entre B e C:
P(7,1)=0.2;
P(7,16)=0.1;
P(7,19)=0.5;
P(7,20)=0.2;

P(19,3)=0.4; % Esta alteração também melhora a comunicação entre C e D.
P(19,4)=0.1;
P(19,7)=0.4;
P(19,13)=0.1;

% Melhoramento na comunicação entre C e D:
P(3,19)=0.65;
P(3,12)=0.35;

P(12,3)=0.5;
P(12,8)=0.25;
P(12,10)=0.25;

% Por fim, imprimimos a nova distribuição de equilíbrio da cadeia de Markov:
[VecP,ValP] = eig(transpose(P));
Deq = VecP(:,1)/sum(VecP(:,1)); 

figure(count)
count=count+1;
bar(Deq,0.4)
xlabel('Número de cada agente');
ylabel('Probabilidade de equilíbrio')
title(strcat('Distribuição de Equilíbrio da cadeia de Markov com melhor circulação')); 
grid on

% Verifica-se uma circulação do token mais equilibrada por todos os
% agentes e uma maior probabilidade de passagem do token pelos
% agentes que ligam diferentes subconjuntos e por isso temos uma melhor
% circulação do token por entre os vários subconjuntos.

% Em suma, quanto menor for a fluidez de o token circular por todos os
% subconjuntos e agentes, menos precisa vai ser a localização da fonte
% obtida e vice-versa. Por outras palavras, quanto mais uniforme for a
% circulação do token por todos os agentes, mais precisão vamos ter na
% deteccção da fonte.