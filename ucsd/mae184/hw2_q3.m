% hw2_q3
clear;  clc

% initilizing variables
V = 33; % [m/s]
g = 9.81;
dchi = deg2rad(360);
dchidt = dchi/120; % [rad/s]

mu = atan(V*dchidt/g);
ans = rad2deg(mu)