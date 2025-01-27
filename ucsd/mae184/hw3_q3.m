% hw3_q3
clc; clear all; close all;

% table values
x0 = 8; x1 = 12; x = 11; % degrees
cl0 = 0.713; cl1 = 0.945;

ans = cl0 + ((x-x0)/(x1-x0))*(cl1-cl0)