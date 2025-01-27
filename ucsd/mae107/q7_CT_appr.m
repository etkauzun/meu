function [approx, error, log_err, log_n] = q7_CT_appr(a,b,n)
% q7_CT_appr computes the corrected trapezoid approximation for a given function
%
% Call format: [approx,error,log_err,log_n] = q7_CT_appr(a,b,n)
%
% input variables:
% a - interval end-point
% b - interval end-point
% n - number of steps
%
% output variables:
% approx - CT approximation value
% error - error value
% log_err - log10 of error value
% log_n - log10 of n

h = (b-a) / n; % calculating step-size
approx = h * ( (q7_func(a)+q7_func(b)) / 2); % initiating the approximation value
approx = approx + h * ( (-1/24) * ( 3*q7_func(a) - 4*q7_func(a+h) + q7_func(a+(2*h)) ...
    + q7_func(b-(2*h)) - 4*q7_func(b-h) + 3*q7_func(b)) ); % calculating the correction in approximation

for i = 1:n-1 % for loop for the summation
    x = a + h*i; % finding the input value of the approximation
    approx = approx + (h * q7_func(x)); % finding the approximation for that step
end % for loop on line  22

int = @(x) abs(x-sqrt(2)); % creating a variable for the function to run the abs val
actual_val = integral(int,a,b); % calculating the actual integral
error = actual_val - approx; % error value
log_err = log10(error); % log10 of error value
log_n = log10(n); % log10 of number of steps

end % function on line 1