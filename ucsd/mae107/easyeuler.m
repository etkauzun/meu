function [tv,xv]=easyeuler(t0,x0,tend,n)
%
% Objective: Euler's method for solution of ODE \dot x=f(t,x) over time
% interval [t0,tend] with initial data x(t0)=x0.
%
% input variables:
%   t0 - initial time
%   x0 - initial state
%   tend - terminal time
%   n - number of steps in Euler iteration.
%
% output variables:
%   tv - vector of times at which the solution is evaluated (including t0
%   and tend).
%   xv - vector of the state value, x(t), at the times in tv.
%
% functions called:
%    odefunc - evaluates f(t,x).
%
%
% Create vectors that will be filled with the solution data.
%
np1=n+1;
tv=zeros(1,np1);
xv=zeros(1,np1);
%
% Initialize time and state.
%
t=t0;
x=x0;
%
% Put initial time and state into the output time and state vectors.
%
tv(1)=t;
xv(1)=x;
%
% Compute the stpe-size, h.
%
h=(tend-t0)/n;
%
% Begin Euler iteration.
%
for i=2:np1
    %
    % Coupute f(t,x)
    %
    f=odefunc(t,x);
    %
    % Update time and state.
    %
    t=t+h;
    x=x+h*f;
    %
    % Load new time and state into the output vectors.
    %
    tv(i)=t;
    xv(i)=x;
end;