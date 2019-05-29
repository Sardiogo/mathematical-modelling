% Com m=0.09kg usamos as duas posições de mass determinadas na questão 9:
%
% Para 150 BPM : l=0.077586.
%
% Para 50 BPM : l=0.20862.

x0 = [pi/4 0]';

%duas posições de massa calculadas na alínea anterior

for l=[0 0.2]

    J = ((M*(L^2))/3) + m*(l^2); % Momento de inércia
    cte= m*g*l+M*g*L/2;
    wn = sqrt((k-cte)/J);
    qsi = beta/(2*J*sqrt((k-cte)/J));
    A = [0 1;(m*g*l+(M*g*L/2)-k)/(((M*(L^2))/3)+m*(l^2)) -beta/J];
    B = [0 1]';
    sim('Q6',5)
    figure
    bode(ss(A,B,C,D)) %a funçao ss cria o modelo de espaço de estados em tempo contínuo
    title(strcat('Figura',num2str(r),' - Diagrama de Bode para l=',num2str(l)))
end

% frequência = 100BPM
% wa=5*pi/3
l=0.1;
amplitude_seno=1;



plot(t,y(:,1))
title('Figura 16 - Evolução do ângulo theta para 100 BPM impondo um binário sinusoidal')

figure
bode(ss(A,B,C,D)) % a funçao ss cria o modelo de espaço de estados em tempo contínuo
title(strcat('Diagrama de Bode para l=',num2str(l)))
title('Figura 17 - Diagrama de bode para 100 BPM')

%%
% O diagrama de bode confirma que os polos são complexos conjugados e como
% tal csi varia entre zero e um, definindo um sistema sub-amortecido.
%
% O sistema é causal e estável uma vez que os pólos encontram-se no 
% semiplano esquerdo.
%
% Usando uma função sinusoidal como binário de entrada o metrónomo acaba 
% por tender para um regime oscilatório com frequência igual à frequência 
% de entrada, mas o que se pretende é que, com um impulso inicial, o 
% metrónomo seja capaz de manter as oscilações iniciais conjugando as 
% forças da mola com as forças dos pesos, não sendo necessário fornecer um 
% binário sinusoidal. Desta forma o metrónomo em vez de oscilar por si só 
% estava constantemente a ser forçado não sendo esse o seu objectivo de
% funcionamento.
