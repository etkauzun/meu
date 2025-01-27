% midterm_q5
clc; clear all;

% simulation set-up
dt = 0.1;

% setting initial condition
x = [0;0];     

% run simluation
for i = 1:2
    xs(:,i) = x; % storing state vector in columns
    x = Euler(x,dt);
end % for loop

xs
ans = xs(2,:)

function xdot = EOM(x)
    % set parameters
    delta_A = 0.1; % [rad]

    % extract state vector variables
    t = x(1);
    p = x(2);

    % differential eqn
    dpdt = -3.1*p + 9.2*delta_A;

    % creating the output vector
    xdot = zeros(2,1);
    xdot(1) = 1; % time [s]
    xdot(2) = dpdt;
end % function

function xnew = Euler(xold, h)
    r1 = EOM(xold);
    r2 = EOM(xold + h*r1);
    xnew = xold + h*0.5*(r1+r2);
end % Euler function