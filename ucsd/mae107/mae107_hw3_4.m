function [log_eh2] = mae107_hw3_4(x0)
% mae107_hw3_4 computes the second derivative at x0=0 using difference
% approximations for the function f = ln(x^2 + 2) for h = 10^j, j in [0,5];
%   
% input variable:
%   x0 - x values
% 
% output variables:
%   log_eh2 - log10 values of eh2
%
% Call format: [log_eh2] = mae107_hw3_4(x0)

Dh2 = []; % creating an empty array to store Dh2 values
eh2 = []; % creating an empty array to store eh values
h_arr = []; % creating an empty array to store log10 of h values

fprime2_x0 = 2/(x0^2 + 2) - (4*x0^2)/(x0^2 + 2)^2; % calculating derivative of f at x0
fx0 = log((x0^2) + 2); % computing f at x0

for j = 0:5 % running a loop for j in h
    h = 10^(-j);
    h_arr = [h_arr, log10(h)]; % storing log10 for h values in an array

    % Dh2 = [f(x0 +h) + f(x0-h) - 2fx0] / 2h
    n = x0 + h; % setting function f input n
    m = x0 - h; % setting function f input m
    fn = log((n^2) + 2);
    fm = log((m^2) + 2);
    Dh2 = [Dh2, (( (fn + fm - (2*fx0)) / h^2))]; % storing Dh2 value for h
    eh2 = [eh2, abs((Dh2(j+1)-fprime2_x0))]; % storing eh value; eh = |Dh - fprime|
    n = 0; m = 0; % changing n & m to 0 for the next iteration of the loop 

end % for on line 21

log_eh2 = [log10(eh2)]; % storing log10 values of eh

figure(1); hold on;
plot(h_arr, log_eh2, '-b',"LineWidth",2); % plotting log10 values of eh
legend('log10(eh2)');
xlabel('log10(h)'); ylabel('log10(eh2)'); title('log10(error) values vs log10(h)');
grid on;
hold off;

end % the function
