% Com m=0.09kg usamos as duas posi��es de mass determinadas na quest�o 9:
%
% Para 150 BPM : l=0.077586.
%
% Para 50 BPM : l=0.20862.

x0 = [pi/4 0]';

%duas posi��es de massa calculadas na al�nea anterior

for l=[0 0.2]

    J = ((M*(L^2))/3) + m*(l^2); % Momento de in�rcia
    cte= m*g*l+M*g*L/2;
    wn = sqrt((k-cte)/J);
    qsi = beta/(2*J*sqrt((k-cte)/J));
    A = [0 1;(m*g*l+(M*g*L/2)-k)/(((M*(L^2))/3)+m*(l^2)) -beta/J];
    B = [0 1]';
    sim('Q6',5)
    figure
    bode(ss(A,B,C,D)) %a fun�ao ss cria o modelo de espa�o de estados em tempo cont�nuo
    title(strcat('Figura',num2str(r),' - Diagrama de Bode para l=',num2str(l)))
end

% frequ�ncia = 100BPM
% wa=5*pi/3
l=0.1;
amplitude_seno=1;



plot(t,y(:,1))
title('Figura 16 - Evolu��o do �ngulo theta para 100 BPM impondo um bin�rio sinusoidal')

figure
bode(ss(A,B,C,D)) % a fun�ao ss cria o modelo de espa�o de estados em tempo cont�nuo
title(strcat('Diagrama de Bode para l=',num2str(l)))
title('Figura 17 - Diagrama de bode para 100 BPM')

%%
% O diagrama de bode confirma que os polos s�o complexos conjugados e como
% tal csi varia entre zero e um, definindo um sistema sub-amortecido.
%
% O sistema � causal e est�vel uma vez que os p�los encontram-se no 
% semiplano esquerdo.
%
% Usando uma fun��o sinusoidal como bin�rio de entrada o metr�nomo acaba 
% por tender para um regime oscilat�rio com frequ�ncia igual � frequ�ncia 
% de entrada, mas o que se pretende � que, com um impulso inicial, o 
% metr�nomo seja capaz de manter as oscila��es iniciais conjugando as 
% for�as da mola com as for�as dos pesos, n�o sendo necess�rio fornecer um 
% bin�rio sinusoidal. Desta forma o metr�nomo em vez de oscilar por si s� 
% estava constantemente a ser for�ado n�o sendo esse o seu objectivo de
% funcionamento.
