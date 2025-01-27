% hw2_q5
clear; 
clc; 

% simulation set-up
dt = 0.01;
time = 1.8;
nsteps = 1.8*100;

% initial conditions
phi = deg2rad(11);
theta = deg2rad(-30);
psi = deg2rad(0);
b0_0 = cos(phi/2)*cos(theta/2)*cos(psi/2) + sin(phi/2)*sin(theta/2)*sin(psi/2);
bx_0 = sin(phi/2)*cos(theta/2)*cos(psi/2) - cos(phi/2)*sin(theta/2)*sin(psi/2);
by_0 = cos(phi/2)*sin(theta/2)*cos(psi/2) + sin(phi/2)*cos(theta/2)*sin(psi/2);
bz_0 = cos(phi/2)*cos(theta/2)*sin(psi/2) - sin(phi/2)*sin(theta/2)*cos(psi/2);

x = [0;b0_0;bx_0;by_0;bz_0];

% run simulation
for i = 1:nsteps
    xs(:,i) = x; % store state vector in columns
    x = RK4(x, dt); % RK4 step
end % for loop

% extracting variables
times = xs(1, :); % time vector [s]
b0 = xs(2, :); 
bx = xs(3, :);
by = xs(4, :);
bz = xs(5, :);

% plotting
figure(1); hold on; grid on;
plot(times, b0, 'LineWidth',2);
plot(times, bx, 'LineWidth',2);
plot(times, by, 'LineWidth',2);
plot(times, bz, 'LineWidth',2);
xlabel('Time [s]'); ylabel('Quaternion Values');
legend('b0','bx','by','bz');
title('Quaternions in time');

function xdot = EOM(x)
    % setting the parameters
    p = deg2rad(98); 
    q = deg2rad(35);
    r = deg2rad(170);
    pqr = [p;q;r];

    % extracting the state variables from the input vector
    t = x(1);
    b0 = x(2);
    bx = x(3);
    by = x(4);
    bz = x(5);
    
    q_arr = [-bx, -by, -bz;...
            b0, -bz, by;...
            bz, b0, -bx;...
            -by, bx, b0;];

    % differential eqns/matrix
    quat = 0.5*q_arr *pqr;
    b0dot = quat(1);
    bxdot = quat(2);
    bydot = quat(3);
    bzdot = quat(4);

    % creating the output vector
    xdot = zeros(5,1);
    xdot(1) = 1; % time
    xdot(2) = b0dot;
    xdot(3) = bxdot;
    xdot(4) = bydot;
    xdot(5) = bzdot;

end % EOM function

% RK4 Integration
function xnew = RK4(xold, h)
    r1 = EOM(xold);
    r2 = EOM(xold + 0.5*h*r1);
    r3 = EOM(xold + 0.5*h*r2);
    r4 = EOM(xold + h*r3);
    xnew = xold + (h/6.0)*(r1 + 2.0*r2 + 2.0*r3 + r4);
end