function EU_P1(n,beta2,T_val, str_func, y0)
% EU_P1 approximates a solution to given data using Euler's Method, RK2,
% RK4
% Call format: final_q1(n,beta2,T_val, str_func, y0)
%
% input variables:
% n: array of n steps (ex ~ [4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096])
% beta2: beta2 value (ex ~ 1/2)
% T_val: value of T (ex ~ 2)
% str_func: function in string format (ex ~ str_func = '@(t,y) (exp(-1*y)) * sin(t+(2*pi*y))';)
% y0: initial condition of y (ex ~ 1)

%% Initializing variables
f = str2func(str_func); % function f(t,y)
n_arr =  n; % initializing array of n step values
b2 = beta2; b1 = 1 - b2; % beta values (beta1 + beta2 = 1)
T = T_val; % T value
alpha = 1/(2*b2); ni = alpha; % alpha & ni values (b2*alpha=1/2; b2*ni=1/2)

%% Pre-allocating arrays of y values, solutions, function evalutions 
% & matrices of yk values for each method
euler_y_arr = y0; euler_solns = []; err_euler = []; FE_euler = n_arr;
rk2_y_arr =  y0; rk2_solns = []; err_RK2 = []; FE_RK2 = [];
rk4_y_arr = y0; rk4_solns = []; err_RK4 = []; FE_RK4 = [];
log_n = []; 
all_euler_y = zeros(length(n_arr),n_arr(length(n_arr))+1);
all_euler_y(:,1) = y0; 
all_t = zeros(length(n_arr),n_arr(length(n_arr))+1);
all_rk2_y = zeros(length(n_arr),n_arr(length(n_arr))+1);
all_rk2_y(:,1) = y0; 
all_rk4_y = zeros(length(n_arr),n_arr(length(n_arr))+1);
all_rk4_y(:,1) = y0;

%% Finding the true solution
y_soln_arr = y0;

for k = 0:8191
    h = T/8192; % step size
    t = h*k; % t is: tk = k*h (t0, t1, ...)
    
    % RK4
    k1 = h*f(t, y_soln_arr(k+1)); 
    k2 = h*f((t+(h/2)),(y_soln_arr(k+1)+(k1/2)));
    k3 = h*f((t+(h/2)),(y_soln_arr(k+1)+(k2/2)));
    k4 = h*f((h*(k+1)),(y_soln_arr(k+1)+k3));
    y_val = y_soln_arr(k+1) + ((1/6) * (k1 + (2*(k2+k3)) + k4));
    y_soln_arr = [y_soln_arr, y_val];

end % for loop on line 29

true_soln = y_soln_arr(length(y_soln_arr));

%% Finding the solns by each method
for j = 1:length(n_arr)
    for k = 1:n_arr(j)
        h = T/n_arr(j); % step size
        t = h*k; % t is: tk = k*h (t0, t1, ...)
        all_t(j,k+1) = t; % allocating tk values

        % Euler's Method
        y_val = euler_y_arr(k) + (h*f(all_t(j,k),euler_y_arr(k))); 
        euler_y_arr = [euler_y_arr, y_val]; 
        all_euler_y(j,k+1) = y_val;
        

        % RK2 
        k1 = h*f(all_t(j,k), rk2_y_arr(k));
        k2 = h*f((all_t(j,k)+(h*ni)),(rk2_y_arr(k)+(alpha*k1)));
        y_val = rk2_y_arr(k) + (b1*k1) + (b2*k2);
        rk2_y_arr = [rk2_y_arr, y_val];
        all_rk2_y(j,k+1) = y_val;

        % RK4
        k1 = h*f(all_t(j,k), rk4_y_arr(k)); 
        k2 = h*f((all_t(j,k)+(h/2)),(rk4_y_arr(k)+(k1/2)));
        k3 = h*f((all_t(j,k)+(h/2)),(rk4_y_arr(k)+(k2/2)));
        k4 = h*f((h+all_t(j,k)),(rk4_y_arr(k)+k3));
        y_val = rk4_y_arr(k) + ((1/6) * (k1 + (2*(k2+k3)) + k4));
        rk4_y_arr = [rk4_y_arr, y_val];
        all_rk4_y(j,k+1) = y_val;
    end % for loop on line 48

    % Allocating soln & number of function evalution values for each n step 
    % & emptying the arrays for the next iteration of n 
    euler_solns = [euler_solns, euler_y_arr(length(euler_y_arr))];
    err_euler = [err_euler, abs(euler_solns(j)-true_soln)];
    euler_y_arr =  y0; 
    rk2_solns = [rk2_solns, rk2_y_arr(length(rk2_y_arr))];
    err_RK2 = [err_RK2, abs(rk2_solns(j)-true_soln)];
    rk2_y_arr = y0; FE_RK2 = [FE_RK2, (2*n_arr(j))];
    rk4_solns = [rk4_solns, rk4_y_arr(length(rk4_y_arr))];
    err_RK4 = [err_RK4, abs(rk4_solns(j)-true_soln)];
    rk4_y_arr = y0; FE_RK4 = [FE_RK4, (4*n_arr(j))];
    log_n = [log_n, log(n_arr(j))];
end % for loop on line 47

%% Plotting the first three graphs: solutions of each method

% Assigning color values
colors =   [0.0320    0.4470    0.7410
            0.8500    0.3250    0.0980
            0.9290    0.6940    0.1250
            0.4940    0.1840    0.5560
            0.4660    0.6740    0.1880
            0.3010    0.7450    0.9330
            0.6350    0.0780    0.1840
            0.8334    0.1412    0.2345
            1.0000    0.5432    0.0982
            0.4723    0.2985    0.8056
            0.3241    0.8120    0.5234]; 

colororder(colors)

% Plotting the first graph: Euler solutions
figure(1)
hold on;
for i = 1:length(n_arr)
    for j = 1:n_arr(i)+1
        if j == n_arr(i)+1
            plot(all_t(i,1:j), all_euler_y(i,1:j), "LineWidth",2);
        end % if
    end % for
end % for
xlabel('tk values'); ylabel('Euler method solution values'); 
title('Graph of Euler Solutions vs t Values'); 
legend('n=4', 'n=8', 'n=16','n=32','n=64','n=128','n=256','n=512','n=1024','n=2048','n=4096');
hold off

% Plotting the second graph: RK2 solutions

figure(2); hold on; colororder(colors);
for i = 1:length(n_arr)
    for j = 1:n_arr(i)+1
        if j == n_arr(i)+1
            plot(all_t(i,1:j), all_rk2_y(i,1:j), "LineWidth",2);
        end % if
    end % for
end % for
xlabel('tk values'); ylabel('RK2 solution values'); 
title('Graph of RK2 Solutions vs t Values'); 
legend('n=4', 'n=8', 'n=16','n=32','n=64','n=128','n=256','n=512','n=1024','n=2048','n=4096');
hold off

% Plotting the third graph: RK4 solutions

figure(3); hold on; colororder(colors);
for i = 1:length(n_arr)
    for j = 1:n_arr(i)+1
        if j == n_arr(i)+1
            plot(all_t(i,1:j), all_rk4_y(i,1:j), "LineWidth",2);
        end % if
    end % for
end % for
xlabel('tk values'); ylabel('RK4 solution values'); 
title('Graph of RK4 Solutions vs t Values'); 
legend('n=4', 'n=8', 'n=16','n=32','n=64','n=128','n=256','n=512','n=1024','n=2048','n=4096');
hold off;

%% Assigning new values for a different RK2
b2 = 1/4; b1 = 1 - b2; % new beta values
alpha = (1/2) * (1/b2); ni = alpha; % alpha and ni values
rk2_solns_2 = [];
err_rk2_1 = [];

% Running RK2 with new beta values
for j = 1:length(n_arr)
    for k = 0:n_arr(j) - 1
        h = T/n_arr(j); % step size
        t = h*k; % t is: tk = k*h (t0, t1, ...)

        % RK2 
        k1 = h*f(t, rk2_y_arr(k+1));
        k2 = h*f((t+(h*ni)),(rk2_y_arr(k+1)+(alpha*k1)));
        y_val = rk2_y_arr(k+1) + (b1*k1) + (b2*k2);
        rk2_y_arr = [rk2_y_arr, y_val];
    end % for loop on line 109

    % Allocating soln values for each n step & emptying the arrays for the 
    % next iteration of n 
    rk2_solns_2 = [rk2_solns_2, rk2_y_arr(length(rk2_y_arr))];
    err_rk2_1 = [err_rk2_1, abs(rk2_solns_2(j)-true_soln)];
    rk2_y_arr = y0;
end % for loop on line 108

%% Plotting the fourth graph: log of errors vs log of n
figure(4)
hold on; 
plot(log_n, log(err_euler), "LineWidth",2, "Color","Red");
plot(log_n, log(err_RK2), "LineWidth",2, "Color","Blue");
plot(log_n, log(err_RK4), "LineWidth",2, "Color","Green");
plot(log_n, log(err_rk2_1), "LineWidth",2, "Color","Cyan");
xlabel('log of n step values'); ylabel('log error values for each method'); 
title('Graph of log(error) vs log(n)'); 
legend('log(Euler)', 'log(RK2)', 'log(RK4)', 'log(RK2.2)');
hold off;

%% Plotting the fifth graph: log of errors vs log of FEs
figure(5)
hold on; 
plot(log(FE_euler), log(err_euler), "LineWidth",2, "Color","Red");
plot(log(FE_RK2), log(err_RK2), "LineWidth",2, "Color","Blue");
plot(log(FE_RK4), log(err_RK4), "LineWidth",2, "Color","Green");
plot(log(FE_RK2), log(err_rk2_1), "LineWidth",2, "Color","Cyan");
xlabel('log of funtion evaluation values'); 
ylabel('log error values for each method'); 
title('Graph of log(FE) vs log(n)'); 
legend('log(Euler)', 'log(RK2)', 'log(RK4)', 'log(RK2.2)');
hold off;
end % function on line 1

