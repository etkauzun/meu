function [log_eh,log_ehat,log_edash] = mae107_hw3_2(x0)
% mae107_hw3_2 computes the derivative at x0=1 using difference
% approximations for the function f = exp(-2*x) * cos(pi*x) for h = 10^j, j in [0,10];
%   
% input variable:
%   x0 - x values
% 
% output variables:
%   log_eh - log10 values of eh
%   log_ehat - log10 values of ehat
%   log_edash - log10 values of edash
%
% Call format: [log_eh,log_ehat,log_edash] = mae107_hw3_2(x0)

Dh = []; % creating an empty array to store Dh values
eh = []; % creating an empty array to store eh values
Dhat = []; % creating an empty array to store Dhat values
ehat = []; % creating an empty array to store ehat values
Ddash = []; % creating an empty array to store Ddash values
edash = []; % creating an empty array to store edash values
h_arr = []; % creating an empty array to store log10 of h values

% x0 = 1; 
fprime_x0 = - 2*exp(-2*x0)*cos(pi*x0) - pi*exp(-2*x0)*sin(pi*x0); % calculating derivative of f at x0
fx0 = exp(-2*x0) * cos(pi*x0); % computing f at x0

for j = 0:10 % running a loop for j in h
    h = 10^(-j);
    h_arr = [h_arr, log10(h)]; % storing log10 for h values in an array

    % Dh = f(x0 +h) - f(x0) / h
    x = x0 + h; % setting function f input x
    Dh = [Dh, ((exp(-2*x) * cos(pi*x) - fx0) / h)]; % storing Dh value for h
    eh = [eh, abs((Dh(j+1)-fprime_x0))]; % storing eh value; eh = |Dh - fprime|
    x = 0; % changing x to 0 for the next iteration of the loop 
    
    % Dhat = f(x0 +h) - f(x0-h) / 2h
    n = x0 + h; % setting function f input n
    m = x0 - h; % setting function f input m
    fn = exp(-2*n) * cos(pi*n); % computing f(x0 +h)
    fm = exp(-2*m) * cos(pi*m); % computing f(x0-h)
    Dhat = [Dhat, ( (fn-fm) / (2*h) )]; % storing Dhat value for h
    ehat = [ehat, abs((Dhat(j+1)-fprime_x0))]; % storing ehat value; eh = |Dhat - fprime|
    n = 0; m = 0; % changing n & m to 0 for the next iteration of the loop 

    % Ddash
    a = 1 + (2*h); % setting function f input a
    b = 1 - (2*h); % setting function f input b
    fa = exp(-2*a) * cos(pi*a); % computing f(x0 + 2h)
    fb = exp(-2*b) * cos(pi*b); % computing f(x0 - 2h)
    Ddash = [Ddash, ( ( (8*(fn-fm)) - (fa-fb) ) / (12*h))]; % storing Ddash value for h
    edash = [edash, ( abs(Ddash(j+1)-fprime_x0)) ]; % storing ehat value; eh = |Ddash - fprime|
    a = 0; b = 0; % changing a & b to 0 for the next iteration of the loop 

end % for on line 21

% Dh
% Dhat
% Ddash
% eh
% ehat
% edash
% h_arr

log_eh = [log10(eh)]; % storing log10 values of eh
log_ehat = [log10(ehat)]; % storing log10 values of ehat
log_edash = [log10(edash)]; % storing log10 values of edash

figure(1); hold on;
plot(h_arr, log_eh, '-b',"LineWidth",2); % plotting log10 values of eh
plot(h_arr, log_ehat,'-r',"LineWidth",2); % plotting log10 values of ehat
plot(h_arr, log_edash,'-g',"LineWidth",2); % plotting log10 values of edash
legend('log10(eh)', 'log10(ehat)','log10(edash');
xlabel('log10(h)'); ylabel('log10(e)'); title('log10(error) values vs log10(h)');
grid on;
hold off;

end % the function
