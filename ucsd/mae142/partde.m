% Full Code for Parts (d) and (e)
close all; clear; clc;

% Kalman Filter-based Navigator for Air Vehicle

% Parameters
sigma_hat = 0.005;       % Noise level
Delta_t = 4.0;           % Time step
sigma = sqrt(Delta_t) * sigma_hat;
num_steps = 100;         % Number of steps in simulation
sat_positions = [
    8000,  100,  800;
     100, 8000,  800;
    1000, 2000, 5000;
    2000,  100, 2000];   % Satellite positions (4 x 3)

% Initial state and covariance
x0 = [0; 0; 0; 0; 0; 0; 0]; % Including time of emission
P0 = diag([10, 10, 10, 1, 1, 1, 0.0001]);

% Observation noise covariance
R = 1e-4 * eye(4); % Variance of observations

% System matrices
A = [eye(6), zeros(6, 1); zeros(1, 6), 1];
Q = blkdiag(sigma^2 * eye(3), sigma^2 * eye(3), 0); % Process noise covariance

% Preallocate storage for trajectories
x_true = zeros(7, num_steps + 1);
x_true(:, 1) = x0;
x_prior = zeros(7, num_steps + 1);
x_posterior = zeros(7, num_steps + 1);
x_prior(:, 1) = x0;
x_posterior(:, 1) = x0;
P_prior = zeros(7, 7, num_steps + 1);
P_posterior = zeros(7, 7, num_steps + 1);
P_prior(:, :, 1) = P0;
P_posterior(:, :, 1) = P0;

% Generate true trajectory
for k = 1:num_steps
    w_k = [randn(3, 1); randn(3, 1)];
    x_true(:, k + 1) = A * x_true(:, k) + [zeros(6, 1); Delta_t] + [sigma * w_k; 0];
end

% Kalman filter loop
for k = 1:num_steps
    % Observation model
    r_k = x_true(1:3, k + 1); % True position
    y_k = zeros(4, 1);
    H_k = zeros(4, 7);
    for j = 1:4
        H_k(j, 1:3) = (r_k' - sat_positions(j, :)) / norm(r_k - sat_positions(j, :));
        H_k(j, 7) = 1;
        y_k(j) = norm(r_k - sat_positions(j, :)') + Delta_t * k + sqrt(R(j, j)) * randn;
    end

    % Prediction step
    x_prior(:, k + 1) = A * x_posterior(:, k);
    P_prior(:, :, k + 1) = A * P_posterior(:, :, k) * A' + Q;

    % Update step
    S_k = H_k * P_prior(:, :, k + 1) * H_k' + R;
    K_k = P_prior(:, :, k + 1) * H_k' / S_k; % Kalman gain
    x_posterior(:, k + 1) = x_prior(:, k + 1) + K_k * (y_k - H_k * x_prior(:, k + 1));
    P_posterior(:, :, k + 1) = (eye(7) - K_k * H_k) * P_prior(:, :, k + 1);
end

% Plotting
figure;
hold on;

% Nominal trajectory (zero-noise)
plot3(x_true(1, :), x_true(2, :), x_true(3, :), 'k-', 'LineWidth', 1.5);

% Discrete-time trajectory with noise
plot3(x_prior(1, :), x_prior(2, :), x_prior(3, :), 'b--', 'LineWidth', 1.5);

% A priori state estimates
plot3(x_prior(1, :), x_prior(2, :), x_prior(3, :), 'ro');

% A posteriori state estimates
plot3(x_posterior(1, :), x_posterior(2, :), x_posterior(3, :), 'gx');

xlabel('X Position (km)');
ylabel('Y Position (km)');
zlabel('Z Position (km)');
legend('Nominal Trajectory', 'Discrete-Time Model', 'A Priori Estimate', 'A Posteriori Estimate');
title('Kalman Filter-Based Navigator');
grid on;
hold off;
