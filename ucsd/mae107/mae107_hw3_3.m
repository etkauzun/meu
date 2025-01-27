function [log_eh] = mae107_hw3_3(x0)
% mae107_hw3_3 computes the derivative at x0=0 using difference
% approximations for the function f = x^(7/2) + x for h = 10^j, j in [0,8];
%   
% input variable:
%   x0 - x values
% 
% output variables:
%   log_eh - log10 values of eh
%
% Call format: [log_eh] = mae107_hw3_3(x0)

Dh = []; % creating an empty array to store Dh values
eh = []; % creating an empty array to store eh values
h_arr = []; % creating an empty array to store log10 of h values

% x0 = 1; 
fprime_x0 = (7*x0^(5/2))/2 + 1; % calculating derivative of f at x0
fx0 = x0^(7/2) + x0; % computing f at x0

for j = 0:8 % running a loop for j in h
    h = 10^(-j);
    h_arr = [h_arr, log10(h)]; % storing log10 for h values in an array

    % Dh = f(x0 +h) - f(x0) / h
    x = x0 + h; % setting function f input x
    Dh = [Dh, (( (x^(7/2) + x) - fx0) / h)]; % storing Dh value for h
    eh = [eh, abs((Dh(j+1)-fprime_x0))]; % storing eh value; eh = |Dh - fprime|
    x = 0; % changing x to 0 for the next iteration of the loop 

end % for on line 21


log_eh = [log10(eh)]; % storing log10 values of eh

figure(1); hold on;
plot(h_arr, log_eh, '-b',"LineWidth",2); % plotting log10 values of eh
legend('log10(eh)') %, 'log10(ehat)','log10(edash');
xlabel('log10(h)'); ylabel('log10(e)'); title('log10(error) values vs log10(h)');
grid on;
hold off;

end % the function
