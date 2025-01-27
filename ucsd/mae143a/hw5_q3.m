clear all; clc; close all;
%% a
% Parameters
omega = pi;
delta_t = 0.001; % Smooth line
h = 0.1; % Sample period
t = 0:delta_t:5; % Continuous time interval
t_k = 0:h:5; % Sample times

% Continuous sine wave
y = sin(omega * t);

% Sampled points
y_k = sin(omega * t_k);

% Zero-order hold (ZOH) approximation
y_zoh = zeros(size(t));
for i = 1:length(t_k)
    idx = find(t >= t_k(i), 1); % Find the index where t_k(i) starts
    y_zoh(idx:end) = y_k(i); % Maintain constant value until next sample
end

% Plotting
figure(1);
plot(t, y, 'b', 'LineWidth', 2); % Continuous sine wave
hold on;
stairs(t, y_zoh, 'g', 'LineWidth', 1.5); % Zero-order hold
hold off;
title('Continuous Sine Wave, Sampled Points, and ZOH');
xlabel('Time');
ylabel('Amplitude');
legend('Continuous Sine Wave', 'Sampled Points', 'Zero-Order Hold (ZOH)', 'Location', 'best');
grid on;
%% b
% First-order hold (FOH) approximation
y_foh = zeros(size(t));
for i = 1:length(t_k)-1
    idx = find(t >= t_k(i), 1); % Find the index where t_k(i) starts
    next_idx = find(t < t_k(i+1), 1, 'last'); % Find the index where t_k(i+1) ends
    y_foh(idx:next_idx) = y_k(i) + (t(idx:next_idx) - t_k(i)) * (y_k(i+1) - y_k(i)) / h; % Linear interpolation
end
foh_t = t_k

% Plotting
figure(2);
plot(t, y, 'b', 'LineWidth', 2); % Continuous sine wave
hold on;
% stem(t_k, y_k, 'r', 'LineWidth', 1.5, 'Marker', 'x', 'MarkerSize', 8); % Sampled points
plot(t, y_foh, 'g', 'LineWidth', 1.5); % First-order hold (FOH)
plot(t_k, y_foh, 'm','LineWidth', 1.5);
hold off;
title('Continuous Sine Wave, Sampled Points, and FOH');
xlabel('Time');
ylabel('Amplitude');
legend('Continuous Sine Wave', 'Sampled Points', 'First-Order Hold (FOH)', 'Location', 'best');
grid on;
%% c
% Second-order hold (SOH) approximation
y_soh = zeros(size(t));
for i = 3:length(t_k) % Start from i = 3 since we need three consecutive samples for interpolation
    idx = find(t >= t_k(i-2), 1); % Find the index where t_k(i-2) starts
    next_idx = find(t < t_k(i), 1, 'last'); % Find the index where t_k(i) ends
    
    % Lagrange interpolation
    x = [t_k(i-2), t_k(i-1), t_k(i)];
    y_interp = [y_k(i-2), y_k(i-1), y_k(i)];
    p = lagrange_interp(x, y_interp);
    
    % Evaluate the polynomial within the interval [t_k(i-1), t_k(i)]
    t_interval = t(idx:next_idx);
    y_soh(idx:next_idx) = polyval(p, t_interval);
end

% Plotting
figure(3);
plot(t, y, 'b', 'LineWidth', 2); % Continuous sine wave
hold on;
% stem(t_k, y_k, 'r', 'LineWidth', 1.5, 'Marker', 'x', 'MarkerSize', 8); % Sampled points
plot(t, y_soh, 'g', 'LineWidth', 1.5); % Second-order hold (SOH)
hold off;
title('Continuous Sine Wave, Sampled Points, and SOH');
xlabel('Time');
ylabel('Amplitude');
legend('Continuous Sine Wave', 'Sampled Points', 'Second-Order Hold (SOH)', 'Location', 'best');
grid on;

function p = lagrange_interp(x, y)
n = length(x);
p = polyfit(x, y, n-1);
end
