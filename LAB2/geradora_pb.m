function sinal = geradora_pb(t, beta)
% Esta função recebe dois parametros e devolve um vector ('sinal(t)') com
% os valores do impulso protótipo em cada instante fornceido por t. 
% 1ºparametro -> t, vector com os instantes temporais
% 2ºparametro -> beta, valor de beta.
    
    % inicialização do vecrtor com os valores do sinal a returnar a zeros
    sinal = zeros(size(t));
    
    % intervalo 1
    % localização e criação dos indices do vector em que o sinal deve ter
    % amplitude igual os valores em que se dá a transição entre metade do 
    % flano alto e o flanco baixo do sinal.
    i = find( (t >= -(1+beta)/2) & (t <= -1/2) );
    aux=i;
    sinal(aux)= (1/beta) + (1/2) + ((2/beta)*(t(aux))) + ((2/(((beta)^2)))*((t(aux))+1/2).^2) ;   
    
    % intervalo 2
    % localização e criação dos indices do vector em que o sinal deve ter
    % amplitude igual os valores em que se dá a transição entre o flano 
    % alto do sinal e metade desse valor.
    i = find( (t > -1/2) & (t <= -(1-beta)/2) );
    aux=i;
    sinal(aux)= (1/beta) + (1/2) + ((2/beta)*(t(aux))) - ((2/(((beta)^2)))*((t(aux))+1/2).^2) ;
    
    % intervalo 3
    % Localização e criação dos indices do vector em que o sinal deve ter
    % amplitude 1.
    i = find( (t > -(1-beta)/2) & (t <= (1-beta)/2) );
    aux=i;
    sinal(aux)= 1 ;   
    
    % intervalo 4
    % localização e criação dos indices do vector em que o sinal deve ter
    % amplitude igual os valores em que se dá a transição entre o flano 
    % alto do sinal e metade desse valor.
    i = find( (t > (1-beta)/2) & (t <= 1/2) );
    aux=i;
    sinal(aux)= (1/beta) + (1/2) - ((2/beta)*(t(aux))) - ((2/(((beta)^2)))*((t(aux))-1/2).^2) ;  
    
    % intervalo 5
    % localização e criação dos indices do vector em que o sinal deve ter
    % amplitude igual os valores em que se dá a transição entre metade do 
    % flano alto e o flanco baixo do sinal.
    i = find( (t > 1/2) & (t <= (1+beta)/2) );
    aux=i;
    sinal(aux)= (1/beta) + (1/2) - ((2/beta)*(t(aux))) + ((2/(((beta)^2)))*((t(aux))-1/2).^2) ;  
        
end