function [sinal, tempo] = geradora_ut(T,alpha,beta,U1,U2,n1,n2)
% Esta função recebe sete parametros para construir e devolver dois 
% vectores: Um dos vectores é ('sinal(t)') com os valores do sinal de 
% controlo u(t), o outro é vector (tempo) com n1+n2-1 elementos.  
      
    T1 = T/(1 + alpha);
    %duração do 1º flanco do sinal
    T2 = alpha*T1;
    %duração do 2º flanco do sinal
    t1 = linspace(0,T1,n1); 
    % intervalo de tempo para o 1º flanco com n1 pontos   
    t2 = linspace(T1+(T2/(n2-1)),T,n2-1);
    % intervalo de tempo para o 2º flanco com n2-1 pontos
    
    % Inicialização dos vectores a returnar
    tempo = horzcat(t1,t2);
    sinal(1:n1+n2-1) = 0;
    
    % Construção do sinal u(t)
    
    %1º flanco
    i = find( (tempo >= 0) & (tempo <= T1) );
    aux=i;
    t = linspace(-(1+beta)/2,(1+beta)/2,length(aux));
    sinal(aux) = U1 * geradora_pb(t,beta);
    
    % 2º flanco
    i = find( (tempo > T1) & (tempo <= T) );
    aux=i;
    t = linspace(-(1+beta)/2,(1+beta)/2,length(aux));
    sinal(aux) = U2 * geradora_pb(t,beta);

end