clear all; clc; 

%% MAE 107 HW5 Q8

% Running the fixed point

f = @(x) atan(2*x + 0.5) / 4;
% xbar  = -0.25;
x0_arr = [0];

for n = 0:100
    x = f(x0_arr(n+1));
    x0_arr = [x0_arr, x];
    if n ~=0 && abs(x0_arr(n+1)-x0_arr(n)) < 10e-5
        break
    end % if
end % for


x2_arr = [2];

for n = 0:100
    x = f(x2_arr(n+1));
    x2_arr = [x2_arr, x];
    if n ~=0 && abs(x2_arr(n+1)-x2_arr(n)) < 10e-5
        break
    end % if
end % for


x1000_arr = [1000];

for n = 0:100
    x = f(x1000_arr(n+1));
    x1000_arr = [x1000_arr, x];
    if n ~=0 && abs(x1000_arr(n+1)-x1000_arr(n)) < 10e-5
        break
    end % if
end % for

x1000_arr

g = @(y) (tan(4*y) / 2)  - 0.25;
y0_arr = [0];

for n = 0:100
    y = g(y0_arr(n+1));
    y0_arr = [y0_arr, x];
    if n ~=0 && abs(y0_arr(n+1)-y0_arr(n)) < 10e-5
        break
    end % if
end % for

y0_arr

y2_arr = [2];

for n = 0:100
    y = g(y2_arr(n+1));
    y2_arr = [y2_arr, x];
    if n ~=0 && abs(y2_arr(n+1)-y2_arr(n)) < 10e-5
        break
    end % if
end % for

y2_arr

y1000_arr = [1000];

for n = 0:100
    y = g(y1000_arr(n+1));
    y1000_arr = [y1000_arr, x];
    if n ~=0 && abs(y1000_arr(n+1)-y1000_arr(n)) < 10e-5
        break
    end % if
end % for

y1000_arr