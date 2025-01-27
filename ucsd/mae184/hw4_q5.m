clear all; clc; close all; format long
%% hw4_q5

% Set-up the constants
q = 30;
aoa = deg2rad(1.8);
ele_a = deg2rad(2);
ch0 = 0; ch_a = -0.06; ch_dE = -0.6;
tail_area = 38.5; tail_ch = 3.4;

% Find
Ch = ch0 + ch_a * aoa + ch_dE * ele_a;
HM = q * tail_ch * tail_area * Ch