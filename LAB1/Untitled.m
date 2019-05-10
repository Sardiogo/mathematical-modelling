%% Questão 2.4.b) Ajuste de parametros por estimação do erro absoluto
% De forma a obter uma estimativa dos valores de N2(0) e ${\alpha}_{2}$ da 
% população de predadores começa-se por fazer um varrimento de possíveis 
% valores destes parâmetros e, para cada par de valores, estimar o erro 
% absoluto ou soma dos valores absolutos das diferenças entre os valores 
% fornecidos e os calculados.
% Os valores são escolhidos tendo em conta que, na alínea anterior, foi
% obtida uma aproximação aos valores de N2(0) e ${\alpha}_{2}$ por 
% tentativa e erro.
% Na alínea anterior foram obtidos dois pares de valores: 
% N2(0)= 1.6 e ${\alpha}_{2}$=0.7
%%

p=15; % numero de valores de N0 e alpha a testar
erros = zeros(p, p); % icialização da matriz com os valores de erro    
N20_min=1.4;
N20_max=1.8;
alpha2_min=0.5;
alpha2_max=0.9;
%%
% Pelas aproximacoes feitas na alinea 2.4a) sabemos que
% valores de ${\alpha}_{2}$ e N2(0) estão dentro destes parametros, e os
% intervalos foram escolhidos de modo a haver coerencia entre os dados 
% fornecidos pelo ficheiro presas.mat
N20_aux=linspace(N20_min,N20_max,p); 
% N2(0) -> espaço linear, vector de p pontos entre N20_min e N20_max
alpha2_aux=linspace(alpha2_min,alpha2_max,p); 
% alpha2 -> espaço linear, vector de p pontos entre alpha2_min e alpha2_max

h = waitbar(0, 'A calcular erros... Está quase...');
set(h,'HandleVisibility','off')
for i=1:p
    for j=1:p
        alpha2 = alpha2_aux(i);
        N20 = N20_aux(j);
        % erros(i,j)=erro([N20_aux(j) alpha2_aux(i)]);
        erros(i,j)=erro([N20 alpha2]);
    end
    delete(h);
    h = waitbar(i/p, 'A calcular erros... Está quase...');
    % barra de loading a apresentar durante simulação
end
delete(h);

figure(n)
fig = figure(n);
set(fig, 'Position', [0, 0, 700, 500])  % x, y, largura e comprimento da figura
n=n+1;
subplot(2,1,1)
surfc(alpha2_aux,N20_aux,erros);
xlabel('{\alpha }_{2}'); ylabel('N2(0)'); zlabel('Erro'); colorbar;
title('Superfície de Erro')
subplot(2,1,2)
contour(alpha2_aux,N20_aux,erros,100);% 100 linhas de contorno
xlabel('{\alpha }_{2}'); ylabel('N2(0)'); colorbar;
title('Curvas de nível')
%%
% Os valores de ${\alpha}_{2}$ e N2(0) não são facilmente estimados pela 
% observação dos gráficos anteriores, sendo apenas possível estimar um 
% intervalo de valores. 
% A precisão da estimação depende do número (p) de valores a testar e 
% do intervalo entre o valor mínimo e o máximo.
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

for i=1:p
    for j=1:p
        alpha2 = alpha2_aux(i);
        N20 = N20_aux(j);
        erros(i,j)=erro([N20 alpha2]);
    end
    delete(h);
    waitbar(i/p, 'A calcular erros... Está quase...');
end
delete(h);

figure(n)
fig = figure(n);
set(fig, 'Position', [0, 0, 700, 500])  % x, y, largura e comprimento da figura
n=n+1;
subplot(2,1,1)
surfc(alpha2_aux,N20_aux,erros);
xlabel('{\alpha }_{2}'); ylabel('N2(0)'); zlabel('Erro'); colorbar;
title('Superfície de Erro')
subplot(2,1,2)
contour(alpha2_aux,N20_aux,erros,100);% 100 linhas de contorno
xlabel('{\alpha }_{2}'); ylabel('N2(0)'); colorbar;
title('Curvas de nível')