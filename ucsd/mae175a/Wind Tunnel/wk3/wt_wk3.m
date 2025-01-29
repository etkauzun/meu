% MAE 175A WT Experiment Wk3 Calculations
clear all; close all; clc;
%% v = 20 m/s

% Importing the 20 (m/s) WT runs & obtaining Cl,Cd wrt AoA
v20_dn4 = uncouplate(readmatrix('20_-4', 'Delimiter', '\t'));
v20_dn2 = uncouplate(readmatrix('20_-2', 'Delimiter', '\t'));
v20_d0 = uncouplate(readmatrix('20_0', 'Delimiter', '\t'));
v20_d2 = uncouplate(readmatrix('20_2', 'Delimiter', '\t'));
v20_d4 = uncouplate(readmatrix('20_4', 'Delimiter', '\t'));
v20_d6 = uncouplate(readmatrix('20_6', 'Delimiter', '\t'));
v20_d8 = uncouplate(readmatrix('20_8', 'Delimiter', '\t'));
v20_d10 = uncouplate(readmatrix('20_10', 'Delimiter', '\t'));
v20_d12 = uncouplate(readmatrix('20_12', 'Delimiter', '\t'));
v20_d14 = uncouplate(readmatrix('20_14', 'Delimiter', '\t'));
v20_d16 = uncouplate(readmatrix('20_16', 'Delimiter', '\t'));
v20_d18 = uncouplate(readmatrix('20_18', 'Delimiter', '\t'));
v20_d20 = uncouplate(readmatrix('20_20', 'Delimiter', '\t'));

% Create a vector for AoA, Cl, Cd, Cm
v20_vec = zeros(13,4); % pre-allocating
v20_vec(1,:) = v20_dn4;
v20_vec(2,:) = v20_dn2;
v20_vec(3,:) = v20_d0;
v20_vec(4,:) = v20_d2;
v20_vec(5,:) = v20_d4;
v20_vec(6,:) = v20_d6;
v20_vec(7,:) = v20_d8;
v20_vec(8,:) = v20_d10;
v20_vec(9,:) = v20_d12;
v20_vec(10,:) = v20_d14;
v20_vec(11,:) = v20_d16;
v20_vec(12,:) = v20_d18;
v20_vec(13,:) = v20_d20;

%% v = 35 m/s

% Importing the 35 (m/s) WT runs & obtaining Cl,Cd wrt AoA
v35_dn4 = uncouplate(readmatrix('35_-4', 'Delimiter', '\t'));
v35_dn2 = uncouplate(readmatrix('35_-2', 'Delimiter', '\t'));
v35_d0 = uncouplate(readmatrix('35_0', 'Delimiter', '\t'));
v35_d2 = uncouplate(readmatrix('35_2', 'Delimiter', '\t'));
v35_d4 = uncouplate(readmatrix('35_4', 'Delimiter', '\t'));
v35_d6 = uncouplate(readmatrix('35_6', 'Delimiter', '\t'));
v35_d8 = uncouplate(readmatrix('35_8', 'Delimiter', '\t'));
v35_d10 = uncouplate(readmatrix('35_10', 'Delimiter', '\t'));
v35_d12 = uncouplate(readmatrix('35_12', 'Delimiter', '\t'));
v35_d14 = uncouplate(readmatrix('35_14', 'Delimiter', '\t'));
v35_d16 = uncouplate(readmatrix('35_16', 'Delimiter', '\t'));

% Create a vector for AoA, Cl, Cd, Cm
v35_vec = zeros(11,4); % pre-allocating
v35_vec(1,:) = v35_dn4;
v35_vec(2,:) = v35_dn2;
v35_vec(3,:) = v35_d0;
v35_vec(4,:) = v35_d2;
v35_vec(5,:) = v35_d4;
v35_vec(6,:) = v35_d6;
v35_vec(7,:) = v35_d8;
v35_vec(8,:) = v35_d10;
v35_vec(9,:) = v35_d12;
v35_vec(10,:) = v35_d14;
v35_vec(11,:) = v35_d16;

%% v = 50 m/s

% Importing the 50 (m/s) WT runs & obtaining Cl,Cd wrt AoA
v50_dn4 = uncouplate(readmatrix('50_-4', 'Delimiter', '\t'));
v50_dn2 = uncouplate(readmatrix('50_-2', 'Delimiter', '\t'));
v50_d0 = uncouplate(readmatrix('50_null', 'Delimiter', '\t'));
v50_d2 = uncouplate(readmatrix('50_2', 'Delimiter', '\t'));
v50_d4 = uncouplate(readmatrix('50_4', 'Delimiter', '\t'));
v50_d6 = uncouplate(readmatrix('50_6', 'Delimiter', '\t'));
v50_d8 = uncouplate(readmatrix('50_8', 'Delimiter', '\t'));
v50_d10 = uncouplate(readmatrix('50_10', 'Delimiter', '\t'));
v50_d12 = uncouplate(readmatrix('50_12', 'Delimiter', '\t'));
v50_d14 = uncouplate(readmatrix('50_14', 'Delimiter', '\t'));
v50_stall = uncouplate(readmatrix('50_stall', 'Delimiter', '\t'));
v50_d165 = uncouplate(readmatrix('50_165', 'Delimiter', '\t'));
v50_d185 = uncouplate(readmatrix('50_185', 'Delimiter', '\t'));

% Create a vector for AoA, Cl, Cd, Cm
v50_vec = zeros(13,4); % pre-allocating
v50_vec(1,:) = v50_dn4;
v50_vec(2,:) = v50_dn2;
v50_vec(3,:) = v50_d0;
v50_vec(4,:) = v50_d2;
v50_vec(5,:) = v50_d4;
v50_vec(6,:) = v50_d6;
v50_vec(7,:) = v50_d8;
v50_vec(8,:) = v50_d10;
v50_vec(9,:) = v50_d12;
v50_vec(10,:) = v50_d14;
v50_vec(11,:) = v50_stall;
v50_vec(12,:) = v50_d165;
v50_vec(13,:) = v50_d185;
%% Plotting 
plotData(v20_vec, v35_vec, v50_vec);

%% Functions

function plotData(x,y,z)
    % PLOTDATA plots AoA vs Cl & Cd
    
    AoA_x = x(:,1)'; Cl_x = x(:,2)'; Cd_x = x(:,3)'; Cm_x = x(:,4)';
    AoA_y = y(:,1)'; Cl_y = y(:,2)'; Cd_y = y(:,3)'; Cm_y = y(:,4)';
    AoA_z = z(:,1)'; Cl_z = z(:,2)'; Cd_z = z(:,3)'; Cm_z = z(:,4)';

    figure; hold on; % Cl vs AoA
    plot(AoA_x, Cl_x,"Color",'b',"LineWidth",2);
    plot(AoA_y, Cl_y,"Color",'g',"LineWidth",2);
    plot(AoA_z, Cl_z,"Color",'r',"LineWidth",2);
    xlabel('AoA [deg]'); ylabel('Cl'); 
    legend('V = 20 m/s', 'V = 35 m/s', 'V = 50 m/s'); 
    title('Cl vs AoA'); grid on;

    figure; hold on; % Cd vs AoA
    plot(AoA_x, Cd_x,"Color",'b',"LineWidth",2);
    plot(AoA_y, Cd_y,"Color",'g',"LineWidth",2);
    plot(AoA_z, Cd_z,"Color",'r',"LineWidth",2);    
    xlabel('AoA [deg]'); ylabel('Cd'); title('Cd vs AoA');
    legend('V = 20 m/s', 'V = 35 m/s', 'V = 50 m/s'); 
    grid on;

    figure; hold on; % Cl/Cd vs AoA
    plot(AoA_x, (Cl_x ./ Cd_x),"Color",'b',"LineWidth",2);
    plot(AoA_y, (Cl_y ./ Cd_y),"Color",'g',"LineWidth",2);
    plot(AoA_z, (Cl_z ./ Cd_z),"Color",'r',"LineWidth",2);    
    xlabel('AoA [deg]'); ylabel('Cl/Cd'); title('Cl/Cd vs AoA');
    legend('V = 20 m/s', 'V = 35 m/s', 'V = 50 m/s'); 
    grid on;

    figure; hold on; % Cl/Cd vs AoA
    plot(AoA_x, Cm_x,"Color",'b',"LineWidth",2);
    plot(AoA_y, Cm_y,"Color",'g',"LineWidth",2);
    plot(AoA_z, Cm_z,"Color",'r',"LineWidth",2);      
    xlabel('AoA [deg]'); ylabel('CMc/4'); title('CMc/4 vs AoA');
    legend('V = 20 m/s', 'V = 35 m/s', 'V = 50 m/s'); 
    grid on;
end

function vec = uncouplate(x)
    % This function removes the second row in the raw data. Correct the raw
    % data by substracting the null data & changing to SI units. Calculates
    % the uncoupling forces, Lift, Drag, Cl, and Cd.

    % Reading the null data & converting to SI units
    nullData = readmatrix('null', 'Delimiter', '\t');
    nullData(2,:) = []; % Removing the second row in the data
    nullData(1) = nullData(1) * 249.0889; % Pitot from inH20 to Pa
    % nullData(2) = deg2rad(nullData(2)); % AoA from deg to rad
    nullData(3) = nullData(3) * (0.6796) - 0.8471; % Flow % to m/s
    nullData(4) = nullData(4) * 0.113; % Pitch from lb-in to Nm
    nullData(5) = nullData(5) * 4.448; % Axial from lb to N
    nullData(6) = nullData(6) * 4.448; % Normal from lb to N

    % Input vector SI unit conversion
    x(2,:) = []; % Removing the second row
    x(1) = x(1) * 249.0889; % Pitot from inH20 to Pa
    % x(2) = deg2rad(x(2)); % AoA from deg to rad
    x(3) = x(3) * (0.6796) - 0.8471; % Flow % to m/s
    x(4) = x(4) *  0.113; % Pitch from lb-in to Nm
    x(5) = x(5) * 4.448; % Axial from lb to N
    x(6) = x(6) * 4.448; % Normal from lb to N
    
    % Correction
    y = x - (nullData); % NO ABSOLUTE VALUE
    
    % Uncoupling
    Nprime = y(6); Aprime = y(5); Pprime = y(4); % Obtaining the forces

    N = (Nprime * 0.9504) - (Aprime * 0.0082) - (Pprime * 0.0161);
    A = (Nprime * 0.0608) + (Aprime * 0.5912);
    P = ((-1) * Nprime * 0.1336) + (Aprime * 0.0119) + (Pprime * 1.182);

    % Lift & Drag
    L = N * cosd(y(2)) - A * sind(y(2));
    D = N * sind(y(2)) + A * cosd(y(2));
    
    c = 2.452 / 39.37; % inch to m
    d = (c * 3/4) + (2.98/39.37) - (3.49/39.37); % distance between quarter chord and balance center in m
    Mc4 = P - N * d;

    % Cl & Cd
    rho = 1.1963;
    qinf = (y(3)^2) * rho / 2;
    Cl = L / (qinf * c); 
    Cd = D / (qinf * c);
    Cmc4 = Mc4 / (qinf * c^2);

    % Output
    AoA = y(2);
    % LD = [L, D, Mc4];
    vec = [AoA, Cl, Cd, Cmc4];
end