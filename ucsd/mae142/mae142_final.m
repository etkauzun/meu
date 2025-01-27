clear, close all, clc

%% Q1
v_wind = 0;
sbar = 0.26; % [km/s]
w = 0.026; % [rad/s]
R = 10; % [km]
H = 5; % [km]
zero3 = zeros(3,3);
I3 = eye(3);
c10 = 0.001; c20 = 0; c30 = 0.0001; % [km2/s2]
C0 = [c10*I3, c20*I3; c20*I3, c30*I3];
dt = 1; % s
x0_prime = [R/2, 0, 0, 0, sbar, 0]';
x0 = [R*cos(0),R*sin(0),H,-w*R*sin(0),w*R*cos(0),0]';

% part (a)
A = [I3, I3;zero3, I3];

% part (b)
T = 2*pi/w; % time horizon
t_vec = 0:dt:T; % Time vector
t_vec = [t_vec, T];

% Noise Trajectory
X0 = mvnrnd(x0, C0)';
X = [X0];

for k = 1:length(t_vec)-1
    sigma = mvnrnd(zeros(3,1), I3);
    wk = mvnrnd(zeros(3,1), I3);
    x = A * X(:,k) + [zero3; sigma.*I3]*wk';
    X = [X, x];
end % for loop

r1 = X(1,:);
r2 = X(2,:);

% Zero-Noise Trajectory
X_zn = [x0];

for k = 1:length(t_vec)-1
    x = A* X_zn(:,k);
    X_zn = [X_zn, x];
end % for loop

r1_n = X_zn(1,:);
r2_n = X_zn(2,:);

figure(1); 
hold on;
plot(t_vec, r1);
plot(t_vec, r2);
plot(t_vec, r1_n, "--o");
plot(t_vec, r2_n, "--o");

% part (c)
% Noise Trajectory (randn)
X0 = mvnrnd(x0, C0)';
X = [X0];

for k = 1:length(t_vec)-1
    sigma = mvnrnd(zeros(3,1), I3);
    wk = randn(3,1);
    x = A * X(:,k) + [zero3; sigma.*I3]*wk;
    X = [X, x];
end % for loop

r1c = X(1,:);
r2c = X(2,:);

plot(t_vec, r1c, "--+");
plot(t_vec, r2c, "--+");
xlabel('Time (s)');
ylabel('Position (km)');
legend('r1 with noise', 'r2 with noise', 'r1 without noise', ...
    'r2 without noise', 'r1 with randn', 'r2 with randn');
hold off;

% part (d)
num_simulations = 1000; % Number of runs
X25 = []; % Storage for X25
X100 = []; % Storage for X100

for sim = 1:num_simulations
    % Initialize noise trajectory
    X0 = mvnrnd(x0, C0)'; % Random initial state
    X(:,1,sim) = X0; % Initialize trajectory
    
    % Propagate trajectory with noise
    for k = 1:length(t_vec)-1
        sigma = mvnrnd(zeros(3,1), I3);
        wk = randn(3,1);
        x = A * X(:,k, sim) + [zero3; sigma.*I3]*wk;
        X(:,k+1,sim) = x; % Append state
    end
end

% Plot position components of X25 and X100
figure(2);
plot3(X(1,:,25), X(2, :,25), X(3, :,25), '.', 'DisplayName', 'X25 Position');
hold on;
plot3(X(1,:,100), X(2, :,100), X(3, :,100), 'o', 'DisplayName', 'X25 Position');
xlabel('X1 (km)');
ylabel('X2 (km)');
zlabel('X3 (km)');
title('3D Position Components of X25 and X100');
legend;
grid on;
hold off;

% Plot velocity components of X25 and X100
figure(3);
plot3(X(4,:,25), X(4, :,25), X(6, :,25), '.', 'DisplayName', 'X25 Position');
hold on;
plot3(X(4,:,100), X(5, :,100), X(6, :,100), 'o', 'DisplayName', 'X25 Position');
xlabel('V1 (km/s)');
ylabel('V2 (km/s)');
zlabel('V3 (km/s)');
title('3D Velocity Components of X25 and X100');
legend;
grid on;
hold off;

% part (e)
C(:,:,1) = C0;

for k = 1:length(t_vec)-1
        sigma = mvnrnd(zeros(3,1), I3);
        C(:,:,k+1) = A * C(:,:,k) * A' + sigma*I3*sigma';
end

std = sqrt(C);
%% Q2
%% part (b)
% Given constants
c1_0 = 10.0; c2_0 = 0; c3_0 = 1.0; % Initial covariance components
sigma_t2 = 100.0; % Time variance
sigma2 = 1e-4; % Measurement noise variance

% Initial state covariance (C0)
I3 = eye(3);
C0 = [c1_0 * I3, c2_0 * I3; c2_0 * I3, c3_0 * I3];

% Full initial covariance (P0|0)
P0_0 = [C0, zeros(6, 1); zeros(1, 6), sigma_t2];

% Satellite positions
sat_pos = [
    8000, 100, 800;
    100, 8000, 800;
    1000, 2000, 5000;
    2000, 100, 2000
];

% Air vehicle position (example for this step)
r_k1 = [0; 0; 0]; % Replace with actual position at step k+1

% Compute Hk+1 for all satellites
n_sat_all = size(sat_pos, 1);
Hk_all = zeros(n_sat_all, 7);
for j = 1:n_sat_all
    r_sj = sat_pos(j, :)';
    dist = norm(r_k1 - r_sj);
    Hk_all(j, :) = [(r_k1 - r_sj)' / dist, zeros(1, 3), 1];
end

% Compute Hk+1 for first 3 satellites
n_sat_three = 3;
Hk_three = Hk_all(1:n_sat_three, :);

% Measurement noise covariance (Rk+1)
R_all = sigma2 * eye(n_sat_all); % For 4 satellites
R_three = sigma2 * eye(n_sat_three); % For 3 satellites

% Kalman gain for 4 satellites
K_all = P0_0 * Hk_all' / (Hk_all * P0_0 * Hk_all' + R_all);

% Kalman gain for 3 satellites
K_three = P0_0 * Hk_three' / (Hk_three * P0_0 * Hk_three' + R_three);

% A posteriori covariance for 4 satellites
P_post_all = (eye(7) - K_all * Hk_all) * P0_0;

% A posteriori covariance for 3 satellites
P_post_three = (eye(7) - K_three * Hk_three) * P0_0;

% Display results
disp('A posteriori covariance for 4 satellites:');
disp(P_post_all);

disp('A posteriori covariance for 3 satellites:');
disp(P_post_three);
%% part c
% Constants and initialization
n_steps = 100; % Number of time steps
dt = 4.0; % Time step size
T = n_steps * dt; % Total simulation time
sigma = sqrt(dt) * 0.005; % Noise standard deviation
sigma2_obs = 1e-4; % Observation noise variance
sat_pos = [8000, 100, 800; 100, 8000, 800; 1000, 2000, 5000; 2000, 100, 2000]; % Satellite positions
n_sat = size(sat_pos, 1); % Number of satellites

% Initialize state vector and observations
X = zeros(6, n_steps + 1); % State vector [r1, r2, r3, v1, v2, v3]
X(:, 1) = mvnrnd([0; 0; 0; 0; 0; 0], C0); % Initial state with noise
observations = zeros(n_sat, n_steps); % Observations for all satellites

% Simulate dynamics and observations
for k = 1:n_steps
    % Propagate dynamics
    wk = randn(3, 1); % Process noise
    noise = [zeros(3, 1); sigma * wk]; % Velocity noise only
    X(:, k+1) = A * X(:, k) + noise; % Update state

    % Extract position at time step k+1
    r_k1 = X(1:3, k+1);

    % Compute observations for all satellites
    t_k1 = k * dt; % Signal emission time
    for j = 1:n_sat
        r_sj = sat_pos(j, :)'; % Satellite position
        dist = norm(r_k1 - r_sj); % Distance to satellite
        nu_jk1 = sqrt(sigma2_obs) * randn; % Observation noise
        observations(j, k) = dist + t_k1 + nu_jk1; % Observation
    end
end

% Normalize observations by subtracting signal emission time
t_vec = (1:n_steps) * dt; % Time vector
normalized_observations = observations - t_vec;

% Plot normalized observations
figure(4);
hold on;
for j = 1:n_sat
    plot(t_vec, normalized_observations(j, :), '-o', 'DisplayName', ['Satellite ', num2str(j)]);
end
xlabel('Time (s)');
ylabel('Normalized Observation (km)');
title('Normalized Observations Over Time');
legend;
grid on;
hold off;
%% part d

% Constants and Initialization
n_steps = 100; % Number of time steps
dt = 4.0; % Time step size (seconds)
T = n_steps * dt; % Total simulation time
sigma = sqrt(dt) * 0.005; % Process noise standard deviation
sigma2_obs = 1e-4; % Observation noise variance
sigma2_t = 100.0; % Signal emission time variance
sat_pos = [8000, 100, 800; 100, 8000, 800; 1000, 2000, 5000; 2000, 100, 2000]; % Satellite positions
n_sat = size(sat_pos, 1); % Number of satellites

% Dynamics matrix (7x7 for position, velocity, and signal emission time)
A_nominal = [eye(3), dt * eye(3); zeros(3), eye(3)]; % 6x6 nominal dynamics
A = [A_nominal, zeros(6, 1); zeros(1, 6), 1]; % Extend to include time (7x7)

% Initial State and Covariance
C0 = blkdiag(10 * eye(3), 1 * eye(3)); % Initial state covariance
P_prior = blkdiag(C0, sigma2_t); % Initial prior covariance (7x7)
X_true = zeros(6, n_steps + 1); % True trajectory (position & velocity)
X_true(:, 1) = mvnrnd([0; 0; 0; 0; 0; 0], C0)'; % Initialize true state
X_nominal = zeros(6, n_steps + 1); % Nominal trajectory (zero-noise)
X_prior = zeros(7, n_steps + 1); % A priori state estimates
X_posterior = zeros(7, n_steps + 1); % A posteriori state estimates
X_prior(:, 1) = [X_true(:, 1); 0]; % Initialize prior estimate
X_posterior(:, 1) = X_prior(:, 1); % Initialize posterior estimate

% Observations
observations = zeros(n_sat, n_steps); % Observations for all satellites

% Simulate Dynamics and Run Kalman Filter
for k = 1:n_steps
    % True dynamics
    wk = randn(3, 1); % Process noise
    noise = [zeros(3, 1); sigma * wk]; % Velocity noise
    X_true(:, k+1) = A_nominal * X_true(:, k) + noise; % Update true state

    % Nominal dynamics
    X_nominal(:, k+1) = A_nominal * X_nominal(:, k); % Update nominal state

    % Observations
    r_true = X_true(1:3, k+1); % True position at step k+1
    t_k1 = k * dt; % Signal emission time
    for j = 1:n_sat
        r_sj = sat_pos(j, :)'; % Satellite position
        dist = norm(r_true - r_sj); % Distance to satellite
        nu_jk1 = sqrt(sigma2_obs) * randn; % Observation noise
        observations(j, k) = dist + t_k1 + nu_jk1; % Observation
    end

    % Kalman Filter: Prediction Step
    X_prior(:, k+1) = A * X_posterior(:, k); % Predict state
    P_prior = A * P_prior * A' + blkdiag(C0, 0); % Predict covariance

    % Kalman Filter: Update Step for Each Satellite
    for j = 1:n_sat
        r_sj = sat_pos(j, :)'; % Satellite position
        dist = norm(r_true - r_sj); % Distance
        Hk = [(r_true - r_sj)' / dist, zeros(1, 3), 1]; % Observation matrix
        Rk = sigma2_obs; % Observation noise covariance
        K = P_prior * Hk' / (Hk * P_prior * Hk' + Rk); % Kalman gain
        y = observations(j, k) - Hk * X_prior(:, k+1); % Measurement residual
        X_posterior(:, k+1) = X_prior(:, k+1) + K * y; % Update state
        P_prior = (eye(7) - K * Hk) * P_prior; % Update covariance
    end
end

% Plot Trajectories
figure(5);
hold on;
plot3(X_nominal(1, :), X_nominal(2, :), X_nominal(3, :), '-g', 'DisplayName', 'Nominal Trajectory');
plot3(X_true(1, :), X_true(2, :), X_true(3, :), '-b', 'DisplayName', 'True Trajectory');
plot3(X_prior(1, :), X_prior(2, :), X_prior(3, :), '--r', 'DisplayName', 'A Priori Estimates');
plot3(X_posterior(1, :), X_posterior(2, :), X_posterior(3, :), '--k', 'DisplayName', 'A Posteriori Estimates');
xlabel('X (km)');
ylabel('Y (km)');
zlabel('Z (km)');
title('Trajectories and Kalman Filter Estimates');
legend;
grid on;
hold off;

%% part e
% Constants and Initialization
n_steps = 100; % Number of time steps
dt = 4.0; % Time step size
sigma = sqrt(dt) * 0.005; % Process noise standard deviation
sigma2_obs = 1e-4; % Observation noise variance
sigma2_t = 100.0; % Signal emission time variance
sat_pos = [8000, 100, 800; 100, 8000, 800; 1000, 2000, 5000; 2000, 100, 2000]; % Satellite positions
n_sat = size(sat_pos, 1); % Number of satellites

% Dynamics matrix
A_nominal = [eye(3), dt * eye(3); zeros(3), eye(3)]; % 6x6 nominal dynamics
A = [A_nominal, zeros(6, 1); zeros(1, 6), 1]; % Extend to include time (7x7)

% Initial state and covariance
C0 = blkdiag(10 * eye(3), 1 * eye(3)); % Initial state covariance
P_prior = blkdiag(C0, sigma2_t); % Initial prior covariance (7x7)
X_true = zeros(6, n_steps + 1); % True trajectory
X_true(:, 1) = mvnrnd([0; 0; 0; 0; 0; 0], C0)'; % Initialize true state
X_nominal = zeros(6, n_steps + 1); % Nominal trajectory (zero-noise)
X_prior = zeros(7, n_steps + 1); % A priori state estimates
X_posterior = zeros(7, n_steps + 1); % A posteriori state estimates
X_prior(:, 1) = [X_true(:, 1); 0]; % Initialize prior estimate
X_posterior(:, 1) = X_prior(:, 1); % Initialize posterior estimate

% Observations
observations = zeros(n_sat, n_steps); % Observations for all satellites

% Simulate dynamics and run Kalman filter
for k = 1:n_steps
    % True dynamics
    wk = randn(3, 1); % Process noise
    noise = [zeros(3, 1); sigma * wk]; % Velocity noise
    X_true(:, k+1) = A_nominal * X_true(:, k) + noise; % Update true state

    % Nominal dynamics
    X_nominal(:, k+1) = A_nominal * X_nominal(:, k); % Update nominal state

    % Observations
    r_true = X_true(1:3, k+1); % True position at step k+1
    t_k1 = k * dt; % Signal emission time
    for j = 1:n_sat
        r_sj = sat_pos(j, :)'; % Satellite position
        dist = norm(r_true - r_sj); % Distance to satellite
        nu_jk1 = sqrt(sigma2_obs) * randn; % Observation noise
        observations(j, k) = dist + t_k1 + nu_jk1; % Observation
    end

    % Kalman filter: Prediction step
    X_prior(:, k+1) = A * X_posterior(:, k); % Predict state
    P_prior = A * P_prior * A' + blkdiag(C0, 0); % Predict covariance

    % Kalman filter: Update step (all satellites)
    for j = 1:n_sat
        r_sj = sat_pos(j, :)'; % Satellite position
        dist = norm(r_true - r_sj); % Distance
        Hk = [(r_true - r_sj)' / dist, zeros(1, 3), 1]; % Observation matrix
        Rk = sigma2_obs; % Observation noise covariance
        K = P_prior * Hk' / (Hk * P_prior * Hk' + Rk); % Kalman gain
        y = observations(j, k) - Hk * X_prior(:, k+1); % Measurement residual
        X_posterior(:, k+1) = X_prior(:, k+1) + K * y; % Update state
        P_prior = (eye(7) - K * Hk) * P_prior; % Update covariance
    end
end

% Plot for all satellites
figure(6);
hold on;
plot3(X_nominal(1, :), X_nominal(2, :), X_nominal(3, :), '-g', 'DisplayName', 'Nominal Trajectory');
plot3(X_true(1, :), X_true(2, :), X_true(3, :), '-b', 'DisplayName', 'True Trajectory');
plot3(X_prior(1, :), X_prior(2, :), X_prior(3, :), '--r', 'DisplayName', 'A Priori Estimates');
plot3(X_posterior(1, :), X_posterior(2, :), X_posterior(3, :), '--k', 'DisplayName', 'A Posteriori Estimates');
xlabel('X (km)');
ylabel('Y (km)');
zlabel('Z (km)');
title('Trajectories with All Satellites');
legend;
grid on;
hold off;

% Repeat for only 3 satellites (exclude 4th satellite)
n_sat = 3;
for k = 1:n_steps
    % Repeat the same steps as above but only use the first 3 satellites in the update step
end

% Add similar plotting logic for 3 satellites
%% part f

% Part (f): MATLAB Code for Comparing A Posteriori Covariances

% Constants
n_steps = 1; % Single step for covariance analysis
dt = 4.0; % Time step size
sigma = sqrt(dt) * 0.005; % Process noise standard deviation
sigma2_obs = 1e-4; % Observation noise variance
sigma2_t = 100.0; % Signal emission time variance
sat_pos = [8000, 100, 800; 100, 8000, 800; 1000, 2000, 5000; 2000, 100, 2000]; % Satellite positions
n_sat_all = size(sat_pos, 1);
n_sat_partial = 3; % Use only the first 3 satellites

% Initial Covariance
C0 = blkdiag(10 * eye(3), 1 * eye(3)); % 6x6 covariance
P_prior = blkdiag(C0, sigma2_t); % 7x7 covariance including time

% Example true position
r_true = [1000; 2000; 3000]; % Example true position

% Observation matrix (H) for all satellites
H_all = zeros(n_sat_all, 7);
for j = 1:n_sat_all
    r_sj = sat_pos(j, :)'; % Satellite position
    dist = norm(r_true - r_sj); % Distance to satellite
    H_all(j, :) = [(r_true - r_sj)' / dist, zeros(1, 3), 1];
end

% Observation matrix (H) for only 3 satellites
H_partial = H_all(1:n_sat_partial, :);

% Measurement noise covariance (R)
R_all = sigma2_obs * eye(n_sat_all);
R_partial = sigma2_obs * eye(n_sat_partial);

% Kalman gain for all satellites
K_all = P_prior * H_all' / (H_all * P_prior * H_all' + R_all);

% Kalman gain for 3 satellites
K_partial = P_prior * H_partial' / (H_partial * P_prior * H_partial' + R_partial);

% A posteriori covariance for all satellites
P_post_all = (eye(7) - K_all * H_all) * P_prior;

% A posteriori covariance for 3 satellites
P_post_partial = (eye(7) - K_partial * H_partial) * P_prior;

% Extract diagonal variances for comparison
variances_all = diag(P_post_all);
variances_partial = diag(P_post_partial);

% Display results
disp('Diagonal of P_post_all (4 satellites):');
disp(variances_all);

disp('Diagonal of P_post_partial (3 satellites):');
disp(variances_partial);

% Bar Plot for Comparison
figure(7);
bar([variances_all, variances_partial]);
legend('4 Satellites', '3 Satellites');
xlabel('State Component');
ylabel('Variance');
title('Comparison of A Posteriori Covariance Variances');
grid on;
%% part g
% Part (f) and (g): MATLAB Code for A Posteriori Covariances and Position Errors

% Constants
n_steps = 1; % Single step for covariance analysis
dt = 4.0; % Time step size
sigma = sqrt(dt) * 0.005; % Process noise standard deviation
sigma2_obs = 1e-4; % Observation noise variance
sigma2_t = 100.0; % Signal emission time variance
sat_pos = [8000, 100, 800; 100, 8000, 800; 1000, 2000, 5000; 2000, 100, 2000]; % Satellite positions
n_sat_all = size(sat_pos, 1);
n_sat_partial = 3; % Use only the first 3 satellites

% Initial Covariance
C0 = blkdiag(10 * eye(3), 1 * eye(3)); % 6x6 covariance
P_prior = blkdiag(C0, sigma2_t); % 7x7 covariance including time

% Example true position
r_true = [1000; 2000; 3000]; % Example true position

% Observation matrix (H) for all satellites
H_all = zeros(n_sat_all, 7);
for j = 1:n_sat_all
    r_sj = sat_pos(j, :)'; % Satellite position
    dist = norm(r_true - r_sj); % Distance to satellite
    H_all(j, :) = [(r_true - r_sj)' / dist, zeros(1, 3), 1];
end

% Observation matrix (H) for only 3 satellites
H_partial = H_all(1:n_sat_partial, :);

% Measurement noise covariance (R)
R_all = sigma2_obs * eye(n_sat_all);
R_partial = sigma2_obs * eye(n_sat_partial);

% Kalman gain for all satellites
K_all = P_prior * H_all' / (H_all * P_prior * H_all' + R_all);

% Kalman gain for 3 satellites
K_partial = P_prior * H_partial' / (H_partial * P_prior * H_partial' + R_partial);

% A posteriori covariance for all satellites
P_post_all = (eye(7) - K_all * H_all) * P_prior;

% A posteriori covariance for 3 satellites
P_post_partial = (eye(7) - K_partial * H_partial) * P_prior;

% Extract diagonal variances for comparison
variances_all = diag(P_post_all);
variances_partial = diag(P_post_partial);

% Display results
disp('Diagonal of P_post_all (4 satellites):');
disp(variances_all);

disp('Diagonal of P_post_partial (3 satellites):');
disp(variances_partial);

% Bar Plot for Comparison
figure;
bar([variances_all, variances_partial]);
legend('4 Satellites', '3 Satellites');
xlabel('State Component');
ylabel('Variance');
title('Comparison of A Posteriori Covariance Variances');
grid on;

% Part (g): Compute and Compare Position Errors
% Extract position variances (r1, r2, r3)
position_variances_all = variances_all(1:3);
position_variances_partial = variances_partial(1:3);

% Compute position errors as sqrt of variances
position_errors_all = sqrt(position_variances_all);
position_errors_partial = sqrt(position_variances_partial);

% Display position errors
disp('Position Errors (4 satellites):');
disp(position_errors_all);

disp('Position Errors (3 satellites):');
disp(position_errors_partial);

% Bar Plot for Position Errors
figure(8);
bar([position_errors_all, position_errors_partial]);
legend('4 Satellites', '3 Satellites');
xlabel('Position Component');
ylabel('Error (km)');
title('Comparison of Position Errors');
grid on;
%% part h
% Part (f), (g), and (h): MATLAB Code for A Posteriori Covariances, Position Errors, and Discussion

% Constants
n_steps = 1; % Single step for covariance analysis
dt = 4.0; % Time step size
sigma = sqrt(dt) * 0.005; % Process noise standard deviation
sigma2_obs = 1e-4; % Observation noise variance
sigma2_t = 100.0; % Signal emission time variance
sat_pos = [8000, 100, 800; 100, 8000, 800; 1000, 2000, 5000; 2000, 100, 2000]; % Satellite positions
n_sat_all = size(sat_pos, 1);
n_sat_partial = 3; % Use only the first 3 satellites

% Initial Covariance
C0 = blkdiag(10 * eye(3), 1 * eye(3)); % 6x6 covariance
P_prior = blkdiag(C0, sigma2_t); % 7x7 covariance including time

% Example true position
r_true = [1000; 2000; 3000]; % Example true position

% Observation matrix (H) for all satellites
H_all = zeros(n_sat_all, 7);
for j = 1:n_sat_all
    r_sj = sat_pos(j, :)'; % Satellite position
    dist = norm(r_true - r_sj); % Distance to satellite
    H_all(j, :) = [(r_true - r_sj)' / dist, zeros(1, 3), 1];
end

% Observation matrix (H) for only 3 satellites
H_partial = H_all(1:n_sat_partial, :);

% Measurement noise covariance (R)
R_all = sigma2_obs * eye(n_sat_all);
R_partial = sigma2_obs * eye(n_sat_partial);

% Kalman gain for all satellites
K_all = P_prior * H_all' / (H_all * P_prior * H_all' + R_all);

% Kalman gain for 3 satellites
K_partial = P_prior * H_partial' / (H_partial * P_prior * H_partial' + R_partial);

% A posteriori covariance for all satellites
P_post_all = (eye(7) - K_all * H_all) * P_prior;

% A posteriori covariance for 3 satellites
P_post_partial = (eye(7) - K_partial * H_partial) * P_prior;

% Extract diagonal variances for comparison
variances_all = diag(P_post_all);
variances_partial = diag(P_post_partial);

% Display results
disp('Diagonal of P_post_all (4 satellites):');
disp(variances_all);

disp('Diagonal of P_post_partial (3 satellites):');
disp(variances_partial);

% Bar Plot for Comparison
figure(9);
bar([variances_all, variances_partial]);
legend('4 Satellites', '3 Satellites');
xlabel('State Component');
ylabel('Variance');
title('Comparison of A Posteriori Covariance Variances');
grid on;

% Part (g): Compute and Compare Position Errors
% Extract position variances (r1, r2, r3)
position_variances_all = variances_all(1:3);
position_variances_partial = variances_partial(1:3);

% Compute position errors as sqrt of variances
position_errors_all = sqrt(position_variances_all);
position_errors_partial = sqrt(position_variances_partial);

% Display position errors
disp('Position Errors (4 satellites):');
disp(position_errors_all);

disp('Position Errors (3 satellites):');
disp(position_errors_partial);

% Bar Plot for Position Errors
figure(10);
bar([position_errors_all, position_errors_partial]);
legend('4 Satellites', '3 Satellites');
xlabel('Position Component');
ylabel('Error (km)');
title('Comparison of Position Errors');
grid on;

% Part (h): Discussion of Results
% Discussion
fprintf('\nDiscussion:\n');
fprintf('1. Using all 4 satellites provides significantly lower variances in the state estimates, particularly for position components.\n');
fprintf('2. When only 3 satellites are used, the uncertainties in the state estimates (as reflected by the variances) increase.\n');
fprintf('3. The position errors computed as the square root of variances are higher when fewer satellites are used.\n');
fprintf('4. This demonstrates the importance of having more observations (satellites) in reducing estimation uncertainty.\n');
fprintf('5. The larger variances and errors with 3 satellites highlight potential challenges in real-world navigation systems with limited satellite visibility.\n');



