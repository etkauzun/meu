% hw2_q1
clear; clc; close;

% Initialize Variables
m = 12000;                          % Mass of the object in kg
S = 29;                             % Reference area in square meters
rho = 0.78;                         % Density of air in kg/m^3
a = 322;                            % Local speed of sound in m/s
W = m * 9.81;                       % Weight of the object in Newtons
L = W;                              % Lift force (assumed equal to weight for equilibrium)
h = 4.5;                            % Altitude in kilometers
V = 0.1 * a;                        % Initial speed guess at Mach 0.1 [m/s]
V_vec = zeros(2,1);                 % Initialize solution vector for velocities

% Main loop to find velocities at two different conditions
for i = 1:2
    error = 100;                    % Initialize error [N]
    while error > 0.1               % Stops when error is less than 0.1 N
        q = 0.5 * rho * V^2;        % Dynamic pressure
        M = V / a;                  % Mach number
        % Thrust equation based on given empirical formula
        T = (78.7 + (13.3 * M) - (6.3 * h) + (0.13 * h^2) + (7.3 * M^2) - (h * M)) * 1000;
        % Drag coefficient modifiers
        K = 0.7 + 0.2 * tanh(5 * (M - 0.95));
        CD0 = 0.04 + 0.02 * tanh(5 * (M - 0.95));
        % Lift coefficient calculation
        CL = L / (q * S);
        % Total drag coefficient
        CD = CD0 + (K * CL^2);
        % Drag force
        D = q * S * CD;
        % Compute error as the absolute difference between thrust and drag
        error = abs(T - D);         % T must equal D for steady level flight
        % Adjust velocity based on error, scaling step size
        V = V + (error/a) * 0.0001;   
    end
    V_vec(i) = V;                   % Store solution
    V = V + 1;                      % Increment velocity for next iteration
end

% Display results
disp(['Lower Velocity (m/s): ', num2str(V_vec(1))]);
disp(['Upper Velocity (m/s): ', num2str(V_vec(2))]);
disp(['Residual Error (N): ', num2str(error)]);
disp(['Mach Number Lower: ', num2str(V_vec(1) / a)]);
disp(['Mach Number Upper: ', num2str(V_vec(2) / a)]);

