clear all; clc; close all; format long
%% hw4_q4

% Set-up
p1 = sqrt(5);
p2 = sqrt(5);
p3 = sqrt(5);
L1 = 2;
L2 = sqrt(2);
L3 = sqrt(2);
gamma = pi/2;
x1 = 4; x2 = 0; y2 = 4;

% Set-up A2, B2, A3, B3 eqns 
A2 = @(theta) L3 * cos(theta) - x1;
B2 = @(theta) L3 * sin(theta);
A3 = @(theta) L2 * cos(theta + gamma) - x2;
B3 = @(theta) L2 * sin(theta + gamma) - y2;

% Set-up the forward problem equations
syms theta;
A2_sym = A2(theta); % A2 value
B2_sym = B2(theta); 
A3_sym = A3(theta);
B3_sym = B3(theta);
D = 2 * (A2_sym * B3_sym - B2_sym * A3_sym);
N1 = B3_sym * (p2^2 - p1^2 - A2_sym^2 - B2_sym^2) - B2_sym * (p3^2 - p1^2 - A3_sym^2 - B3_sym^2);
N2 = A2_sym * (p3^2 - p1^2 - A3_sym^2 - B3_sym^2) - A3_sym * (p2^2 - p1^2 - A2_sym^2 - B2_sym^2);
x_sol = N1 / D;
y_sol = N2 / D;

% Solve for theta
theta_solutions = solve(N1^2 + N2^2 - p1^2 * D^2 == 0, theta); % solves symbolic algebraic eqns
theta_solutions = double(theta_solutions); % Convert symbolic format to numeric format

% Calculate corresponding (x, y) for each theta solution
x_solutions = double(subs(x_sol, theta, theta_solutions)); % subs substitutes theta_solutions (numeric) in place of theta (symolic) to solve the eqn
y_solutions = double(subs(y_sol, theta, theta_solutions));

% Display results
disp('Possible positions and orientations:');
for i = 1:length(theta_solutions)
    fprintf('x = %.4f, y = %.4f, theta = %.4f [rad]\n', x_solutions(i), y_solutions(i), theta_solutions(i));
end
