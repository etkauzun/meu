function [approx, error, log_err, log_n] = trap_appr(a,b,n,str_func)
% trap_appr computes the trapezoid approximation for a given function
%
% Call format: [approx,error,log_err,log_n] = trap_appr(a,b,n,str_func)
%
% input variables:
% a - interval end-point
% b - interval end-point
% n - number of steps
% str_func - function in string form. ex: str = '@(x) exp(x)
%
% output variables:
% approx - trap approximation value
% error - error value
% log_err - log10 of error value
% log_n - log10 of n

h = (b-a) / n; % calculating step-size
f = str2func(str_func); % converting string to function 
approx = h * ( (f(a)+f(b)) / 2); % initiating the approximation value

for i = 1:n-1 
    x = a + h*i; % finding the input value of the approximation
    approx = approx + (h * f(x)); % finding the approximation for that step
end % for loop on line  20

actual_val = integral(f,a,b); % calculating the actual integral
error = actual_val - approx; % error value
log_err = log10(error); % log10 of error value
log_n = log10(n); % log10 of number of steps

end % function on line 1