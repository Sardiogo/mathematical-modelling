function sinal = geradora_pb(t, beta)
% Esta fun��o recebe dois parametros e devolve um vector ('sinal(t)') com
% os valores do impulso prot�tipo em cada instante fornceido por t. 
% 1�parametro -> t, vector com os instantes temporais
% 2�parametro -> beta, valor de beta.
    
    % inicializa��o do vecrtor com os valores do sinal a returnar a zeros
    sinal = zeros(size(t));
    
    % intervalo 1
    % localiza��o e cria��o dos indices do vector em que o sinal deve ter
    % amplitude igual os valores em que se d� a transi��o entre metade do 
    % flano alto e o flanco baixo do sinal.
    i = find( (t >= -(1+beta)/2) & (t <= -1/2) );
    aux=i;
    sinal(aux)= (1/beta) + (1/2) + ((2/beta)*(t(aux))) + ((2/(((beta)^2)))*((t(aux))+1/2).^2) ;   
    
    % intervalo 2
    % localiza��o e cria��o dos indices do vector em que o sinal deve ter
    % amplitude igual os valores em que se d� a transi��o entre o flano 
    % alto do sinal e metade desse valor.
    i = find( (t > -1/2) & (t <= -(1-beta)/2) );
    aux=i;
    sinal(aux)= (1/beta) + (1/2) + ((2/beta)*(t(aux))) - ((2/(((beta)^2)))*((t(aux))+1/2).^2) ;
    
    % intervalo 3
    % Localiza��o e cria��o dos indices do vector em que o sinal deve ter
    % amplitude 1.
    i = find( (t > -(1-beta)/2) & (t <= (1-beta)/2) );
    aux=i;
    sinal(aux)= 1 ;   
    
    % intervalo 4
    % localiza��o e cria��o dos indices do vector em que o sinal deve ter
    % amplitude igual os valores em que se d� a transi��o entre o flano 
    % alto do sinal e metade desse valor.
    i = find( (t > (1-beta)/2) & (t <= 1/2) );
    aux=i;
    sinal(aux)= (1/beta) + (1/2) - ((2/beta)*(t(aux))) - ((2/(((beta)^2)))*((t(aux))-1/2).^2) ;  
    
    % intervalo 5
    % localiza��o e cria��o dos indices do vector em que o sinal deve ter
    % amplitude igual os valores em que se d� a transi��o entre metade do 
    % flano alto e o flanco baixo do sinal.
    i = find( (t > 1/2) & (t <= (1+beta)/2) );
    aux=i;
    sinal(aux)= (1/beta) + (1/2) - ((2/beta)*(t(aux))) + ((2/(((beta)^2)))*((t(aux))-1/2).^2) ;  
        
end