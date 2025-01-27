clear all; clc;

f = @(x) atan(x+((2*x^3)/3)) - 0.7;
df = @(x) (2*x^2 + 1) / ( ((2*x^3 / 3) + x)^2  + 1);
xbar = 0;
x_arr = [0];
f_arr = [f(x_arr(1))];
e_arr = [f(x_arr(1))-xbar];

for n = 0:100
    x = x_arr(n+1) - f_arr(n+1)/df(f_arr(n+1));
    x_arr = [x_arr, x];
    f_arr = [f_arr, f(x)];
    e_arr = [e_arr, f(x)-xbar];
    if abs(f(x) - xbar) < 10e-12
        break
    end % if

end % for

x_arr
e_arr

fhat = @(x) x + (2*x^3 /3) - tan(0.7);
dfhat = @(x) 2*x^2 + 1;
xhatbar = 0;
xh_arr = [0];
fh_arr = [f(xh_arr(1))];
eh_arr = [f(xh_arr(1))-xhatbar];

for n = 0:100
    x = xh_arr(n+1) - fh_arr(n+1)/dfhat(fh_arr(n+1));
    xh_arr = [xh_arr, x];
    fh_arr = [fh_arr, f(x)];
    eh_arr = [eh_arr, fhat(x)-xhatbar];
    if abs(fhat(x) - xhatbar) < 10e-12
        break
    end % if

end % for

xh_arr
eh_arr
