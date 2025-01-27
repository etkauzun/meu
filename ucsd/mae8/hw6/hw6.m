% tic;
clear all;
close all;
clc;
format long;

name = 'Etka Uzun';
id = 'A15956274';
hw_num = 6;
%% Problem 1
% (a)
p1a = sqrt(1);
for n = 1:9
    p1a = sqrt(1 + p1a);
end

% (b)
p1b = sqrt(1);
for n = 1:9
    p1b = sqrt(1 + 2*p1b);
end

% (c)
p1c = sqrt(2);
for n = 1:9
    p1c = sqrt(2 + (-1)^n * p1c);
end
%% Problem 2
% (a)
p2a = 1;
while (exp(1)/factorial(p2a+2) >= 10^-9)
   
    p2a = p2a+1;
end


% (b)
p2b = 1;  
while ((p2b+1)*log(p2b+1) <= 10^9)
    
    p2b = p2b+1;
end

%% Problem 3
% (a)
pi_appr = 0; k = 0;
while(abs(pi - pi_appr) >= 10^-6)
    pi_appr = pi_appr + 4*( (-1)^k / ((2*k) + 1));
    k = k + 1;
end

p3a = pi_appr;
p3b = k - 1;

% (b)
pi_appr2 = 0; k = 0;
while(abs(pi - pi_appr2) >= 10^-6)
    pi_appr2 = pi_appr2 + sqrt(12)* (-3)^(-k) / (2*k + 1);
    k = k + 1;
end

p3c = pi_appr2; 
p3d = k - 1;
p3e = 'The series in part (c) converges faster';
%% Problem 4
load('stringA.mat')
% (a)
counter_you = 0; 
counter_say = 0;
counter_how = 0;

for n = 1:length(stringA)-2
    switch stringA(n:n+2)
        case 'you'
            counter_you = counter_you + 1;
        case 'say'
            counter_say = counter_say + 1;
        case 'how'
            counter_how = counter_how + 1;
    end
end

p4a = counter_you;
p4b = counter_say;
p4c = counter_how;

% (b)
counter_code = 0; 
counter_will = 0;
counter_loop = 0;

for n = 1:length(stringA)-3
    switch stringA(n:n+3)
        case 'code'
            counter_code = counter_code + 1;
        case 'will'
            counter_will = counter_will + 1;
        case 'loop'
            counter_loop = counter_loop + 1;
    end
end

p4d = counter_code;
p4e = counter_will;
p4f = counter_loop;
%% Problem 5
load('terrain.mat')

counter_lmax = 0;
counter_lmin = 0;

for n = 1:length(x)
    for m = 1:length(y)
        if n == 1 && m ==1 % corner
            nb(1) = altitude(n,m+1);
            nb(2) = altitude(n+1,m+1);
            nb(3) = altitude (n+1,m);
        elseif n == 1 && m==length(y) %corner
            nb(1) = altitude(n,m-1);
            nb(2)= altitude(n+1,m-1);
            nb(3)= altitude(n+1,m);
        elseif n ==length(x) && m == 1 % corner
            nb(1) = altitude(n,m+1);
            nb(2) = altitude(n-1,m+1);
            nb(3) = altitude(n-1,m);
        elseif n == length(x) && m==length(y) %corner
            nb(1) = altitude(n,m-1);
            nb(2) = altitude(n-1,m-1);
            nb(3) = altitude(n-1,m);
        elseif n == 1 && (m ~= 1 || m~= length(y)) % edge
            nb = altitude(n:n+1,m-1:m+1);
        elseif n == length(x) && (m ~= 1 || m~= length(y)) % edge
            nb = altitude(n-1:n,m-1:m+1);
        elseif (n~=1 || n~= length(x)) && m == 1 % edge
            nb = altitude(n-1:n+1,m:m+1);
        elseif (n~=1 || n~= length(x)) && m == length(y) % edge
            nb = altitude(n-1:n+1,m-1:m);
        else
            nb = altitude(n-1:n+1,m-1:m+1);
            nb(5) =[];
        end
        
        if altitude(n,m) >= max(nb)
            counter_lmax = counter_lmax + 1;
            xloc_max(counter_lmax) = x(n);
            yloc_max(counter_lmax) = y(m);
            alt_lmax(counter_lmax) = altitude(n,m);
        elseif altitude(n,m) <= min(nb)
            counter_lmin = counter_lmin + 1;
            xloc_min(counter_lmin) = x(n);
            yloc_min(counter_lmin) = y(m);
            alt_lmin(counter_lmin) = altitude(n,m);
        end
    end
end



figure(1); hold on; surf(x,y,altitude'); shading interp; grid on;
plot3(xloc_max, yloc_max, alt_lmax,'ro','MarkerSize',15,'MarkerFaceColor','r');
plot3(xloc_min, yloc_min, alt_lmin,'bo','MarkerSize',15,'MarkerFaceColor','g')
xlabel('x(m)'); ylabel('y(m)');
zlabel('altitude(m)'); title('Terrain Topography');
legend('terrain', 'peak', 'trough');
view(3)

p5a = counter_lmax;
p5b = xloc_max;
p5c = yloc_max;
p5d = alt_lmax;
p5e = counter_lmin;
p5f = xloc_min;
p5g = yloc_min;
p5h = alt_lmin;
p5i = 'See figure 1';
%% THE END
% toc;
