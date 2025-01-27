% hw3_q5
clc; clear all; close all;

% properties
P = 130*550; % ft.lb/s
D = 6.75; % ft
n = 1800/60; % rev/s
V = 170; % ft/s

% soln
J = V/(n*D); % = 0.8395
eff = 0.8; % taking from the graph

ans = eff*P/V