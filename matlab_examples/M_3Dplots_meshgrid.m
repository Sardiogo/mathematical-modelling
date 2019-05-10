%% Matlab script example - 3-D plots and meshgrid
%
% This is an example of a Matlab script that plots f(x,y) = x^2 + y^2 in
% 3D. It introduces the concept of meshgrid and a number of different ways
% to do 3-D plots.
%
% Revisions: N/A

% Clear workspace and close all figures;
clear;
close all;

% Generate pairs (x,y)
[x, y] = meshgrid((-1:0.1:1), (-1:0.1:1));


% Plot results
figure;
mesh(x, y, x.^2+y.^2);
xlabel('x'); ylabel('y'); colorbar;
figure;
surf(x, y, x.^2+y.^2);
xlabel('x'); ylabel('y'); colorbar;
figure;
surfc(x, y, x.^2+y.^2);
xlabel('x'); ylabel('y'); colorbar;
figure;
contour(x, y, x.^2+y.^2);
xlabel('x'); ylabel('y'); colorbar;