clear all; close all; clc; format long; 
name = 'Etka Uzun';
id = 'A15956274';
hw_num = 'midterm';
form = 'C';
%% Problem 1
time = clock;
p1a = sprintf('At %2.0f:%2.0f:%2.0f on %4.0f/%1.0f/%2.0f, I affirm that I will not give or receive any unauthorized help on this exam, and that all work will be my own.',time(4),time(5),time(6), time(1), time(3),time(2));
%% Problem 2
n = 1:90;
p2a = n;
p2b = 2.^(n+1) .* (n+1);
p2greater = find(p2b > 10^20);
p2c = p2greater(1);
%% Problem 3
matA = 1:196; matA = abs(ceil(100*cos(matA/10))); 
matA = reshape(matA, 14,14); 
p3a = matA(5,:);
p3b = diag(matA)';
p3c = matA(:,[1,4,6]);
mat_remained = rem(matA,13);
p3d = 1; %% Change this: sp3d = any(mod(matA(:),13)==0);
p3f = matA;
p3f(find(p3f == max(max(matA)))) = max(max(matA))+ 30;
%% Problem 4
x = -7000:20:7000;
f = cosd((x+360)./360).* (exp(1)).^(-1.* ((x./3600).^2));
p4a = x;
p4b = f;
p4c = max(diff(f)./diff(x)); % fp = diff(f)./diff(x); sp4c = x(fp == max(fp));
dx = x(2)-x(1);
p4d = dx * (0.5*(f(1) + f(end)) + sum(f(2:end-1)) );
%% Problem 5
x = -2:0.0404:2;
ygreater = 2 .* sech(x).^2;
yless = abs(x.^3) - 1;
%ind_peak(1) = find(ygreater == yless & x < 0);
%ind_peak(2) = find(ygreater == yless & x > 0);
figure(1); hold on; plot(x,ygreater, '-k.','LineWidth', 5); plot(x, yless,'ko','LineWidth',2); axis([-2 2 -2 4]);
xlabel('x'); ylabel('y'); title('Solution to system of nonlinear inequality equations');
p5a = 'See figure 1';
% p5b = 
% sp5b = [min(x(y1 > y2)) max(x(y1 > y2))];


% x = linspace(-2,2,100);
% y1 = 2*sech(x).^2;
% y2 = abs(x.^3)-1;
% 
% figure(1); hold on;
% plot(x,y1,'--k',x,y2,'k:','LineWidth',2);  this line plots both x&y1 and
% x&y2 with respective line features
% plot(x(y1 > y2), y1(y1 > y2),'ko','MarkerFaceColor','k','LineWidth',2);
% the line above changes the marker feature of y1 within x where y1>y2 and 
% y where y1>y2
% plot(x(y1 > y2), y2(y1 > y2),'ko','MarkerFaceColor','k','LineWidth',2);
% the line above changes the marker feature of y2 within where 
% axis([-2 2 -2 4]);
% xlabel('x'); ylabel('y');
% box on; grid on;
% title('Solution to system of nonlinear inequality equations');
% legend('y = 2 sech^2(x)','y = |x^3| - 1','solution boundaries','Location','North');
% set(gca,'FontSize',14); this line changes the font size
% sp5a = 'See figure 1';




