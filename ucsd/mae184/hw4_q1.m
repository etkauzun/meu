clear all; clc; close all; format long
% hw4_q1: 2D data interpolation

% Set the values
x = 0.44; y = 900;
x1 = 0.4; y1 = 0;
x2 = 0.6; y2 = 2000;
f11 = 83487; f12 = 68952; f21 = 86328; f22 = 71665;

fxy1 = f11*((x2-x)/(x2-x1)) + f21*((x-x1)/(x2-x1));
fxy2 = f12*((x2-x)/(x2-x1)) + f22*((x-x1)/(x2-x1));

hw4q1 = fxy1*((y2-y)/(y2-y1)) + fxy2*((y-y1)/(y2-y1))