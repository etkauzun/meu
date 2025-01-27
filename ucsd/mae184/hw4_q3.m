clear all; clc; close all; format long
% hw4_q3

% Load the data
t38 = load('T38_aileron.csv');
t = t38(:,1);
Da = t38(:,2);
p = t38(:,3);
phi = t38(:,4);

% Set-up the flight conditions & geometry
h = 40000; % ft
M = 0.86; 
qbar = 200; % lbf/ft2
V = 830; % ft/s
b = 25.5; % ft
S = 170; % ft2
Ixx = 7850; % slug/ft3
pb2v = (p.*b)/(2*V);


% Equations of Motion
dphidt = gradient(phi,t);
dpdt = gradient(p,t);
Cl = (Ixx*dpdt)/(qbar*S*b);

% Prepare data for regression
X = [pb2v, Da]; % independent variables
Y = Cl; % dependent variable

% Perform linear regression to find Cl_p and Cl_dA
coeffs = X \ Y;

Cl_p = coeffs(1); % answer
Cl_dA = coeffs(2);

% Display the result
fprintf('Estimated Cl_p: %.4f\n', Cl_p);