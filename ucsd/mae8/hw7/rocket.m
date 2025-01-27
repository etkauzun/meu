function [T, Z, W] = rocket(Tf, dt)
% rocket solves the motion of the rocket
%   inputted the duration of the flight & time step, 
% the function outputs the time, height, velocity vectors

global m 

m = 10;

% pre-allocation 
ntotal = fix(Tf/dt);
T = zeros(1,ntotal);
Z = zeros(1,ntotal);
W = zeros(1,ntotal);

% initiate

T(1) = 0;
Z(1) = 0;
W(1) = 0;


for n = 1:ntotal
    T(n+1) = T(n) + dt;
    g = gravity(Z(n));
    Th = thrust(T(n));
    W(n+1) = W(n) + (-g + (Th/m)) * dt;
    Z(n+1) = Z(n) + W(n+1) * dt;
end % for 

% W(end)=[];
% Z(end)=[];
% T(end)=[];

end % function rocket

%% SUB-FUNCTION THRUST
function [Th] = thrust(t)
% thrust outputs the thrust amount
%   inputted the time, the function gets the thrust.

if t >= 0 && t < 2
    Th = 680;
elseif t < 4
    Th = 1356;
else
    Th = 0;
end % if

end % function thrust

%% SUB-FUNCTION GRAVITY
function [g] = gravity(z)
% gravity finds the gravity at the given moment
%   inputted the height, z, the function outputs the gravity

if z >= 0 && z < 10000
    g = 9.81 * (1 - (z/10000)^3);
else 
    g = 0;
end % if 

end % function gravity 

