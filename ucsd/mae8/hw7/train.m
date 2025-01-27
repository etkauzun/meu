function [T, X, U] = train(Tf, dt)
% train solves the motion of the train
%   inputted the the total traveling time and time step, the function
%   outputs time, distance, and velocity of the train.

% pre-allocation
ntotal = fix(Tf/dt);
T = zeros(1,ntotal);
X = zeros(1,ntotal);
U = zeros(1,ntotal);

% initialize 
T(1) = 0;
X(1) = 0;
U(1) = 0;


for n = 1:ntotal
    U(n+1) = U(n) + (4 * sech(T(n)/25)^2 * tanh(T(n)/25)) * dt;
    X(n+1) = X(n) + U(n) * dt;
    T(n+1) = T(n) + dt;

end % for loop

end