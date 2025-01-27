% hw2_q2
clear; clc; format long
%%
% simulation set-up
dt = 0.1; 

dist = 500*1000; % [m]
V = 0.8*322; % [m/s]
time = dist/V; % [s]
nsteps = time*10;

% setting initial condition
W0 = 12000*9.81; % initial weight
x = [0;W0];     

% running simulation
for i = 1:nsteps
    xs(:,i) = x; % storing state vector in columns
    x = Euler(x,dt);
end % for loop

% extracting the weight variable
Ws = xs(2,:);

ans = (W0-Ws(end))/9.81

function xdot = EOM(x)
    % setting the parameters
    S = 29;                            
    rho = 0.78;                        
    sos = 322;   % [m/s]                                             
    TSFC = 0.7/3600; % [1/s]   
    % h = 4500; % [m]
    M = 0.8; 
    V = 0.8*sos; % [m/s]

    % extracting the state variable from input vector x
    t = x(1);           % time [s]
    W = x(2);           % weight

    % computing the contants
    q = 0.5*rho*V^2; % dynamic pressure
    K = 0.7 + 0.2 * tanh(5 * (M - 0.95));   % induced drag
    CD0 = 0.04 + 0.02 * tanh(5 * (M - 0.95));  % zero-lift drag coefficient
    T = (q*S*CD0) + ((2*K*W^2)/(rho*S*V^2)); % thrust

    % differential eqn
    dwdt = -TSFC*T;

    % creating the output vector
    xdot = zeros(2,1);
    xdot(1) = 1; % time [s]
    xdot(2) = dwdt; 

end % EOM function

function xnew = Euler(xold, h)
    xdot = EOM(xold);
    xnew = xold + h*xdot;
end % Euler function

%% a different but wrong method

% function xdot = EOM(x)     
%     % setting the parameters
%     S = 29;                            
%     rho = 0.78;                        
%     sos = 322;                                                 
%     TSFC = 0.7;   
%     mu = 0; 
% 
%     % extracting the state variable from input vector x
%     V = x(1);           % velocity [m/s]
%     gamma = x(2);       % flight path angle
%     chi = x(3);         % flight path heading
%     phi = x(4);         % latitude
%     lambda = x(5);      % longitude
%     h = x(6);           % altitude
%     W = x(7);           % weight
% 
%     % computing the contants
%     R = 6378 + h;               % Earth's radius
%     m = W/9.81;                 % mass
%     M = V/sos;                  % Mach number
%     q = 0.5 * rho * V^2;        % dynamic pressure
%     T = (78.7 + (13.3 * M) - (6.3 * h) ...  % thrust
%         + (0.13 * h^2) + (7.3 * M^2) - (h * M)) * 1000; 
%     K = 0.7 + 0.2 * tanh(5 * (M - 0.95));   % induced drag
%     CD0 = 0.04 + 0.02 * tanh(5 * (M - 0.95));  % zero-lift drag coefficient
%     L = W;                      % lift
%     CL = L / (q * S);           % lift coefficient
%     CD = CD0 + (K * CL^2);      % drag coefficient
%     D = q * S * CD;             % drag
% 
% 
%     % differential equations
%     dVdt = 0;       % = (T-D-(W*sin(gamma)))/m;
%     dgammadt = 0;   % = (L*cos(mu - W*cos(gamma)))/(m*V);
%     dchidt = (L*sin(mu))/(m*V*cos(gamma));
%     dphidt = (V*cos(gamma)*cos(chi))/R;
%     dlambdadt = (V*cos(gamma)*sin(chi))/(R*cos(phi));
%     dhdt = 0;       % = V*sin(gamma);
%     dwdt = -TSFC*T;
% 
%     % creating the output vector
%     xdot = zeros(7,1);
%     xdot(1) = V;
%     xdot(2) = dgammadt;
%     xdot(3) = dchidt;
%     xdot(4) = dphidt;
%     xdot(5) = dlambdadt;
%     xdot(6) = dhdt;
%     xdot(7) = dwdt;
% end % EOM function
% 
% function xnew = Euler(xold, h)
%     xdot = EOM(xold);
%     xnew = xold + h*xdot;
% end % Euler function
% 
% % setting the initial conditions
% V0 = 0.8*322; % initial speed [m/s]
% gamma0 = 0; % flight path angle [rad]
% % chi0 = ?
% % phi0 = ?
% % lambda0 = ?
% h0 = 4.5;
% W0 = 12000*9.81;
% 
% x = [V0, gamma0, chi0, phi0, lambda0, h0, W0];