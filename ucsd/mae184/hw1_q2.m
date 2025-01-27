% hw1_q2
clear; clc; format long

% setting the constants
Ixx = 15000; % [kg.m2] 
b = 11.4; % [m]
S = 22.2; % [m2]
rho = 1.22; % [kg/m3]
V = 53; % [m/s]
phi0 = 5; % [deg]
phi0 = deg2rad(phi0);
p0 = 0; 

% simulation setup
dt = 0.05; % [s]
t = 120/dt;

% pre-allocating p & phi
p_arr = zeros(t,length(t)); 
p_arr(1) = p0;
phi_arr = zeros(t,length(t)); 
phi_arr(1) = phi0;

% eqns
dpdt = @(p, phi) 0.5 * rho * V^2 * S * b * (-0.06*phi + 0.033*p*b/(2*V) ...
        + 0.073*(p*b/(2*V))^3 - 0.36*p*b/(2*V)*phi^2 ...
        + 1.47*(p*b/(2*V))^2*phi) / Ixx;
dphidt = @(p) p;

for i = 1:t
    p = p_arr(i);
    phi = phi_arr(i);

    r1p = dpdt(p,phi);
    r1phi = dphidt(p);

    p = p_arr(i) + (0.5*r1p*dt); % updating p value for the next iteration
    phi = phi_arr(i) + (0.5*r1phi*dt);

    r2p = dpdt(p,phi);
    r2phi = dphidt(p);

    p = p_arr(i) + (0.5*r2p*dt);
    phi = phi_arr(i) + (0.5*r2phi*dt);

    r3p = dpdt(p,phi);
    r3phi = dphidt(p);

    p = p_arr(i) + (r3p*dt);
    phi = phi_arr(i) + (r3phi*dt); 

    r4p =  dpdt(p,phi);
    r4phi = dphidt(p); 

    p_arr(i+1) = p_arr(i) + (r1p+ 2*r2p+ 2*r3p + r4p)*dt/6;
    phi_arr(i+1) = phi_arr(i) + (r1phi+ 2*r2phi+ 2*r3phi + r4phi)*dt/6;
end % for

p_arr = rad2deg(p_arr);
phi_arr = rad2deg(phi_arr);

figure(1)
plot(p_arr, phi_arr); 
xlabel('Body Axis Roll Rate [deg/s]');
ylabel('Roll Attitude Angle [deg]');
