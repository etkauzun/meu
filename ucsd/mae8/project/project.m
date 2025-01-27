clear all;
close all;
clc;
format long;

name = 'Etka Uzun';
id = 'A15956274';
hw_num = 'project';
%% TASK 1
sat_data = importdata("satellite_data.txt"); % importing the sat data

% plotting the data
load("earth_topo.mat");
Re = 6.37e6;
figure(1); hold on;
[x,y,z] = sphere(50);
s = surf(Re*x/1e6,Re*y/1e6,Re*z/1e6); % create a sphere
s.CData = topo;                % set color data to topographic data
s.FaceColor = 'texturemap';    % use texture mapping
s.EdgeColor = 'none';          % remove edges
s.FaceLighting = 'gouraud';    % preferred lighting for curved surfaces
s.SpecularStrength = 0.4;      % change the strength of the reflected light
grid on; box on; axis equal;
axis(7*[-1 1 -1 1 -1 1]);  % IMPORTANT: axis unit is in 10^6 m
xlabel('x (10^6 m)'); ylabel('y (10^6 m)'); zlabel('z (10^6 m)'); title('Trajectory of Satellite 1');
set(gca,'LineWidth',1,'FontSize',14, ...
        'Xtick',[-6:4:6],'Ytick',[-6:4:6],'Ztick',[-6:4:6]);
view(3);
% getting the data for satellite 1
[Xo, Yo, Zo, Uo, Vo,Wo]= read_input('satellite_data.txt',1);
[T, X1, Y1, Z1,U1,V1,W1]  = satellite(Xo, Yo,Zo, Uo, Vo, Wo, 5000);
plot3(X1/1e6, Y1/1e6, Z1/1e6,'m-','LineWidth',2); % plotting the positions
plot3(X1(end)/1e6, Y1(end)/1e6, Z1(end)/1e6,'mo','MarkerSize',5,'MarkerFaceColor','m'); % plotting the positions
hold off;

p1a = evalc('help satellite'); p1b ='See figure 1';
%% TASK 2 

% reading the initial positions of the first six satellites via read_input
% function
[XoONE, YoONE, ZoONE, UoONE, VoONE, WoONE] = read_input('satellite_data.txt',1);
[Xo2, Yo2, Zo2, Uo2, Vo2, Wo2] = read_input('satellite_data.txt',2);
[Xo3, Yo3, Zo3, Uo3, Vo3, Wo3] = read_input('satellite_data.txt',3);
[Xo4, Yo4, Zo4, Uo4, Vo4, Wo4] = read_input('satellite_data.txt',4);
[Xo5, Yo5, Zo5, Uo5, Vo5, Wo5] = read_input('satellite_data.txt',5);
[Xo6, Yo6, Zo6, Uo6, Vo6, Wo6] = read_input('satellite_data.txt',6);

% finding the positions & velocity of the first six satellites using the
% values found above via satellite function
[TONE, XONE, YONE, ZONE, UONE, VONE, WONE] = satellite(XoONE, YoONE, ZoONE, UoONE, VoONE, WoONE, 12400);
[T2, X2, Y2, Z2, U2, V2, W2] = satellite(Xo2, Yo2, Zo2, Uo2, Vo2, Wo2, 12400);
[T3, X3, Y3, Z3, U3, V3, W3] = satellite(Xo3, Yo3, Zo3, Uo3, Vo3, Wo3, 12400);
[T4, X4, Y4, Z4, U4, V4, W4] = satellite(Xo4, Yo4, Zo4, Uo4, Vo4, Wo4, 12400);
[T5, X5, Y5, Z5, U5, V5, W5] = satellite(Xo5, Yo5, Zo5, Uo5, Vo5, Wo5, 12400);
[T6, X6, Y6, Z6, U6, V6, W6] = satellite(Xo6, Yo6, Zo6, Uo6, Vo6, Wo6, 12400);
h1 = altitude(XONE,YONE,ZONE);
h2 = altitude(X2,Y2,Z2);
h3 = altitude(X3,Y3,Z3);
h4 = altitude(X4,Y4,Z4);
h5 = altitude(X5,Y5,Z5);
h6 = altitude(X6,Y6,Z6);

% plotting the data
figure(2); subplot(2,1,1); hold on; grid on;
plot(TONE, altitude(XONE,YONE,ZONE),'-r', 'LineWidth', 2);
plot(T2, altitude(X2,Y2,Z2),'-b', 'LineWidth', 2);
plot(T3, altitude(X3,Y3,Z3),'-y', 'LineWidth', 2);
plot(T4, altitude(X4,Y4,Z4),'-m', 'LineWidth', 2);
plot(T5, altitude(X5,Y5,Z5),'-c', 'LineWidth', 2);
plot(T6, altitude(X6,Y6,Z6),'-black', 'LineWidth', 2);
xlim([0 16000])
ylim([4.9*10^5 5.15*10^5])
xlabel('time(s)'); ylabel('altitude(m)'); title('Altitude vs Time'); 
legend('SatID_1', 'SatID_2','SatID_3','SatID_4','SatID_5','SatID_6'); hold off;

subplot(2,1,2); hold on;grid on; 
plot(TONE, speed(UONE,VONE,WONE),'-r', 'LineWidth', 2);
plot(T2, speed(U2,V2,W2),'-b', 'LineWidth', 2);
plot(T3, speed(U3,V3,W3),'-y', 'LineWidth', 2);
plot(T4, speed(U4,V4,W4),'-m', 'LineWidth', 2);
plot(T5, speed(U5,V5,W5),'-c', 'LineWidth', 2);
plot(T6, speed(U6,V6,W6),'-black', 'LineWidth', 2);
xlim([0 16000])
ylim([7605 7625])
xlabel('time(s)'); ylabel('speed(m/s)'); title('Speed vs Time'); 
legend('SatID_1', 'SatID_2','SatID_3','SatID_4','SatID_5','SatID_6'); hold off;

% creating a structure

% finding time maximum for altitude
counter_lmax = 0;

for n = 2:12400
     if h1(n+1) < h1(n) && h1(n-1) < h1(n)
        counter_lmax = counter_lmax + 1;
        lmax1(counter_lmax)  = TONE(n);
     end
     if h2(n+1) < h2(n) && h2(n-1) < h2(n)
        counter_lmax = counter_lmax + 1;
        lmax2(counter_lmax)  = T2(n);
     end
     if h3(n+1) < h3(n) && h3(n-1) < h3(n)
        counter_lmax = counter_lmax + 1;
        lmax3(counter_lmax)  = T3(n);
     end
     if h4(n+1) < h4(n) && h4(n-1) < h4(n)
        counter_lmax = counter_lmax + 1;
        lmax4(counter_lmax)  = T4(n);
     end
     if h5(n+1) < h5(n) && h5(n-1) < h5(n)
        counter_lmax = counter_lmax + 1;
        lmax5(counter_lmax)  = T2(n);
     end
     if h6(n+1) < h6(n) && h6(n-1) < h6(n)
        counter_lmax = counter_lmax + 1;
        lmax6(counter_lmax)  = T6(n);
     end
end

% creating new lmax vectors that are without 0s
lmax11 = [];
for n = 1:length(lmax1)
    if lmax1(n) ~= 0
        lmax11 = [lmax11 lmax1(n)];
    end
end

lmax22 = [];
for n = 1:length(lmax2)
    if lmax2(n) ~= 0
        lmax22 = [lmax22 lmax2(n)];
    end
end

lmax33 = [];
for n = 1:length(lmax3)
    if lmax3(n) ~= 0
        lmax33 = [lmax33 lmax3(n)];
    end
end

lmax44 = [];
for n = 1:length(lmax4)
    if lmax4(n) ~= 0
        lmax44 = [lmax22 lmax4(n)];
    end
end

lmax55 = [];
for n = 1:length(lmax5)
    if lmax5(n) ~= 0
        lmax55 = [lmax55 lmax5(n)];
    end
end

lmax66 = [];
for n = 1:length(lmax6)
    if lmax6(n) ~= 0
        lmax66 = [lmax66 lmax6(n)];
    end
end

stat(1) = struct('sat_id',1,'final_position',[XONE(end),YONE(end),ZONE(end)],'final_velocity',[UONE(end) VONE(end) WONE(end)], 'time_lmax_altitude',lmax11,'orbital_period',lmax11(2)-lmax11(1));
stat(2) = struct('sat_id',2,'final_position',[X2(end),Y2(end),Z2(end)],'final_velocity',[U2(end) V2(end) W2(end)], 'time_lmax_altitude',lmax22,'orbital_period',lmax22(2)-lmax22(1));
stat(3) = struct('sat_id',3,'final_position',[X3(end),Y3(end),Z3(end)],'final_velocity',[U3(end) V3(end) W3(end)], 'time_lmax_altitude',lmax33,'orbital_period',lmax33(2)-lmax33(1));
stat(4) = struct('sat_id',4,'final_position',[X4(end),Y4(end),Z4(end)],'final_velocity',[U4(end) V4(end) W4(end)], 'time_lmax_altitude',lmax44,'orbital_period',lmax44(2)-lmax44(1));
stat(5) = struct('sat_id',5,'final_position',[X5(end),Y5(end),Z5(end)],'final_velocity',[U5(end) V5(end) W5(end)], 'time_lmax_altitude',lmax55,'orbital_period',lmax55(2)-lmax55(1));
stat(6) = struct('sat_id',6,'final_position',[X6(end),Y6(end),Z6(end)],'final_velocity',[U6(end) V6(end) W6(end)], 'time_lmax_altitude',lmax66,'orbital_period',lmax66(2)-lmax66(1));

% creating a file REPORT.TXT
fid = fopen('report.txt','w');
fprintf(fid,'Name: Etka Uzun\n');
fprintf(fid,'PID: A15956274\n');
fprintf(fid, 'satellite_ID, travel_distance (m), orbital_period (s)');
fprintf(fid,'\n%d, %15.9e, %15.9e, %15.9e', 1, sum(sqrt(diff(XONE).^2 + diff(YONE).^2 + diff(ZONE).^2)),lmax11(2)-lmax11(1));
fprintf(fid,'\n%d, %15.9e, %15.9e, %15.9e', 2, sum(sqrt(diff(X2).^2 + diff(Y2).^2 + diff(Z2).^2)),lmax22(2)-lmax22(1));
fprintf(fid,'\n%d, %15.9e, %15.9e, %15.9e', 3, sum(sqrt(diff(X3).^2 + diff(Y3).^2 + diff(Z3).^2)),lmax33(2)-lmax33(1));
fprintf(fid,'\n%d, %15.9e, %15.9e, %15.9e', 4, sum(sqrt(diff(X4).^2 + diff(Y4).^2 + diff(Z4).^2)),lmax44(2)-lmax44(1));
fprintf(fid,'\n%d, %15.9e, %15.9e, %15.9e', 5, sum(sqrt(diff(X5).^2 + diff(Y5).^2 + diff(Z5).^2)),lmax55(2)-lmax55(1));
fprintf(fid,'\n%d, %15.9e, %15.9e, %15.9e', 6, sum(sqrt(diff(X6).^2 + diff(Y6).^2 + diff(Z6).^2)),lmax66(2)-lmax66(1));
fclose(fid);

p2a = evalc('help read_input'); p2b ='See figure 2'; p2c = stat(1); 
p2d = stat(2); p2e = stat(3); p2f = stat(4); p2g = stat(5); p2h = stat(6);
p2i = evalc('type report.txt');
%% TASK 3

for n = 1:520
    [X0n, Y0n, Z0n, U0n, V0n, W0n] = read_input('satellite_data.txt',n);
    [Tn, Xn, Yn, Zn, Un, Vn, Wn] = satellite(X0n,Y0n,Z0n,U0n,V0n,W0n,6000);
    trajectories{n,1} = Tn;
    trajectories{n,2} = Xn;
    trajectories{n,3} = Yn;
    trajectories{n,4} = Zn;
    trajectories{n,5} = Un;
    trajectories{n,6} = Vn;
    trajectories{n,7} = Wn;
    initial_x(n) = X0n;
    initial_y(n) = Y0n;
    initial_z(n) = Z0n;
    final_x(n) = Xn(end);
    final_y(n) = Yn(end);
    final_z(n) = Zn(end);
    distance_to(n) = sqrt((X0n - (-5.5*10^6))^2 + (Y0n - (-3.9*10^6))^2 + (Z0n)^2); 
end % for loop

% plotting figure 3
figure(3); subplot(1,2,1); hold on;
[x,y,z] = sphere(50);
s = surf(Re*x/1e6,Re*y/1e6,Re*z/1e6); % create a sphere
s.CData = topo;                % set color data to topographic data
s.FaceColor = 'texturemap';    % use texture mapping
s.EdgeColor = 'none';          % remove edges
s.FaceLighting = 'gouraud';    % preferred lighting for curved surfaces
s.SpecularStrength = 0.4;      % change the strength of the reflected light
grid on; box on; axis equal;
axis(7*[-1 1 -1 1 -1 1]);  % IMPORTANT: axis unit is in 10^6 m
xlabel('x (10^6 m)'); ylabel('y (10^6 m)'); zlabel('z (10^6 m)'); title('Initial Position of the Satellites');
set(gca,'LineWidth',1,'FontSize',14, ...
        'Xtick',[-6:4:6],'Ytick',[-6:4:6],'Ztick',[-6:4:6]);
view(3);

blue_sats = [];
for n = 1:length(initial_x)
    if distance_to(n) < 2000000
        blue_xi(n) = initial_x(n);
        blue_yi(n) = initial_y(n);
        blue_zi(n) = initial_z(n);
        blue_sats = [blue_sats n];
    else
        magenta_xi(n) = initial_x(n);
        magenta_yi(n) = initial_y(n);
        magenta_zi(n) = initial_z(n);
    end % if

end % for loop

plot3(magenta_xi/1e6,magenta_yi/1e6,magenta_zi/1e6,'mo','MarkerSize',2);
plot3(blue_xi/1e6,blue_yi/1e6,blue_zi/1e6,'bo','MarkerSize',5);
hold off;

subplot(1,2,2); hold on;
[x,y,z] = sphere(50);
s = surf(Re*x/1e6,Re*y/1e6,Re*z/1e6); % create a sphere
s.CData = topo;                % set color data to topographic data
s.FaceColor = 'texturemap';    % use texture mapping
s.EdgeColor = 'none';          % remove edges
s.FaceLighting = 'gouraud';    % preferred lighting for curved surfaces
s.SpecularStrength = 0.4;      % change the strength of the reflected light
grid on; box on; axis equal;
axis(7*[-1 1 -1 1 -1 1]);  % IMPORTANT: axis unit is in 10^6 m
xlabel('x (10^6 m)'); ylabel('y (10^6 m)'); zlabel('z (10^6 m)'); title('Final Position of the Satellites');
set(gca,'LineWidth',1,'FontSize',14, ...
        'Xtick',[-6:4:6],'Ytick',[-6:4:6],'Ztick',[-6:4:6]);
view(3);

for n = 1:length(final_x)
    for m = 1:length(blue_sats)
        if blue_sats(m) == n
            blue_xf(n) = final_x(n);
            blue_yf(n) = final_y(n);
            blue_zf(n) = final_z(n);
        else
            magenta_xf(n) = final_x(n);
            magenta_yf(n) = final_y(n);
            magenta_zf(n) = final_z(n);
        end % if
    end % for loop
end % for loop

plot3(magenta_xf/1e6,magenta_yf/1e6,magenta_zf/1e6,'mo','MarkerSize',2);
plot3(blue_xf/1e6,blue_yf/1e6,blue_zf/1e6,'bo','MarkerSize',5);
hold off;

p3a ='See figure 3';
p3b = 'The satellites move fastest when they are closest to Earth.';
p3c =  'As the satellites travel away from earth, their speed decrease.';
%% SUB-FUNCTION: ALTITUDE
function h = altitude(X,Y,Z)
% ALTITUDE gives the altitude of the satellite
%   inputted the position of a satellite, the function gives its altitude

for n = 1:length(X)
    x2 = X(n)^2;
    y2 = Y(n)^2;
    z2 = Z(n)^2;
    h(n) = sqrt((x2 + y2 + z2)) - (6.37 * 10^6);
end % for loop

end % function altitude
%% SUB-FUNCTION: SPEED
function Vmag = speed(U,V,W)
% SPEED gives the speed of the satellite
%   inputted the velocity of a satellite, the function gives its speed

Vmag = sqrt(U.^2 + V.^2 + W.^2);

end % function altitude
%% THE END