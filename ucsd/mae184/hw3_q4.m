% hw3_q4
clc; clear all; close all;

% CG location in structural axis
cg = [41,0,36.5]/12; % ft

% CM tank locations in structural axis
r_tank = [48,48,59.4]/12; % ft
l_tank = [48,-48,59.4]/12; % ft

% properties
mc = 8.6; % fuel mass [slug]
w = 3; % width [ft]
h = 0.5; % height [ft]
l = 4; % length [ft]

% finding the MoI of the tanks
Ix = (mc/12)*(l^2 + h^2);
% Iy = (mc/12)*(w^2 + h^2);
% Iz = (mc/12)*(w^2 + l^2);

% finding the coordinates of the tanks relative to CG
r_cg = r_tank - cg;
l_cg = l_tank - cg;

% finding the MoI in the body frame (parallel-axis thm)
Ixx_r = Ix + mc*(r_cg(2)^2 + r_cg(3)^2); % right tank
% Iyy_r = Iy + mc*(r_cg(1)^2 + r_cg(3)^2);
% Izz_r = Iz + mc*(r_cg(1)^2 + r_cg(2)^2);

Ixx_l = Ix + mc*(l_cg(2)^2 + l_cg(3)^2); % left tank
% Iyy_r = Iy + mc*(r_cg(1)^2 + r_cg(3)^2);
% Izz_r = Iz + mc*(r_cg(1)^2 + r_cg(2)^2);

Ixx = Ixx_l + Ixx_r % ans = 361.1295
