clear all; clc; close all; format long

rho = 0.00127; S = 280; W = 11,000;
u = 450; v = 0; w = 8;
V = sqrt(u^2 + v^2 + w^2);
alpha = atan(w/u);
Cd = 0.027 + 0.13*alpha;
Cl = 0.2 + 5.5*alpha;
q = 0.5 * rho * V^2;

D = q*S*Cd % Tx

% Tx = W*sin(alpha) - (-Cd*cos(alpha) + Cl*sin(alpha))*q*S
% Tz = -W*cos(alpha) + (Cd*sin(alpha) + Cl*cos(alpha))*q*S

ro = [0;0;-1]; rp = [0.8;0.8;0]; rb = rp;
theta = deg2rad(30);  
Tl2b = [cos(theta) 0 -sin(theta); 0 1 0; sin(theta) 0 cos(theta)];
Tb2l = Tl2b';
ra = ro + Tb2l*rp - rb;
q6 = sqrt(ra(1)^2 + ra(2)^2 +ra(3)^2)