function EU_P3(n,T_val, str_func, y0)
% EU_P2 approximates a solution to given data using RK4 & fixed point
%
% Call format: EU_P2(n,T_val, str_func, y0)
%
% input variables:
% n: array of n steps (ex ~ [8, 16, 32, 64, 128, 256, 512])
% T_val: value of T (ex ~ 6)
% str_func: function in string format 
% Example: str_func = '@(t,y,z) exp(-1-sin(z)) - ( (sin(t+y))^2 * (1+z^2)^(1/3))';
% y0: initial condition of y (ex ~ 4)

%% Initializing variables
global g

g = str2func(str_func); % function g(t,y)
n_arr =  n; % initializing array of n step values
b2 = 1/3; b1 = 1 - b2; % beta values (beta1 + beta2 = 1)
T = T_val; % T value
alpha = 1/(2*b2); ni = alpha; % alpha & ni values (b2*alpha=1/2; b2*ni=1/2)

%% Pre-allocating arrays of y values, z values, and solutions
y_arr = y0; % y values
z_arr = 0; % z values
rk4_solns = []; % solutions obtained by RK4
all_t = zeros(length(n_arr),n_arr(length(n_arr))+1);
all_y = zeros(length(n_arr),n_arr(length(n_arr))+1); % yk values
all_y(:,1) = y0; % updating the first column with initial condition

%% Running RK4

for j = 1:length(n_arr)
    for k = 1:n_arr(j)
        h = T/n_arr(j); % step size
        t = h*k; % t is: tk = k*h (t0, t1, ...)
        all_t(j,k+1) = t; % allocating tk values

        % RK4 
        z = final_FP(0,all_t(j,k),y_arr(k)); % calling function to evaluate z
        z_arr = [z_arr, z];
        k1 = h*final_FP(z_arr(k+1),all_t(j,k),y_arr(k));
        k2 = h*final_FP(z_arr(k+1),(all_t(j,k)+(h/2)),(y_arr(k)+(k1/2)));
        k3 = h*final_FP(z_arr(k+1), (all_t(j,k)+(h/2)),(y_arr(k)+(k2/2)));
        k4 = h*final_FP(z_arr(k+1), (h*(k)),(y_arr(k)+k3));
        y_val = y_arr(k) + ((1/6) * (k1 + (2*(k2+k3)) + k4));
        y_arr = [y_arr, y_val];
        all_y(j,k+1) = y_val;
    end
    rk4_solns = [rk4_solns, y_arr(length(y_arr))];
    y_arr = y0;
end
%% Plotting the graph: All solutions vs tk Values
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
figure(1)
hold on;
colororder(colors);
for i = 1:length(n_arr)  
    for j = 1:n_arr(i) + 1
        if j == n_arr(i) + 1
            plot(all_t(i,1:j), all_y(i,1:j), "LineWidth",2);
        end % if
    end % for
end % for

xlabel('tk values'); ylabel('RK4 solution values'); 
title('Graph of RK4 Solutions vs t Values'); 
legend('n=8', 'n=16','n=32','n=64','n=128','n=256','n=512');
hold off;

soln = rk4_solns(length(rk4_solns))
end % function


