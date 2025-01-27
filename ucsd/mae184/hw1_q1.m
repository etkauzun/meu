% hw1_q1
clear; clc;

% setting parameters:
m = 200; rho = 0.002377; vol = 89300; Cd = 0.044; v_ini = 70;

% setting the simulation
dt = 0.1; % timestep
nsteps = 30/dt; % simualtion duration over timesteps

% v array
v_arr = [v_ini];

% run simulation
for i = 1:nsteps
    v = v_arr(i);
    v_arr(i+1) = v + dt*((-0.5*rho*(v^2)*vol^(2/3)*Cd)/m);
end % for 

ans = v_arr(end)
