clear; clc; close all;
%% q0 - Bode Plots
% PID Filter Plot
Fpid= tf([1 101 100],[0 1 0])
figure(1)
bode(Fpid)

% Bandpass Filter Plot
Fbp = tf([0 1 0],[1 101 100])
figure(2)
bode(Fbp)

% All-pass Filter Plot
Fap = tf([0 1 -1],[0 1 1])
figure(3)
bode(Fap)
%% q4
% Need to find a K value that sets G = 1

% Setting up the function & finding the transfer function
syms L1 L2 L3 L4 L5 L6 L7 x y w v
eqn1= v+L2*w==L1*y;
eqn2= L4*y==L3*x;
eqn3= v==L5*x-L5*y;
% eqn4= L6*y==L7*w;
sol=solve(eqn1,eqn2,eqn3,x,y,v); G=sol.y/w;  % G = Y/W

% Substituting the values of L &  M = 1000kg, C = 0, m = 0kg
syms M m C c K k s
M = 1000; C = 0; m = 0;
G=subs(sol.y/w,{L1,L2,L3,L4, L5},{M*s^2+C*s+K, K+C*s, m*s^2+c*s+k, k+c*s, k+c*s})
[numG,denG] = numden(G);      % this extracts out the num and den of G
numG=coeffs(numG,s);          % this extracts the powers of s in the num and den
denG=coeffs(denG,s);
numG=simplify(numG/denG(end)); % this makes the den monic
denG=simplify(denG/denG(end));
numG=numG(end:-1:1)   % this reverses the order of the vector of coefficients.
denG=denG(end:-1:1)


F_q4_a = tf([0 0 1], [1 0 1])
figure(4)
bode(F_q4_a)

% Substituting
m = 100; K=1000;
G=subs(sol.y/w,{L1,L2,L3,L4, L5},{M*s^2+C*s+K, K+C*s, m*s^2+c*s+k, k+c*s, k+c*s})
[numG,denG] = numden(G);      % this extracts out the num and den of G
numG=coeffs(numG,s);          % this extracts the powers of s in the num and den
denG=coeffs(denG,s);
numG=simplify(numG/denG(end)); % this makes the den monic
denG=simplify(denG/denG(end));
numG=numG(end:-1:1)   % this reverses the order of the vector of coefficients.
denG=denG(end:-1:1)

syms F f  
c = 10; k = 33;
F = (s^2 + (c*s/100) + (k/100))/(s^4+(11*c*s^3/1000)+(s^2*((11*k/1000)+1))+(c*s/100)+(k/100)) % Y(s) function

poles = RR_tf([1,1/10,33/100],[1,11/100,1363/1000,1/10,33/100]) % of F
p1 = -0.0447 - 0.5600i;
p2 = -0.0447 + 0.5600i;
p3 = -0.0103 - 1.0225i;
p4 = -0.0103 + 1.0225i;
f_a = 1; f_b = 1/10; f_c = 33/100;
A = (f_a*p1^2+f_b*p1+f_c)/((p1-p2)*(p1-p3)*(p1-p4));
B = (f_a*p2^2+f_b*p2+f_c)/((p2-p1)*(p2-p3)*(p2-p4));
C = (f_a*p3^2+f_b*p3+f_c)/((p3-p1)*(p3-p2)*(p3-p4));
D = (f_a*p4^2+f_b*p4+f_c)/((p4-p1)*(p4-p3)*(p4-p2));
t = 0:0.01:100;
f = A*exp(p1*t) + B*exp(p2*t) + C*exp(p3*t) + D*exp(p4*t);

figure(5)
plot(t, f)

figure(6)
bode([1,1/10,33/100],[1,11/100,1363/1000,1/10,33/100])