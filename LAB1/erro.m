function erros = erro(parametros) 
% 1�parametro -> valor de N2(0)
% 2�parametro -> valor de alpha2
    delta1=3.1;
    alpha1=1.4;
    delta2=-1.5;
    N10 = 4;
    N20 = parametros(1);
    alpha2 = parametros(2);      
    load('presas.mat')
    sim('predador_presa', tr,simset('SrcWorkspace', 'current'))
    %simulacao do diagrama do modelo presa-predador com dura��o(tr) igual � 
    %dada pelo ficheiro presas.mat
    erros=norm(yr-N1,1);
    %calcula o erro (absoluto) m�ximo entre os valores fornecidos e os 
    %correspondentes valores calculados,nos mesmos instantes de tempo.
end