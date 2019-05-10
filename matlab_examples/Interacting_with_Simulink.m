%% Matlab script example interacting with Simulink
%
% This is an example of a Matlab script that interacts with a Simulink
% model for the water tank level.
%
% Revisions: N/A

% Clear workspace and close all figures;
clear;
close all;

% Tank parameters
A = 1;
a = 0.02;
g = 9.8;

% Initial condition
h0 = 1;

% Final time
final_time = 100;

% Set of inputs
u_set = [0 0.05 0.1];

% Set of colors
color_set = hsv(length(u_set));

% Simulate system and plot results
figure;
hold on;
for counter = 1:length(u_set)
    u = u_set(counter);
    
    sim('waterTankMdl');
    plot(t, h, 'color', color_set(counter, :));
end
xlabel('t (s)');
ylabel('h (m)');
grid on;
title('Evolution of the tank level');

legend(sprintf('u = %f', u_set(1)), ...
       sprintf('u = %f', u_set(2)), ...
       sprintf('u = %f', u_set(3)));


%%
% For u = 0, how long does it take to empty the tank?
%
% $$t = 2\frac{A}{a} \sqrt{\frac{h_0}{2g}}$$

%%
% In this case...
2*A/a*sqrt(h0/(2*g))