clear all;
close all;
clc;
format long;

name = 'Etka Uzun';
id = 'A15956274';
hw_num = 7;
%% PROBLEM 1
load("matrixA.mat")
% Use break or continue statements to perform the following exercises with matrixA.
% (a) Sum all elements that are below the diagonal. Put the answer in p1a.
p1a = 0;
for i = 1:length(matrixA)
    column = matrixA(:,i);
    for n = 1:length(column)
        if n < i
            continue;
        elseif  n > i
            p1a = p1a + column(n);
        elseif n == i && n ~= 20
            continue;
        else
            break;
        end
    end
end

% (b) Find the product of all elements that are above the diagonal. Put the answer in p1b.
p1b = 1;
for i = 1:length(matrixA)
    column = matrixA(:,i);
    for n = 1:length(column)
        if n < i
            p1b = p1b * column(n);
        elseif  n > i
            continue;
        elseif n == i && n ~= 20
            continue;
        else
            break;
        end
    end
end

% (c) Sum all elements in matrixA. Exclude the elements whose row index is twice as large
% as their column index. Put the answer in p1c.
p1c = 0;

for i = 1:length(matrixA)
    column = matrixA(:,i);
    for n = 1:length(column)
        if n  == i*2
            continue;
        else
            p1c = p1c + column(n);
        end
    end
end

% (d) Find the product of all elements in matrixA. Exclude the elements whose value is
% larger than their column index. Put the answer in p1d.
p1d = 1;

for i = 1:length(matrixA)
    column = matrixA(:,i);
    for n = 1:length(column)
        if column(n) > i
            continue;
        else
            p1d = p1d * column(n);
        end
    end
end
%% PROBLEM 2 
p2a = evalc('help train');

% (b,c) Use function train to get the distance and velocity of the train at time Tf = 300 seconds. 
% Put the answers into p2b, and p2c, respectively. Use 20-second time step.
[p2bt p2bx p2bu] = train(300,20);
p2b = p2bx(end); 
p2c = p2bu(end);

% (d,e) Repeat the step above with 2-second time step. Put the distance and 
% velocity into p2d and p2e, respectively.
[p2dt p2dx p2du] = train(300,2);
p2d = p2dx(end);
p2e = p2du(end);

% (f) 
figure(1); 
subplot(2,1,1); hold on;
plot(p2bt, p2bx, '-ro'); plot(p2dt, p2dx,'-bd');
xlabel('time(s)'); ylabel('distance(m)'); title('T vs X'); 
legend('20 second step','2 second step');

subplot(2,1,2); hold on;
plot(p2bt, p2bu, '-ro'); plot(p2dt, p2du,'-bd');
xlabel('time(s)'); ylabel('velocity(m/s)'); title('T vs U'); 
legend('20 second step','2 second step');

p2f = 'See figure 1';
%% PROBLEM 3
p3a = evalc('help rocket');
p3b = evalc('help gravity');
p3c = evalc('help thrust');
p3d = evalc('help rocket>gravity');
p3e = evalc('help rocket>thrust');

% (f,g) Compute the altitude and velocity of the rocket at time t = 120 s 
% using ∆t = 0.1s. Put the answers in p4f and p4g, respectively. 
% The answers should be single numbers, not vectors.
[p3fT, p3fZ, p3fW] = rocket(120,0.1);
p3f = p3fZ(end);
p3g = p3fW(end);

% Create figure 2. Use function subplot to include 2 panels with one on 
% top of the other. The top panel shows how the altitude of the rocket 
% changes with time during the 120-second flight. The bottom panel shows 
% velocity versus time. Remember to include title, legend, and label the 
% axes with correct units. Set p3h = 'See figure 2'.

figure(2); subplot(2,1,1); hold on;
plot(p3fT,p3fZ,'-r', 'MarkerSize', 5);
xlabel('time(s)'); ylabel('altitude(m)'); title('Altitude vs Time'); 
legend('Altitude');

subplot(2,1,2); hold on;
plot(p3fT,p3fW,'-b', 'MarkerSize', 5);
xlabel('time(s)'); ylabel('velocity(m/s)'); title('Velocity vs Time'); 
legend('Velocity');

p3h = 'See figure 2';
%% THE END

