function f=odefunc(t,x);
%
% Objective: Computes the function, f(t,x), which is used in an ODE solver
% for ODE \dot x=f(t,x).
%
% input variables:
%   t - time
%   x - state
%
% output variables:
%   f - f(t,x)
%
% functions called:
%   none
%
%
f=sin(t+x)+exp(1-sqrt(1+x^2));
