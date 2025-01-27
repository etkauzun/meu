close all; clear all; clc;
% MAE 155A HW1
%% q2
% a = optimistic estimate
% b = pessimistic estimate
% m = most likely estimate
% d = expected duration
% sigma = std deviation for task duration
d_i = @(a,b,m) (a+(4*m)+b)/6;
sig_i = @(a,b) (b-a)/6;

data = [10 7 14;7 4 12;7 5 21;5 4 10]; % Order: m a b
task_no = length(data);

d_vec = zeros(1,task_no);
sig_vec = zeros(1,task_no);

for i = 1:task_no
    a = data(i, 2);
    b = data(i, 3);
    m = data(i, 1);

    d_vec(1,i) = d_i(a,b,m);
    sig_vec(1,i) = sig_i(a,b);
end

d = sum(d_vec); % Expected Duration of All Tasks
sigma = sqrt(sum(sig_vec.^2)); % Std Dev. of The Expected Duration

Pr = cdf('Normal',28,d,sigma);
%% q4
S = 11.45;
K = 0.024;
CD0 = 0.03;
TO_m = 1020;
F_m = 295;
n = 0.9;
BSFC = 2.6/1000; % cp
g = 9.81;
rho = 1.225;

Wf = (TO_m - F_m) * g;
Wi = (TO_m) * g;

CLCD = (3*CD0/K)^(3/4) /(4*CD0);

E = (n/BSFC) * CLCD * (2*rho*S)^(1/2) * ((Wf^(-1/2)) - (Wi^(-1/2)))
