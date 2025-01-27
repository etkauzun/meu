% midterm_q6
clc; clear all;

% initial conditions
W = 2950;
V = 135*3600;
D = 254;
dhdt = 14.5*3600;
eta = 0.8;
heading = asin(dhdt/V);
cp = 0.6/(550*3600);

T = D + W*sin(heading);
dwdt = -cp*T*V/eta