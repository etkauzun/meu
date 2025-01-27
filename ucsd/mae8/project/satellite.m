function [T, X, Y, Z, U, V, W] = satellite(Xo, Yo, Zo, Uo, Vo, Wo, Tf)
% SATELLITE obtains the trajectory of a satellite
%   Inputted the initial position & velocity with total simulation time (Tf),
%   the function outputs the position & velocity @ time t = Tf

Re = 6.37 * 10^6; % Radius of Earth 
Me = 5.97 * 10^24; % Mass of Earth 
G = 6.67408 * 10^(-11); % Gravity 
m = 250; % Mass of the satellites 
As = 0.25; % Projected area of the satellites 
Pa = 5.5 * 10^(-12); % Air density
Cd = 2.2; % Drag coefficient

dt = 1; % time-step

% pre-allocation

ntotal = fix(Tf/dt);
T = zeros(1,ntotal);
X = zeros(1,ntotal);
Y = zeros(1,ntotal);
Z = zeros(1,ntotal);
U = zeros(1,ntotal);
V = zeros(1,ntotal);
W = zeros(1,ntotal);

% initiation

T(1) = 0;
X(1) = Xo;
Y(1) = Yo;
Z(1) = Zo;
U(1) = Uo;
V(1) = Vo;
W(1) = Wo;

for n = 1:ntotal
    U(n+1) = U(n) - ( (G*Me*(X(n)/(X(n)^2 + Y(n)^2 + Z(n)^2)^(3/2))) +  ( (Cd*Pa*As/(2*m)) * U(n)*sqrt(U(n)^2 + V(n)^2 + W(n)^2) ))*dt;
    V(n+1) = V(n) - ( (G*Me*(Y(n)/(X(n)^2 + Y(n)^2 + Z(n)^2)^(3/2))) +  ( (Cd*Pa*As/(2*m)) * V(n)*sqrt(U(n)^2 + V(n)^2 + W(n)^2) ))*dt;
    W(n+1) = W(n) - ( (G*Me*(Z(n)/(X(n)^2 + Y(n)^2 + Z(n)^2)^(3/2))) +  ( (Cd*Pa*As/(2*m)) * W(n)*sqrt(U(n)^2 + V(n)^2 + W(n)^2) ))*dt;
    X(n+1) = X(n) + (U(n+1) * dt);
    Y(n+1) = Y(n) + (V(n+1) * dt);
    Z(n+1) = Z(n) + (W(n+1) * dt);
    T(n+1) = T(n) + dt;
end % for loop


end % function satellite










