clear all; clc;close all;

%% Q2
m0 = 1;
m = 1:-0.01:0.01; % terminal mass array
r = m0./m;
v = 250*9.8.*log(r);
plot(r,v,LineWidth=2); xlabel('M0/M'); ylabel('Terminal Speed (v [m/s])');
title('Terminal Speed as a Function of Ratio of Mass');
legend('Terminal Speed');
%% Q6
syms x
var = 0.25;
f = @(x) (1/(sqrt(2*pi*var))) * exp((-1*(x-1).^2)/(2*var)) .* sind(x);
three_sigma = integral(f, -0.5, 2.5)
four_sigma = integral(f, -1, 3)


