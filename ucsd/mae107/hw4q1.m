clc; 
clear; 

h = 0.4;
x0 = 1;
x_arr = [];
f_arr = [];
e_arr = [];
f_func = @(x) exp(-1*x);
x_original = log(2+exp(1));
t_func = @(n) h*n;
x_func_orig = @(t) log(t+exp(1));

for n = 0:5
    t = t_func(n);
    if n == 0
        x = x0;
        x_arr = [x_arr, x];
        f = f_func(x);
        f_arr = [f_arr, f];
        e_arr = [e_arr, abs(x-x_func_orig(t))];
    else
        x = x_arr(n) + (h*f_arr(n));
        f = f_func(x);
        x_arr = [x_arr, x];
        f_arr = [f_arr, f];
        e_arr = [e_arr, abs(x-x_func_orig(t))];
    end % if on line 14
end  % for on line 12

h = 0.2;
t_func = @(n) h*n;
x_arr_2 = [];
f_arr_2 = [];
e_arr_2 = [];

for n = 0:10
    t = t_func(n);
    if n == 0
        x = x0;
        x_arr_2 = [x_arr_2, x];
        f = f_func(x);
        f_arr_2 = [f_arr_2, f];
        e_arr_2 = [e_arr_2, abs(x-x_func_orig(t))];
    else
        x = x_arr_2(n) + (h*f_arr_2(n));
        f = f_func(x);
        x_arr_2 = [x_arr_2, x];
        f_arr_2 = [f_arr_2, f];
        e_arr_2 = [e_arr_2, abs(x-x_func_orig(t))];
    end % if on line 37
end  % for on line 35

figure(1); hold on; plot([log10(5),log10(10)], [e_arr(6),e_arr_2(11)],"LineWidth",2, "Color","Red"); 
xlabel('log10 of n values'); ylabel('log10 of error values');
title('n=10');
hold off;