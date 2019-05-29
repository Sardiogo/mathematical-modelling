function [sinal, tempo] = geradora_ut(T,alpha,beta,U1,U2,n1,n2)
% Esta fun��o recebe sete parametros para construir e devolver dois 
% vectores: Um dos vectores � ('sinal(t)') com os valores do sinal de 
% controlo u(t), o outro � vector (tempo) com n1+n2-1 elementos.  
      
    T1 = T/(1 + alpha);
    %dura��o do 1� flanco do sinal
    T2 = alpha*T1;
    %dura��o do 2� flanco do sinal
    t1 = linspace(0,T1,n1); 
    % intervalo de tempo para o 1� flanco com n1 pontos   
    t2 = linspace(T1+(T2/(n2-1)),T,n2-1);
    % intervalo de tempo para o 2� flanco com n2-1 pontos
    
    % Inicializa��o dos vectores a returnar
    tempo = horzcat(t1,t2);
    sinal(1:n1+n2-1) = 0;
    
    % Constru��o do sinal u(t)
    
    %1� flanco
    i = find( (tempo >= 0) & (tempo <= T1) );
    aux=i;
    t = linspace(-(1+beta)/2,(1+beta)/2,length(aux));
    sinal(aux) = U1 * geradora_pb(t,beta);
    
    % 2� flanco
    i = find( (tempo > T1) & (tempo <= T) );
    aux=i;
    t = linspace(-(1+beta)/2,(1+beta)/2,length(aux));
    sinal(aux) = U2 * geradora_pb(t,beta);

end