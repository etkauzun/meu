% hw1_q4
clear; clc; format long

% coordinates
coord = ... 
   [32.7335556, -117.1896667; % KSAN
   37.6167,     -122.3750];   % KSFO
coord = deg2rad(coord);

% setting constants (in ft/s)
%   ~ 1 nmi = 6076ft
v_air = 180 * 6076 / 3600; % [ft/s]
t_no_wind = 130/60; % [s]
v_wind = 20 * 6076 / 3600; % west to east [ft/s]

% finding the (rhumb) distance when there is no wind
dist = v_air * t_no_wind;

% using the rhumb course eqns to find the heading angle (CHIg)
lat_a = coord(1,1); lat_b = coord(2,1);
longt_a = coord(1,2); longt_b = coord(2,2);
tau_a = log(sec(lat_a) + tan(lat_a));
tau_b = log(sec(lat_b) + tan(lat_b));
heading = atan((longt_b-longt_a)/(tau_b-tau_a));

% finding the path heading
p_heading = heading + asin(-1*(v_wind/v_air)*cos(heading));

% finding the ground speed
v_ground = v_air*cos(p_heading-heading) + v_wind*sin(heading);

% finding the time with wind
ans = (dist/v_ground)*60