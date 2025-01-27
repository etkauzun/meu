clear all; clc;close all;

syms e1 e2 e3 v1 v2 v3 a b e t

% S = [0 -e3 e2;e3 0 -e1;-e2 e1 0];
% v = [v1;v2;v3];
% e = [e1;e2;e3];
I = [1 0 0;0 1 0;0 0 1];
% 
% %% Sv = e*v
% S*v
% cross(e,v)
% 
% % correct
% %% (I-eeT)v = S^2v
% (I - e*e.')*v
% (S^2)*v
% 
% % incorrect
% %% S^3 v = Sv
% S^3 * v
% S*v
% 
% % incorrect
% %% eT S = Se = 0
% e.' * S
% S*e

% correct
%% q6
% a = pi/6; b = 0.2625;
% g2 = [cos(a) 0 sin(a);0 1 0;-sin(a) 0 cos(a)];
% g3 = [cos(b) -sin(b) 0;sin(b) cos(b) 0;0 0 1];
% g = g2*g3;
% [evector, eval] = eig(g);
% diag = g(1,1) + g(2,2) + g(3,3);
% angle = acos(0.5*(diag-1))
%%
e = (1/sqrt(14))*[1;2;3];
phi = 0.2;
phidot = 0.01;
Se = (1/sqrt(14))*[0 -3 2;3 0 -1;-2 1 0];
gbar = cos(phi)*I + (1-cos(phi))*e*e.' - sin(phi)*Se
gbardot = sin(phi)*e*e.'*phidot - sin(phi)*I*phidot - cos(phi)*Se*phidot;

q7a = gbardot*[4;-4;2] + gbar*[0.1;0;-0.2]

xdot = [0.1;0;-0.2];
phidot = 0.01;
x_20 = [2; -4;6] + [0.1;0;-0.2]*20;

q7b = gbar * (xdot - phidot*Se*x_20)

q7c = gbar * (xdot - cross((phidot*e),x_20))
