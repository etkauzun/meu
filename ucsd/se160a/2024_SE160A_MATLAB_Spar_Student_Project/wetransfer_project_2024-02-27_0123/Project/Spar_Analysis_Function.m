function [name, PID, dataOut1, dataOut2] = Spar_Analysis_Function(dataIn);
% + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + +
% +
% +  SE-160A:  Aerospace Structural Analysis I
% +
% +  Project: (1) Spar Analysis
% +
% +  Title:   Spar_Analysis_Function
% +  Author:  Etka Uzun
% +  PID:     A15956274
% +  Revised: 01/29/2024
% +
% +  This function is the primary analysis function for the spar analysis 
% +  program.  All of the input data is brought into the function using 
% +  "dataIn". Next all the calculations are performed.  Finally, the 
% +  calculated results are written to "dataOut1" and "dataOut2", where 
% +  these two data sets are sent to the main program (p-code) where it is 
% +  written and plotted in an Excel output file.
% +
% +  SUMMARY OF SPAR ANALYSIS
% +
% +  A) SECTION PROPERTIES
% +     A.1) Section Properties (EA EIyy, EIzz, EIyz)
% +     A.2) Torsion Constant (GJ)
% +  B) LOADS
% +     B.1) Applied Concentrated Forces, Torque and Moment
% +     B.2) Distributed Aerodynamic Loads (lift, drag, moment)
% +     B.3) Spar Root Reactions - Axial, Shear, Torque, and Moment 
% +     B.4) Distributed Spar Internal Axial, Shear, Bend Moments, Torque
% +  C) INTERNAL STRESSES (Four Cross-Section Locations)
% +     C.1) Root Spar Axial Stress (sxx) and Shear Stress (txs)
% +     C.2) Allowable Stress, and Root Margin of Safety
% +     C.3) Distributed Spar Axial Stress (sxx)
% +     C.4) Distributed Spar Shear Stress (tau)
% +  D) SPAR TIP DISPLACEMENTS, TWIST, AND BENDING SLOPES
% +     D.1) Distributed Spar X-direction (Axial) Displacement 
% +     D.2) Distributed Spar Y-direction (Drag ) Displacement 
% +     D.3) Distributed Spar Z-direction (Lift ) Displacement 
% +     D.4) Distributed Spar Twist Rotation
% +     D.5) Distributed Spar Bending Slopes (dv/dx, dw/dx)
% +
% +  Input Data
% +     dataIn:           Packed input data (38)
% +       dataIn(01):     Number of Output Plot Data Points
% +       dataIn(02):     Spar Length (inch)
% +       dataIn(03):     Mean Cross-Section Radius (inch)
% +       dataIn(04):     Mean Cross-Section Thickness (inch)
% +       dataIn(05):     Material Density (lbf/in^3)
% +       dataIn(06):     Material Young's Modulus (Msi)
% +       dataIn(07):     Material Shear Modulus (Msi)
% +       dataIn(08):     Material Yield Strength - Tension (Ksi)
% +       dataIn(09):     Material Yield Strength - Compression (Ksi)
% +       dataIn(10):     Material Yield Strength - Shear (Ksi)
% +       dataIn(11):     Material Ultimate Strength - Tension (Ksi)
% +       dataIn(12):     Material Ultimate Strength - Compression (Ksi)
% +       dataIn(13):     Material Ultimate Strength - Shear (Ksi)
% +       dataIn(14):     Safety Factor - Yield
% +       dataIn(15):     Safety Factor - Ultimate
% +       dataIn(16):     First Load Location (x/L)
% +       dataIn(17):     Concentrated Force - X Direction (lb)
% +       dataIn(18):     Concentrated Force - Y Direction (lb)
% +       dataIn(19):     Concentrated Force - Z Direction (lb) 
% +       dataIn(20):     Concentrated Torque - About X Direction (lb-in)
% +       dataIn(21):     Concentrated Moment - About Y Direction (lb-in)
% +       dataIn(22):     Concentrated Moment - About Z Direction (lb-in)
% +       dataIn(23):     Second Load Location (x/L)
% +       dataIn(24):     Concentrated Force - X Direction (lb)
% +       dataIn(25):     Concentrated Force - Y Direction (lb)
% +       dataIn(26):     Concentrated Force - Z Direction (lb) 
% +       dataIn(27):     Concentrated Torque - About X Direction (lb-in)
% +       dataIn(28):     Concentrated Moment - About Y Direction (lb-in)
% +       dataIn(29):     Concentrated Moment - About Z Direction (lb-in)
% +       dataIn(30):     Aircraft Load Factor
% +       dataIn(31):     Drag Distribution - Constant (lb/in)
% +       dataIn(32):     Drag Distribution - rth order (lb/in)
% +       dataIn(33):     Drag Distribution - polynomial order
% +       dataIn(34):     Lift Distribution - Constant (lb/in)
% +       dataIn(35):     Lift Distribution - 2nd Order (lb/in)
% +       dataIn(36):     Lift Distribution - 4th Order (lb/in)
% +       dataIn(37):     Twist Moment Distribution - Constant (lb-in/in)
% +       dataIn(38):     Twist Moment Distribution - 1st Order (lb-in/in)
% +
% +  Output Data
% +     Name:             Name of author of this analysis function           
% +     PID:              UCSD Student ID number of author
% +     dataOut1:         Packed calculated output variable data
% +       dataOut1(01):   Axial   Stiffness EA   (lb)
% +       dataOut1(02):   Bending Stiffness EIyy (lb-in^2)   
% +       dataOut1(03):   Bending Stiffness EIzz (lb-in^2)   
% +       dataOut1(04):   Bending Stiffness EIyz (lb-in^2)   
% +       dataOut1(05):   Torsion Stiffness GJ   (lb-in^2)
% +       dataOut1(06):   Root Internal Force - X Direction (lb)
% +       dataOut1(07):   Root Internal Force - Y Direction (lb)
% +       dataOut1(08):   Root Internal Force - Z Direction (lb)
% +       dataOut1(09):   Root Internal Moment - about X Direction (lb-in)
% +       dataOut1(10):   Root Internal Moment - about Y Direction (lb-in)
% +       dataOut1(11):   Root Internal Moment - about Z Direction (lb-in)
% +       dataOut1(12):   Allowable Stress - Tension (lb/in^2)
% +       dataOut1(13):   Allowable Stress - Compression (lb/in^2)
% +       dataOut1(14):   Allowable Stress - Shear (lb/in^2)
% +       dataOut1(15):   Root Axial Stress - point A (lb/in^2)
% +       dataOut1(16):   Root Axial Stress - point B (lb/in^2)
% +       dataOut1(17):   Root Axial Stress - point C (lb/in^2)
% +       dataOut1(18):   Root Axial Stress - point D (lb/in^2)
% +       dataOut1(19):   Root Shear Stress xy - point A (lb/in^2)
% +       dataOut1(20):   Root Shear Stress xy - point B (lb/in^2)
% +       dataOut1(21):   Root Shear Stress xy - point C (lb/in^2)
% +       dataOut1(22):   Root Shear Stress xy - point D (lb/in^2)
% +       dataOut1(23):   Root Shear Stress xz - point A (lb/in^2)
% +       dataOut1(24):   Root Shear Stress xz - point B (lb/in^2)
% +       dataOut1(25):   Root Shear Stress xz - point C (lb/in^2)
% +       dataOut1(26):   Root Shear Stress xz - point D (lb/in^2)
% +       dataOut1(27):   Margin of Safety - point A
% +       dataOut1(28):   Margin of Safety - point B
% +       dataOut1(29):   Margin of Safety - point C
% +       dataOut1(30):   Margin of Safety - point D
% +       dataOut1(31):   Tip Diplacement  - X Direction (inch)
% +       dataOut1(32):   Tip Diplacement  - Y Direction (inch)
% +       dataOut1(33):   Tip Diplacement  - Z Direction (inch)
% +       dataOut1(34):   Tip Twist (degree)
% +       dataOut1(35):   Tip Bending Slope (dv/dx) (inch/inch)
% +       dataOut1(36):   Tip Bending Slope (dw/dx) (inch/inch)
% + 
% +     dataOut2:         Packed calculated output plot data
% +       column( 1):     X direction coordinate (inch)
% +       column( 2):     Applied distributed drag force (lb/in)   
% +       column( 3):     Aapplied distributed lift force (lb/in)   
% +       column( 4):     Applied distributed torque (lb-in/in)   
% +       column( 5):     Internal axial force  - Vx (lb)   
% +       column( 6):     Internal shear force  - Vy (lb)   
% +       column( 7):     Internal shear force  - Vz (lb)   
% +       column( 8):     Internal axial torque - Mx (lb-in)   
% +       column( 9):     Internal bending moment - My (lb-in)
% +       column(10):     Internal bending moment - Mz (lb-in) 
% +       column(11):     Axial Stress - point A (lb/in^2) 
% +       column(12):     Axial Stress - point B (lb/in^2) 
% +       column(13):     Axial Stress - point C (lb/in^2) 
% +       column(14):     Axial Stress - point D (lb/in^2) 
% +       column(15):     Shear Stress - point A (lb/in^2) 
% +       column(16):     Shear Stress - point B (lb/in^2) 
% +       column(17):     Shear Stress - point C (lb/in^2) 
% +       column(18):     Shear Stress - point D (lb/in^2)
% +       column(19):     Displacement - X Direction (inch) 
% +       column(20):     Displacement - Y Direction (inch) 
% +       column(21):     Displacement - z Direction (inch) 
% +       column(22):     Twist (degree)
% +       column(23):     Bending Slope (dv/dx) (inch/inch)
% +       column(24):     Bending Slope (dw/dx) (inch/inch)
% +
% + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + +
%%
% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
% .  SECTION (#1): Unpack Input Data Array and Write User Name and PID
% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
   disp('     (1) Unpack Input Data and Write User Name and PID')

   nplot = dataIn( 1);   % number of output plot data points
   Lo    = dataIn( 2);   % Spar Length (inch)
   Ro    = dataIn( 3);   % Mean Cross-Section Radius (inch)
   to    = dataIn( 4);   % Mean Cross-Section Thickness (inch)
   rho   = dataIn( 5);   % Material Density (lbf/in^3)
   Eo    = dataIn( 6);   % Material Young's Modulus (Msi)
   Go    = dataIn( 7);   % Material Shear Modulus (Msi)
   Syt   = dataIn( 8);   % Material Yield Strength - Tension (Ksi)
   Syc   = dataIn( 9);   % Material Yield Strength - Compression (Ksi)
   Sys   = dataIn(10);   % Material Yield Strength - Shear (Ksi)
   Sut   = dataIn(11);   % Material Ultimate Strength - Tension (Ksi)
   Suc   = dataIn(12);   % Material Ultimate Strength - Compression (Ksi)
   Sus   = dataIn(13);   % Material Ultimate Strength - Shear (Ksi)
   SFy   = dataIn(14);   % Safety Factor - Yield
   SFu   = dataIn(15);   % Safety Factor - Ultimate
   x1L   = dataIn(16);   % First Load Location (x/L)
   Fx1   = dataIn(17);   % Concentrated Force - X Direction (lb)
   Fy1   = dataIn(18);   % Concentrated Force - Y Direction (lb)
   Fz1   = dataIn(19);   % Concentrated Force - Z Direction (lb)   
   Mx1   = dataIn(20);   % Concentrated Torque - About X Direction (lb-in)
   My1   = dataIn(21);   % Concentrated Moment - About Y Direction (lb-in)
   Mz1   = dataIn(22);   % Concentrated Moment - About Z Direction (lb-in)
   x2L   = dataIn(23);   % Second Load Location (x/L)
   Fx2   = dataIn(24);   % Concentrated Force - X Direction (lb)
   Fy2   = dataIn(25);   % Concentrated Force - Y Direction (lb)
   Fz2   = dataIn(26);   % Concentrated Force - Z Direction (lb)   
   Mx2   = dataIn(27);   % Concentrated Torque - About X Direction (lb-in)
   My2   = dataIn(28);   % Concentrated Moment - About Y Direction (lb-in)
   Mz2   = dataIn(29);   % Concentrated Moment - About Z Direction (lb-in)
   LF    = dataIn(30);   % Aircraft Load Factor
   py0   = dataIn(31);   % Drag Distribution - Constant (lb/in)
   pyr   = dataIn(32);   % Drag Distribution - rth order (lb/in)
   rth   = dataIn(33);   % Drag Distribution - polynomial order
   pz0   = dataIn(34);   % Lift Distribution - Constant (lb/in)
   pz2   = dataIn(35);   % Lift Distribution - 2nd Order (lb/in)
   pz4   = dataIn(36);   % Lift Distribution - 4th Order (lb/in)
   mx0   = dataIn(37);   % Twist Moment Distribution - Constant (lb-in/in)
   mx1   = dataIn(38);   % Twist Moment Distribution - 1st Order (lb-in/in)

% Define author name and PID (Write in your name and PID)    
   name  = {'Etka Uzun'};
   PID   = {'A15956274'};
%% 
% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
% .  SECTION (#2): Calculate the Section Properties
% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
   disp('     (2) Calculate the Section Properties')

% Find EA EIyy, EIzz, EIyz, and GJ

% EA: Axial Stiffness  
A = 2 * pi * Ro * to; % area
Eo = Eo * 10^6; % converting Eo from Msi to psi
EA = Eo * A; 

% EIyy, EIzz, EIyz: Bending Stiffness
    % Note Ro is the middle line within the annulus
Od = Ro + (to/2); % outer diameter
Id = Ro - (to/2); % inner diameter
Iyy = (pi/4) * (Od^4 - Id^4); % moment of inertia
EIyy = Eo * Iyy;
Izz = Iyy; % moment of inertia
EIzz = Eo * Izz;
Iyz = 0; % product of inertia
EIyz = Eo * Iyz;

% GJ: Torsion Stiffness
Go = Go * 10^6; % converting Go from Msi to psi
J = (pi/2) * (Od^4 - Id^4);
GJ = Go * J;
%%
% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
% .  SECTION (#3): Calculate Root Internal Stress Resultants for Applied
% .                Concentrated Forces and Applied Aerodynamic Loads
% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
   disp('     (3) Calculate Root Stress Resultants for Applied Concentrated Loads and Aero Loads')

% Find
     % Vxo: Root Internal Force - X Direction (lb)
     % Vyo: Root Internal Force - Y Direction (lb)
     % Vzo: Root Internal Force - Z Direction (lb)
     % Mxo: Root Internal Moment - about X Direction (lb-in)
     % Myo: Root Internal Moment - about Y Direction (lb-in)
     % Mzo: Root Internal Moment - about Z Direction (lb-in)

Wn = rho*Lo*A*LF % defining weight with load factor
% Summing forces in x,y,z directions for forces
Vxo = Fx1 + Fx2;
Vyo = Fy1 + Fy2 + (py0*Lo) + (pyr* Lo/(rth+1)); % includes integration of Py
Vzo = Fz1 + Fz2 + (pz0*Lo) + (pz2*Lo/3) + (pz4*Lo/5) - Wn; % includes integration of Pz & weight with load factor

% Calculating the moments in x,y,z directions
Mxo = Mx1 + Mx2 + (mx0*Lo) + (mx1*Lo/2); % includes integration of mx
Myo = My1 + My2 + (Wn*Lo/2) - (pz0*(Lo^2)/2) - (pz2*(Lo^2)/4) - (pz4*(Lo^2)/6); % includes weight and integration of Pz*x
Mzo = Mz1 + Mz2 + (py0*(Lo^2)/2) + (pyr*(Lo^2)/(rth+2)); % includes integration of Py*x
%%
% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
% .  SECTION (#4): Calculate Allowable Properties, Root Stresses and Margin
% .                of Safety
% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
   disp('     (4) Calculate Allowable Properties, Root Stresses, and Margins of Safety')

% Find
    % S_allow_T: Allowable Stress - Tension (Ksi)
    % S_allow_C: Allowable Stress - Compression (Ksi)
    % S_allow_S: Allowable Stress - Shear (Ksi)

if Syt > 0
    S_allow_T = min((Syt/SFy), (Sut/SFu));
end

if Syt < 0
     S_allow_T = max((Syt/SFy), (Sut/SFu));
end % if 
if S_allow_T < 0 
    S_allow_T = S_allow_T * -1;
end

if Syc > 0
    S_allow_C = min((Syc/SFy), (Suc/SFu));
end

if Syc< 0
     S_allow_C = max((Syc/SFy), (Suc/SFu));
end % if 

if S_allow_C > 0 
    S_allow_C = S_allow_C * -1;
end

if Sys > 0
    S_allow_S = min((Sys/SFy), (Sus/SFu));
end

if Sys < 0
     S_allow_S = max((Sys/SFy), (Sus/SFu));
end % if 

% S_allow_T = min((Syt/SFy), (Sut/SFu));
% S_allow_C = max((Syc/SFy), (Suc/SFu));
% S_allow_S = min((Sys/SFy), (Sus/SFu));

% Find
    % Sxxo_A:    Root Axial Stress - point A (Ksi)
    % Sxxo_B:    Root Axial Stress - point B (Ksi)
    % Sxxo_C:    Root Axial Stress - point C (Ksi)
    % Sxxo_D:    Root Axial Stress - point D (Ksi)

Sxxo_A = (10^-3)*Myo*Od/Iyy;
Sxxo_B = (10^-3)*Mzo*Od/Izz;
Sxxo_C = -1 * Sxxo_A; % radius is negative
Sxxo_D = -1 * Sxxo_B; % radius is negative

% Find
    % Txyo_A:    Root Shear Stress xy - point A (ksi)   
    % Txyo_B:    Root Shear Stress xy - point B (ksi)
    % Txyo_C:    Root Shear Stress xy - point C (ksi)
    % Txyo_D:    Root Shear Stress xy - point D (ksi)

Txyo_A = (10^-3) * ((Vyo/(A/2)) - (Mxo*Od/J));
Txyo_B = 0; 
Txyo_C = (10^-3) * ((Vyo/(A/2)) + (Mxo*Od/J));
Txyo_D = 0;

% Find
    % Txzo_A:    Root Shear Stress xz - point A (ksi)
    % Txzo_B:    Root Shear Stress xz - point B (ksi)
    % Txzo_C:    Root Shear Stress xz - point C (ksi)
    % Txzo_D:    Root Shear Stress xz - point D (ksi)

Txzo_A = 0;
Txzo_B = (10^-3) * ((Vzo/(A/2)) - (Mxo*Od/J));
Txzo_C = 0;
Txzo_D = (10^-3) * ((Vzo/(A/2)) + (Mxo*Od/J));

% Find    
    % MS_A:      Margin of Safety - point A
    % MS_B:      Margin of Safety - point B
    % MS_C:      Margin of Safety - point C
    % MS_D:      Margin of Safety - point D

MS_A = ( S_allow_T / sqrt( (Sxxo_A^2 + (3*Txyo_A^2)) ) ) - 1; 
MS_B = ( S_allow_T / sqrt( (Sxxo_B^2 + (3*Txzo_B^2)) ) ) - 1;
MS_C = ( S_allow_T / sqrt( (Sxxo_C^2 + (3*Txyo_C^2)) ) ) - 1; 
MS_D = ( S_allow_T / sqrt( (Sxxo_D^2 + (3*Txzo_D^2)) ) ) - 1; 

% Find
    % Disp_X(nplot):    Tip Diplacement - X Direction (inch)
    % Disp_Y(nplot):    Tip Diplacement - Y Direction (inch)
    % Disp_Z(nplot):    Tip Diplacement - Z Direction (inch)

% Find
    % Twist(nplot):     Tip Twist (degree)
    % DvDx(nplot):      Tip Bending Slope (dv/dx) (inch/inch)
    % DwDx(nplot):      Tip Bending Slope (dw/dx) (inch/inch)


%%
% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
% .  SECTION (#5): Calculate the Data Arrays for Plotting
% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
   disp('     (5) Calculate the Data Arrays for Future Plotting')

x = linspace(0, Lo, nplot); % creating the x-location array
py = py0 + (pyr * (x/Lo).^rth);
% figure(1); plot(x,py)
pz = pz0 + (pz2 * (x/Lo).^2) + (pz4*(x/Lo).^4);
% figure(2); plot(x,pz)
mx = mx0 + (mx1 * (x/Lo).^2);
% figure(3); plot(x, mx)
Vx = ((Fx1*(x<=x1L)) + Fx2*(x<=x2L)) .* x;
% figure(4); plot(x, Vx)
Vy = (Fy1*(x<=x1L)) + Fy2*(x<=x2L) + (py0.*(Lo-x)) + ( pyr*((Lo/(rth+1)) - (x.^(rth+1)/((rth+1)*Lo^rth))) );
% figure(5); plot(x,Vy)
Vz = pz0.*(Lo-x) + pz2.*((Lo/3)-(x.^3./(3*Lo^2))) + pz4.*((Lo/5)-(x.^5./(5*Lo^4))) + (Fz1*(x<=x1L)) + Fz2*(x<=x2L) - Wn.*(x(end)/Lo - x./Lo);
% figure(6); plot(x,Vz)
Mx = Mx1*(x<=x1L) + Mx2*(x<=x2L) + mx0.*(Lo-x) + mx1.*(((Lo^2) / (2*Lo)) - ((x.^2)/(2*Lo)));
% figure(7); plot(x, Mx);
My =  My1.*(x<=x1L) + My2.*(x<=x2L) + pz0*((Lo.*x)-(Lo^2)) + pz2*(((Lo.*x)-(Lo^2))/3) + pz4*(((Lo.*x)-(Lo^2))/5) + (Wn/Lo)*(Lo^2 - Lo.*x) + pz0*(((Lo^2)-(x.^2))/2) + pz2*(((Lo^4)-(x.^4))/(12*Lo^2)) + pz4*(((Lo^6)-(x.^6))/(30*Lo^4)) - (Wn/Lo)*(((Lo^2)-(x.^2))/2);
% figure(8); plot(x, My)
Mz = Mz1.*(x<=x1L) + Mz2.*(x<=x2L) + (Lo-x).*((py0*Lo)+(pyr*Lo^(rth+1)/((rth+1)*(Lo^rth)))) + py0*(x.^2/2) - py0*((Lo^2)/2) + (pyr*Lo^(-rth)/((rth+1)*(rth+2)))*((x.^(rth+2))) - (pyr*Lo^(-rth)/((rth+1)*(rth+2)))*((Lo^(rth+2)));
% figure(9); plot(x, Mz)
Sxx_A = Od * My / Iyy;
Sxx_B = Od * Mz / Izz;
Sxx_C = -Od * My / Iyy;
Sxx_D = -Od * Mz / Izz;
% figure(10); hold on; plot(x, Sxx_A); plot(x, Sxx_B);plot(x, Sxx_C);plot(x, Sxx_D); hold off;
Tau_A = 10^-3 * (Vy/(A/2) - (Mx*Od/J));
Tau_B = 10^-3 * (Vz/(A/2) - (Mx*Od/J));
Tau_C = 10^-3 * (Vy/(A/2) + (Mx*Od/J));
Tau_D = 10^-3 * (Vz/(A/2) + (Mx*Od/J));
% figure(11); hold on; plot(x, Txyo_A); plot(x, Txyo_B);plot(x, Txyo_C);plot(x, Txyo_D); hold off;
Disp_X = ((Fx1*(x<=x1L).*x + Fx2*(x<=x2L).*x)/A) / (Eo);
% Disp_X(nplot)
% figure(12); plot(x, Disp_X)
Disp_Y = (Fy1*(x<=x1L).^2/2 + Fy2*(x<=x2L).^2/2 + Mzo*(x.^2)/2 - Vyo*(x.^3)/6 + (py0*x.^4/24) + (pyr*x.^(rth+4)/((Lo^rth)*(rth+1)*(rth+2)*(rth+3)*(rth+4)))) / (Eo*Izz);
% Disp_Y(nplot)
% figure(13); plot(x, Disp_Y)
Disp_Z = (-Fz1*(x<=x1L).^2/2 - Fz2*(x<=x2L).^2/2 - (Myo*(x.^2)/2) - (Vzo*(x.^3)/6) - (LF*rho*A*(x.^4)/24) + (pz0*x.^4/24) + (pz2*x.^6/(360*Lo^2)) + (pz4*x.^8/(1680*Lo^4))) / (Eo*Iyy);
% Disp_Z(nplot)
% figure(14); plot(x,Disp_Z)
Twist = ((Mxo.*x - mx0.*(x.^2)/2 - mx1.*(x.^3)/(6*Lo)) / (GJ) ) *(180/pi);
% Twist(nplot)
% figure(15); plot(x, Twist)
DvDx = (Fy1.*(x<=x1L) + Fy2.*(x<=x2L) + Mzo.*x - Vyo*(x.^2)/2 + (py0*x.^3/6) + (pyr*x.^(rth+3)/((Lo^rth)*(rth+1)*(rth+2)*(rth+3)))) / (Eo*Izz);
% DvDx(nplot)
% figure(16); plot(x, DvDx)
DwDx = (-Fz1.*(x<=x1L) - Fz2.*(x<=x2L) - (Myo.*x) - (Vzo*(x.^2)/2) - (LF*rho*A*(x.^3)/6) + (pz0*x.^3/6) + (pz2*x.^5/(60*Lo^2)) + (pz4*x.^7/(210*Lo^4))) / (Eo*Iyy);
% DwDx(nplot)
% figure(17); plot(x, DwDx)

SW_Def = (Wn * Lo^3)/(8*EIyy)
%%
% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
% .  SECTION (#6): Pack Calculated Data into the "dataOut1" Array size: (36)
% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
   disp('     (6) Pack the Calculated Data into Array: dataOut1')

     dataOut1(01) = EA;              % Axial   Stiffness (lb)
     dataOut1(02) = EIyy;            % Bending Stiffness (lb-in^2)   
     dataOut1(03) = EIzz;            % Bending Stiffness (lb-in^2)   
     dataOut1(04) = EIyz;            % Bending Stiffness (lb-in^2)   
     dataOut1(05) = GJ;              % Torsion Stiffness (lb-in^2)
     dataOut1(06) = Vxo;             % Root Internal Force - X Direction (lb)
     dataOut1(07) = Vyo;             % Root Internal Force - Y Direction (lb)
     dataOut1(08) = Vzo;             % Root Internal Force - Z Direction (lb)
     dataOut1(09) = Mxo;             % Root Internal Moment - about X Direction (lb-in)
     dataOut1(10) = Myo;             % Root Internal Moment - about Y Direction (lb-in)
     dataOut1(11) = Mzo;             % Root Internal Moment - about Z Direction (lb-in)
     dataOut1(12) = S_allow_T;       % Allowable Stress - Tension (Ksi)
     dataOut1(13) = S_allow_C;       % Allowable Stress - Compression (Ksi)
     dataOut1(14) = S_allow_S;       % Allowable Stress - Shear (Ksi)
     dataOut1(15) = Sxxo_A;          % Root Axial Stress - point A (Ksi)
     dataOut1(16) = Sxxo_B;          % Root Axial Stress - point B (Ksi)
     dataOut1(17) = Sxxo_C;          % Root Axial Stress - point C (Ksi)
     dataOut1(18) = Sxxo_D;          % Root Axial Stress - point D (Ksi)
     dataOut1(19) = Txyo_A;          % Root Shear Stress xy - point A (ksi)   
     dataOut1(20) = Txyo_B;          % Root Shear Stress xy - point B (ksi)
     dataOut1(21) = Txyo_C;          % Root Shear Stress xy - point C (ksi)
     dataOut1(22) = Txyo_D;          % Root Shear Stress xy - point D (ksi)
     dataOut1(23) = Txzo_A;          % Root Shear Stress xz - point A (ksi)
     dataOut1(24) = Txzo_B;          % Root Shear Stress xz - point B (ksi)
     dataOut1(25) = Txzo_C;          % Root Shear Stress xz - point C (ksi)
     dataOut1(26) = Txzo_D;          % Root Shear Stress xz - point D (ksi)
     dataOut1(27) = MS_A;            % Margin of Safety - point A
     dataOut1(28) = MS_B;            % Margin of Safety - point B
     dataOut1(29) = MS_C;            % Margin of Safety - point C
     dataOut1(30) = MS_D;            % Margin of Safety - point D
     dataOut1(31) = Disp_X(nplot);   % Tip Diplacement - X Direction (inch)
     dataOut1(32) = Disp_Y(nplot);   % Tip Diplacement - Y Direction (inch)
     dataOut1(33) = Disp_Z(nplot);   % Tip Diplacement - Z Direction (inch)
     dataOut1(34) = Twist(nplot);    % Tip Twist (degree)
     dataOut1(35) = DvDx(nplot);     % Tip Bending Slope (dv/dx) (inch/inch)
     dataOut1(36) = DwDx(nplot);     % Tip Bending Slope (dw/dx) (inch/inch)

%%
% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
% .  SECTION (#7): Pack the plot data arrays into "dataOut2" 
% .                matrix size: (nplot,23)  
% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
   disp('     (7) Pack the Calculated Plot Data into Array: dataOut2')

   for i = 1:nplot;
     dataOut2(i, 1) = x(i);          % x-location (inch)
     dataOut2(i, 2) = py(i);         % drag force (lb/in)
     dataOut2(i, 3) = pz(i);         % lift force (lb/in)
     dataOut2(i, 4) = mx(i);         % distributed torque (lb-in/in)
     dataOut2(i, 5) = Vx(i);         % Internal axial force - Vx (lb)
     dataOut2(i, 6) = Vy(i);         % Internal shear force - Vy (lb)
     dataOut2(i, 7) = Vz(i);         % Internal shear force - Vz (lb)
     dataOut2(i, 8) = Mx(i);         % Internal axial force - Mx (lb-in)
     dataOut2(i, 9) = My(i);         % Internal shear force - My (lb-in)
     dataOut2(i,10) = Mz(i);         % Internal shear force - Mz (lb-in)
     dataOut2(i,11) = Sxx_A(i);      % Axial Stress - Point A (Ksi)
     dataOut2(i,12) = Sxx_B(i);      % Axial Stress - Point B (Ksi)
     dataOut2(i,13) = Sxx_C(i);      % Axial Stress - Point C (Ksi)
     dataOut2(i,14) = Sxx_D(i);      % Axial Stress - Point D (Ksi)
     dataOut2(i,15) = Tau_A(i);      % Shear Stress - Point A (Ksi)
     dataOut2(i,16) = Tau_B(i);      % Shear Stress - Point B (Ksi)
     dataOut2(i,17) = Tau_C(i);      % Shear Stress - Point C (Ksi)
     dataOut2(i,18) = Tau_D(i);      % Shear Stress - Point D (Ksi)
     dataOut2(i,19) = Disp_X(i);     % Displacement - X Direction (inch)
     dataOut2(i,20) = Disp_Y(i);     % Displacement - Y Direction (inch)
     dataOut2(i,21) = Disp_Z(i);     % Displacement - Z Direction (inch)
     dataOut2(i,22) = Twist(i);      % Spar Twist (degree)
     dataOut2(i,23) = DvDx(i);       % Bending Slope (dv/dx) (inch/inch)
     dataOut2(i,24) = DwDx(i);       % Bending Slope (dw/dx) (inch/inch)
   
   end;
   
end

%  End of Function: SE160A_1_sparAnalysis
%  ------------------------------------------------------------------------

