%% Question 1:
clear;clc;close all;
% Part (a)
syms s
Y = [-3,-2]; % -3s-2
U = [1,5,4]; % s^2+5s+4
G = RR_tf(Y,U);
Us = 1/s; % U(s) is 1/s

Y_s = poly2sym(Y,s);
U_s = poly2sym(U,s);
G_s = Y_s/U_s;

% Part (b)
zeros = RR_roots(Y);
poles = RR_roots(U);

% Part (c)
% The G(s) is stable since poles < 0

% Part(d)
deg_Y = polynomialDegree(Y_s);
deg_U = polynomialDegree(U_s);
% Since the deg_Y is less than deg_U, the G(s) is strictly proper

% Part(e)
IVT = limit(G_s,s,inf); % 0
FVT = limit(G_s,s,0); % -1/2

% Part(1f)
% Partial fraction expansion
Ys = G_s*Us;
PFE_Y = partfrac(Ys);
% Inverse laplace
inverse_laplace_Y = ilaplace(PFE_Y);
% If you want to display, please use pretty(PFE_Y)

% Plot
[numYs,denYs] = numden(G_s);      
numYs = coeffs(numYs,s,'All');
denYs = coeffs(denYs,s,'All');
Y = RR_tf(numYs,denYs);
% figure(1), RR_step(Y)


%% Question 2:
% Part (a)
D_s = 1; % Question 2
Rs = 1/s; % R(s) is 1/s
T_s = simplify(G_s*D_s/(1+G_s*D_s));
[numTs,denTs] = numden(T_s);
numTs = coeffs(numTs,s,'All');
denTs = coeffs(denTs,s,'All');
poles_Ts = RR_roots(denTs);

% Part (b)
% The T(s) is stable since poles < 0

% Part (c)
% s^2 + a1*s + a0 = s^2 + 2*zeta*omega_n*s + omega_n^2
omega_n = sqrt(denTs(3));
zeta = denTs(2)/(2*omega_n);
sigma = denTs(2)/2;

% Tr rise time, Ts settling time, Mp overshoot
Tr = 1.8/omega_n;
Ts = 4.6/sigma;
% If zeta > 0.7 Mp <= 5%
% If zeta > 0.5 Mp <= 15%
Mp = double(exp(-pi*zeta/sqrt(1-zeta^2)));

% Part (d)
IVT_Ts = limit(T_s,s,inf); %!!
FVT_Ts = limit(T_s,s,0);

% Part (e)
% Partial fraction expansion
YTs = T_s*Rs;
PFE_YTs = partfrac(YTs);
% If you want to display, please use pretty(PFE_YTs)
% Inverse laplace 
inverse_laplace_YT = ilaplace(PFE_YTs);


% Plot
[numYTs,denYTs] = numden(T_s);  
numYTs = coeffs(numYTs,s,'All');
denYTs = coeffs(denYTs,s,'All');
Y = RR_tf(numYTs,denYTs);
figure(2), RR_step(Y)


%% Question 3:
% Part (a)
D_s = (-s - 1)/(3*s + 2); % Question 3
Rs = 1/s; % R(s) is 1/s
T_s_3 = simplify(G_s*D_s/(1+G_s*D_s));
[numTs_3,denTs_3] = numden(T_s_3);
numTs_3 = coeffs(numTs_3,s,'All');
denTs_3 = coeffs(denTs_3,s,'All');
poles_Ts = RR_roots(denTs_3);

% Part (b)
% The T(s) is stable since poles < 0

% Part (c)
% s^2 + a1*s + a0 = s^2 + 2*zeta*omega_n*s + omega_n^2
omega_n_3 = sqrt(denTs_3(2));
zeta_3 = denTs_3(2)/(2*omega_n);
sigma3 = denTs_3(1)/2;

% Tr rise time, Ts settling time, Mp overshoot
Tr_3 = 1.8/omega_n;
Ts_3 = 4.6/sigma;
% No Mp (overshoot) since it is 1st order

% Part (d)
IVT_Ts_3 = limit(T_s_3,s,inf); %!!
FVT_Ts_3 = limit(T_s_3,s,0);

% Part (e)
% Partial fraction expansion
YTs_3 = T_s_3*Rs;
PFE_YTs_3 = partfrac(YTs_3);
% If you want to display, please use pretty(PFE_YTs)
% Inverse laplace 
inverse_laplace_YT = ilaplace(PFE_YTs_3);


% Plot
[numYTs_3,denYTs_3] = numden(T_s_3);  
numYTs_3 = coeffs(numYTs_3,s,'All');
denYTs_3 = coeffs(denYTs_3,s,'All');
Y_3 = RR_tf(numYTs_3,denYTs_3);
figure(3), RR_step(Y_3)


%% 2013 midterm 1c
clear;clc;
syms s
m1 = 6; m2 = 3; l1 = 2; l2 = 1; I1 = m1*l1^2/3; I2 = m2*l2^2/3;
g = 10; k = 19;

num = [I2, 0, -m2*g];
den = [I1*I2, 0, -(m1*I2+m2*I1)*g+(I1+I2)*k, 0, -m1*m2*g^2-(m1+m2)*g*k];

Y_s = poly2sym(num,s);
U_s = poly2sym(den,s);

G_s = Y_s/U_s;
% Partial fraction expansion
PFE_Ys = partfrac(G_s);
% Inverse laplace
inverse_laplace_Y = ilaplace(PFE_Ys);













