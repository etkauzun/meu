function [approx, error, log_err, log_n] = q6_LE_appr(a,b,n)
% q6_trap_appr computes the LE approximation for a given function
%
% Call format: [approx,error,log_err,log_n] = q6_LE_appr(a,b,n)
%
% input variables:
% a - interval end-point
% b - interval end-point
% n - number of steps
%
% output variables:
% approx - LE approximation value
% error - error value
% log_err - log10 of error value
% log_n - log10 of n

h = (b-a) / n; % calculating step-size
approx = 0; % initiating the approximation value

for i = 0:n-1 
    x = a + h*i; % finding the input value of the approximation
    approx = approx + (h * q6_func(x)); % finding the approximation for that step
end % for loop on line  20

actual_val = q6_CT_true; % calculating the actual integral
error = actual_val - approx; % error value
log_err = log10(error); % log10 of error value
log_n = log10(n); % log10 of number of steps

end % function on line 1