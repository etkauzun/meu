clear all; clc; close all;

% Initial conditions
T1 = 300;
p1 = 2;
M1 = 3.2;
int = 0.01;
M = 0.1:int:3.2; % Mach values
gamma = 1.4;

% Fanno line
T_T1f = (2+(gamma-1)*M1^2) ./ (2+(gamma-1)*M.^2);
p_p1f = sqrt(T_T1f)*M1./M;
SRf = (gamma/(gamma-1)) * log(T_T1f) - log(p_p1f);

% Rayleigh line
p_p1r = (1 + gamma*M1^2) ./ (1 + gamma*M.^2);
T_T1r = (p_p1r .* M./M1).^2;
SRr = (gamma/(gamma-1)) * log(T_T1r) - log(p_p1r);

% Plot
figure(1)
hold on; grid on;
plot(SRf,T_T1f,'r',LineWidth=2);
plot(SRr,T_T1r,'b',LineWidth=2);
xlabel('S/R'); ylabel('T/T1'); 
legend('Fanno Line', 'Rayleigh Line');
title('Fanno & Rayleigh Lines for Varying Mach Numbers');


% Table
Anan = [M',p_p1f',p_p1r',T_T1f',T_T1r',SRf',SRr'];