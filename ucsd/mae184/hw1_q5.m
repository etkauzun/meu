% hw1_q5
clear; clc; format long

% find rho(5280ft)/rho(0ft) using the eqns of the gradient regions as the altitude falls into the troposphere

% setting constant properties
R = 1716; g = 32.2;
   % MIL-STD-210A table @ https://www.pdas.com/milstd210.html
a = (543.4-562.7)/(5000-0); % dt/dh = lapse rate
T_alt = 542.284; % in [R] obtained by linear interpolation
T_sea = 562.7;

ans = (T_alt/T_sea)^(-1*(1+(g/(a*R))))
