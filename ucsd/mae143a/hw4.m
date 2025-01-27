clear; clc; close all;

%% q2
% c
F2a = tf([0 0 1], [1 0.77 1])
figure(1)
bode(F2a)

F2b = tf([0 0 1], [1 1.85 1])
figure(2)
bode(F2b)

F2c = tf([0 0 1], [1 2.62 3.4245 2.62 1])
figure(3)
bode(F2c)

% d
F4=RR_tf([1],[1 2.62 3.4245 2.62 1])
figure(4), RR_bode(F4)
figure(5), RR_step(F4)
figure(6), g.T=10; RR_impulse(F4,g)

