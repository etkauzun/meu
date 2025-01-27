clear; clc;
%% q3
syms L1 L2 L3 L4 L5 L6 L7 L8 L9 x y z u
eqn1= L1*x+L2*y==0;
eqn2= L3*x+L4*y+L5*z==0;
eqn3= L6*x+L7*y+L8*z==L9*u;
sol=solve(eqn1,eqn2,eqn3,x,y,z); G=sol.y/u
%% q4
sig = 4; b=1; ubar=48; syms s;

% first equilibrium
x1 = sqrt(b*(ubar-1)); y1 = sqrt(b*(ubar-1)); z1 = -1;
% G=subs(sol.y/u,{L1,L2,L3,L4,L5, L6, L7, L8, L9},{-sig-s,sig,-z1,-1-s,-x1,y1,x1, -b-s,b})
% [numG,denG] = numden(G);      % this extracts out the num and den of G
% numG=coeffs(numG,s);          % this extracts the powers of s in the num and den
% denG=coeffs(denG,s);
% numG=simplify(numG/denG(end)); % this makes the den monic
% denG=simplify(denG/denG(end));
% 
% numG=numG(end:-1:1)   % this reverses the order of the vector of coefficients.
% denG=denG(end:-1:1)
den = [1, b+sig+1, b+sig+x1^2+sig*b+sig*z1,sig*x1^2+sig*x1*y1+sig*b+b*sig*z1];
nom = [x1*b, sig*x1*b];
pole1 = RR_roots(den)
zero1 = RR_roots(nom)


% second equilibrium
x2 = -sqrt(b*(ubar-1)); y2 = -sqrt(b*(ubar-1)); z2 = -1;
% G=subs(sol.y/u,{L1,L2,L3,L4,L5, L6, L7, L8, L9},{-sig-s,sig,-z2,-1-s,-x2,y2,x2, -b-s,b})
% [numG,denG] = numden(G);      % this extracts out the num and den of G
% numG=coeffs(numG,s);          % this extracts the powers of s in the num and den
% denG=coeffs(denG,s);
% numG=simplify(numG/denG(end)); % this makes the den monic
% denG=simplify(denG/denG(end));
% 
% numG=numG(end:-1:1)   % this reverses the order of the vector of coefficients.
% denG=denG(end:-1:1)
% 
den = [1, b+sig+1, b+sig+x2^2+sig*b+sig*z2,sig*x2^2+sig*x2*y2+sig*b+b*sig*z2];
nom = [x2*b, sig*x2*b];
pole2 = RR_roots(den)
zero2 = RR_roots(nom)

% third equilibrium
x3 = 0; y3 = 0; z3 = -ubar;

% G=subs(sol.y/u,{L1,L2,L3,L4,L5, L6, L7, L8, L9},{-sig-s,sig,-z3,-1-s,-x3,y3,x3, -b-s,b})
% [numG,denG] = numden(G);      % this extracts out the num and den of G
% numG=coeffs(numG,s);          % this extracts the powers of s in the num and den
% denG=coeffs(denG,s);
% numG=simplify(numG/denG(end)); % this makes the den monic
% denG=simplify(denG/denG(end));
% 
% numG=numG(end:-1:1)   % this reverses the order of the vector of coefficients.
% denG=denG(end:-1:1)
% 
% pole3 = RR_roots(denG)
% zero3 = RR_roots(numG)
den = [1, b+sig+1, b+sig+x3^2+sig*b+sig*z3,sig*x3^2+sig*x3*y3+sig*b+b*sig*z3];
nom = [x3*b, sig*x3*b];
pole3 = RR_roots(den)
zero3 = RR_roots(nom)

%% Tried a for loop but there was a bug so did it one by one above
% zbar xbar ybar 
% x_eq = [sqrt(b*(ubar-1)), -sqrt(b*(ubar-1)),0];
% y_eq = [sqrt(b*(ubar-1)), -sqrt(b*(ubar-1)),0];
% z_eq = [-1,-1, -ubar];
% poles = [];
% zeros = [];
%denG_arr = [];
% for i=1:3
%     xbar = x_eq(i); ybar = y_eq(i); zbar = z_eq(i);
%     G=subs(sol.y/u,{L1,L2,L3,L4,L5, L6, L7, L8, L9},{-sig-s,sig,-zbar,-1-s,-xbar,ybar,xbar, -b-s,b})
%     [numG,denG] = numden(G);      % this extracts out the num and den of G
%     numG=coeffs(numG,s);          % this extracts the powers of s in the num and den
%     denG=coeffs(denG,s);
%     numG=simplify(numG/denG(end)); % this makes the den monic
%     denG=simplify(denG/denG(end));
% 
%     numG=numG(end:-1:1)   % this reverses the order of the vector of coefficients.
%     denG=denG(end:-1:1)
%     %denG_arr = [denG_arr; denG];
% 
%     pole = RR_roots(denG);
%     zero = RR_roots(numG);
%     poles = [poles, pole];
%     zeros = [zeros, zero];
% 
% end % for loop
%% q5

syms s c1 c0 p3 p2 p1 A B C D
alpha = (c1*s + c0);
beta = (D*(s-p3)*(s-p2)*(s-p1)) + (C*(s-p3)*(s-p2)*s) + (B*(s-p3)+(s-p1)*s) + (A*(s-p2)*(s-p1)*s);
q5_arr = [];
q5_arr = [q5_arr,solve(alpha==beta,A)];
q5_arr = [q5_arr;solve(alpha==beta,B)];
q5_arr = [q5_arr;solve(alpha==beta,C)];
q5_arr = [q5_arr;solve(alpha==beta,D)];

%% q6

% first equilibrium
a3 = 1; a2 = b+sig+1; a1_1 = x1^2 + b + sig + (b*sig)+ (sig*z1);
a0_1 = sig*(x1^2 + y1 * x1 + b + (b*z1));
c1_1 = b* x1; c0_1 = b*sig*x1;

% second equilibrium
a1_2 = x2^2 + b + sig + (b*sig) + (sig*z2);
a0_2 = sig*(x2^2 + (y2*x2)+ b + (b*z2));
c1_2 = b* x2; c0_2 = b*sig*x2;

plot1 = RR_tf([c1_1,c0_1],[a3,a2, a1_1,a0_1,0]);
plot2 = RR_tf([c1_2,c0_2],[a3,a2, a1_2,a0_2,0]);

figure(1); 
RR_step(plot1)
hold on
RR_step(plot2)


