function [name, PID, dataOut1, dataOut2] = Wing_Analysis_Function(dataIn);
% + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + +
% +
% +  SE-160A:  Aerospace Structural Analysis I
% +
% +  Project: (2) Wing Analysis
% +
% +  Title:   Wing_Analysis_Function
% +  Author:  Etka Uzun
% +  PID:     A15956274
% +  Revised: 02/25/2024
% +
% +  This function is the primary analysis function for the wing analysis 
% +  program.  All of the input data is brought into the function using 
% +  "dataIn". Next all the calculations are performed.  Finally, the 
% +  calculated results are written to "dataOut1" and "dataOut2", where 
% +  these two data sets are sent to the main program (p-code) where it is 
% +  written and plotted in an Excel output file.
% +
% +  SUMMARY OF WING ANALYSIS
% +
% +  A) SECTION PROPERTIES
% +     A.1) Modulus Weighted Section Properties (yc, zc, EA, EIyy, EIzz, EIyz)
% +     A.2) Torsion Constant (GJ)
% +     A.3) Shear Center Location (ysc, zsc)
% +     A.4) Total Half Span Wing Weight (lb)
% +
% +  B) LOADS
% +     B.1) Distributed Aerodynamic Loads (lift, drag, moment)
% +     B.2) Wing Root Reactions - Shear, Torque, and Moment 
% +     B.3) Distributed Wing Internal Shear, Bend Moments, Torque
% +
% +  C) INTERNAL STRESSES
% +     C.1) Wing Root Axial Stress (sxx) and Shear Stress (txs)
% +     C.2) Allowable Stress, and Root Margin of Safety
% +     C.3) Distributed Wing Axial Stress (sxx) Plot
% +     C.4) Distributed Wing Shear Stress (tau) Plot
% +
% +  D) WING TIP DISPLACEMENTS, TWIST, AND BENDING SLOPES
% +     D.1) Distributed Wing Y-direction (Drag ) Displacement 
% +     D.2) Distributed Wing Z-direction (Lift ) Displacement 
% +     D.3) Distributed Wing Twist Rotation
% +     D.4) Distributed Wing Bending Slopes (dv/dx, dw/dx)
% +
% +  Input Data Array: dataIn (65)
% +     dataIn(01):     Number of Output Plot Data Points
% +     dataIn(02):     Wing Length (inch)
% +     dataIn(03):     Wing Chord (inch)
% +     dataIn(04):     Maximum Wing Thickness (inch)
% +     dataIn(05):     Secondary Structure Added Wing Weight (%)
% +     dataIn(06):     Wing Skin Thickness (inch)
% +     dataIn(07):     Wing Skin Weight Density (lb/in^3)
% +     dataIn(08):     Skin Material Shear Modulus (Msi)
% +     dataIn(09):     Skin Material Yield Strength - Shear (Ksi)
% +     dataIn(10):     Skin Material Ultimate Strength - Shear (Ksi)
% +     dataIn(11):     Stringer (#1) y-location (inch)
% +     dataIn(12):     Stringer (#1) Cross-Section Area (inch^2)
% +     dataIn(13):     Stringer (#1) Iyy Inertia about y-axis (inch^4)
% +     dataIn(14):     Stringer (#1) Izz Inertia about z-axis (inch^4)
% +     dataIn(15):     Stringer (#1) Iyz Product of Inertia (inch^4)
% +     dataIn(16):     Stringer (#1) Weight Density (lb/in^3)
% +     dataIn(17):     Stringer (#1) Material Young’s Modulus (Msi)
% +     dataIn(18):     Stringer (#1) Yield Strength - Tension (Ksi)
% +     dataIn(19):     Stringer (#1) Ultimate Strength - Tension (Ksi)
% +     dataIn(20):     Stringer (#1) Yield Strength - Compression (Ksi)
% +     dataIn(21):     Stringer (#1) Ultimate Strength - Compression (Ksi)
% +     dataIn(22):     Stringer (#2) y-location (inch)
% +     dataIn(23):     Stringer (#2) Cross-Section Area (inch^2)
% +     dataIn(24):     Stringer (#2) Iyy Inertia about y-axis (inch^4)
% +     dataIn(25):     Stringer (#2) Izz Inertia about z-axis (inch^4)
% +     dataIn(26):     Stringer (#2) Iyz Product of Inertia (inch^4)
% +     dataIn(27):     Stringer (#2) Weight Density (lb/in^3)
% +     dataIn(28):     Stringer (#2) Material Young’s Modulus (Msi)
% +     dataIn(29):     Stringer (#2) Yield Strength - Tension (Ksi)
% +     dataIn(30):     Stringer (#2) Ultimate Strength - Tension (Ksi)
% +     dataIn(31):     Stringer (#2) Yield Strength - Compression (Ksi)
% +     dataIn(32):     Stringer (#2) Ultimate Strength - Compression (Ksi)
% +     dataIn(33):     Stringer (#3) y-location (inch)
% +     dataIn(34):     Stringer (#3) Cross-Section Area (inch^2)
% +     dataIn(35):     Stringer (#3) Iyy Inertia about y-axis (inch^4)
% +     dataIn(36):     Stringer (#3) Izz Inertia about z-axis (inch^4)
% +     dataIn(37):     Stringer (#3) Iyz Product of Inertia (inch^4)
% +     dataIn(38):     Stringer (#3) Weight Density (lb/in^3)
% +     dataIn(39):     Stringer (#3) Material Young’s Modulus (Msi)
% +     dataIn(40):     Stringer (#3) Yield Strength - Tension (Ksi)
% +     dataIn(41):     Stringer (#3) Ultimate Strength - Tension (Ksi)
% +     dataIn(42):     Stringer (#3) Yield Strength - Compression (Ksi)
% +     dataIn(43):     Stringer (#3) Ultimate Strength - Compression (Ksi)
% +     dataIn(44):     Stringer (#4) y-location (inch)
% +     dataIn(45):     Stringer (#4) Cross-Section Area (inch^2)
% +     dataIn(46):     Stringer (#4) Iyy Inertia about y-axis (inch^4)
% +     dataIn(47):     Stringer (#4) Izz Inertia about z-axis (inch^4)
% +     dataIn(48):     Stringer (#4) Iyz Product of Inertia (inch^4)
% +     dataIn(49):     Stringer (#4) Weight Density (lb/in^3)
% +     dataIn(50):     Stringer (#4) Material Young’s Modulus (Msi)
% +     dataIn(51):     Stringer (#4) Yield Strength - Tension (Ksi)
% +     dataIn(52):     Stringer (#4) Ultimate Strength - Tension (Ksi)
% +     dataIn(53):     Stringer (#4) Yield Strength - Compression (Ksi)
% +     dataIn(54):     Stringer (#4) Ultimate Strength - Compression (Ksi)
% +     dataIn(55):     Safety Factor - Yield
% +     dataIn(56):     Safety Factor - Ultimate
% +     dataIn(57):     Aircraft Load Factor
% +     dataIn(58):     Drag Distribution - Constant (lb/in)
% +     dataIn(59):     Drag Distribution - rth order (lb/in)
% +     dataIn(60):     Drag Distribution - polynomial order
% +     dataIn(61):     Lift Distribution - Constant (lb/in)
% +     dataIn(62):     Lift Distribution - 2nd Order (lb/in)
% +     dataIn(63):     Lift Distribution - 4th Order (lb/in)
% +     dataIn(64):     Twist Moment Distribution - Constant (lb-in/in)
% +     dataIn(65):     Twist Moment Distribution - 1st Order (lb-in/in)
% +
% +  Output Data
% +   Name:             Name of author of this analysis function           
% +   PID:              UCSD Student ID number of author
% +   dataOut1:         Packed calculated output variable data
% +     dataOut1(01):   Modulus Weighted Centroid y-direction (inch)
% +     dataOut1(02):   Modulus Weighted Centroid z-direction (inch)
% +     dataOut1(03):   Cross-Section Weight rhoA (lb/in)
% +     dataOut1(04):   Axial   Stiffness EA   (lb)
% +     dataOut1(05):   Bending Stiffness EIyy (lb-in^2)   
% +     dataOut1(06):   Bending Stiffness EIzz (lb-in^2)   
% +     dataOut1(07):   Bending Stiffness EIyz (lb-in^2)   
% +     dataOut1(08):   Torsion Stiffness GJ   (lb-in^2)
% +     dataOut1(09):   Shear Center, y-direction (inch)
% +     dataOut1(10):   Shear Center, z-direction (inch)
% +     dataOut1(11):   Total Half-Span Wing Weight including added weight factor (lb)
% +     dataOut1(12):   Root Internal Force - X Direction (lb)
% +     dataOut1(13):   Root Internal Force - Y Direction (lb)
% +     dataOut1(14):   Root Internal Force - Z Direction (lb)
% +     dataOut1(15):   Root Internal Moment - about X Direction (lb-in)
% +     dataOut1(16):   Root Internal Moment - about Y Direction (lb-in)
% +     dataOut1(17):   Root Internal Moment - about Z Direction (lb-in)
% +     dataOut1(18):   Stringer (#1) Calculated Axial Stress (lb/in^2)
% +     dataOut1(19):   Stringer (#1) Allowable Stress - Tension (lb/in^2)
% +     dataOut1(20):   Stringer (#1) Allowable Stress - Compression (lb/in^2)
% +     dataOut1(21):   Stringer (#1) Margin of Safety
% +     dataOut1(22):   Stringer (#2) Calculated Axial Stress (lb/in^2)
% +     dataOut1(23):   Stringer (#2) Allowable Stress - Tension (lb/in^2)
% +     dataOut1(24):   Stringer (#2) Allowable Stress - Compression (lb/in^2)
% +     dataOut1(25):   Stringer (#2) Margin of Safety
% +     dataOut1(26):   Stringer (#3) Calculated Axial Stress (lb/in^2)
% +     dataOut1(27):   Stringer (#3) Allowable Stress - Tension (lb/in^2)
% +     dataOut1(28):   Stringer (#3) Allowable Stress - Compression (lb/in^2)
% +     dataOut1(29):   Stringer (#3) Margin of Safety
% +     dataOut1(30):   Stringer (#4) Calculated Axial Stress (lb/in^2)
% +     dataOut1(31):   Stringer (#4) Allowable Stress - Tension (lb/in^2)
% +     dataOut1(32):   Stringer (#4) Allowable Stress - Compression (lb/in^2)
% +     dataOut1(33):   Stringer (#4) Margin of Safety
% +     dataOut1(34):   Skin Panel (1.2) Calculated Shear Stress (lb/in^2)
% +     dataOut1(35):   Skin Panel (1.2) Allowable Stress - Shear (lb/in^2)
% +     dataOut1(36):   Skin Panel (1.2) Margin of Safety
% +     dataOut1(37):   Skin Panel (2.3) Calculated Shear Stress (lb/in^2)
% +     dataOut1(38):   Skin Panel (2.3) Allowable Stress - Shear (lb/in^2)
% +     dataOut1(39):   Skin Panel (2.3) Margin of Safety
% +     dataOut1(40):   Skin Panel (3.4) Calculated Shear Stress (lb/in^2)
% +     dataOut1(41):   Skin Panel (3.4) Allowable Stress - Shear (lb/in^2)
% +     dataOut1(42):   Skin Panel (3.4) Margin of Safety
% +     dataOut1(43):   Skin Panel (4.1) Calculated Shear Stress (lb/in^2)
% +     dataOut1(44):   Skin Panel (4.1) Allowable Stress - Shear (lb/in^2)
% +     dataOut1(45):   Skin Panel (4.1) Margin of Safety
% +     dataOut1(46):   Tip Displacement  - Y Direction (inch)
% +     dataOut1(47):   Tip Displacement  - Z Direction (inch)
% +     dataOut1(48):   Tip Twist (degree)
% +     dataOut1(49):   Tip Bending Slope (dv/dx) (inch/inch)
% +     dataOut1(50):   Tip Bending Slope (dw/dx) (inch/inch)
% +
% +   dataOut2:         Packed calculated output plot data
% +     column( 1):     X direction coordinate (inch)
% +     column( 2):     Applied distributed drag force (lb/in)   
% +     column( 3):     Applied distributed lift force (lb/in)   
% +     column( 4):     Applied distributed torque (lb-in/in)   
% +     column( 5):     Internal shear force  - Vy (lb)   
% +     column( 6):     Internal shear force  - Vz (lb)   
% +     column( 7):     Internal axial torque - Mx (lb-in)
% +     column( 8):     Internal bending moment - My (lb-in)
% +     column( 9):     Internal bending moment - Mz (lb-in)
% +     column(10):     Stringer (#1) Axial Stress (lb/in^2) 
% +     column(11):     Stringer (#2) Axial Stress (lb/in^2) 
% +     column(12):     Stringer (#3) Axial Stress (lb/in^2) 
% +     column(13):     Stringer (#4) Axial Stress (lb/in^2) 
% +     column(14):     Skin Panel (1.2) Shear Stress (lb/in^2) 
% +     column(15):     Skin Panel (2.3) Shear Stress (lb/in^2) 
% +     column(16):     Skin Panel (3.4) Shear Stress (lb/in^2) 
% +     column(17):     Skin Panel (4.1) Shear Stress (lb/in^2)
% +     column(18):     Displacement - Y Direction (inch) 
% +     column(19):     Displacement - z Direction (inch) 
% +     column(20):     Twist (degree)
% +     column(21):     Bending Slope (dv/dx) (inch/inch)
% +     column(22):     Bending Slope (dw/dx) (inch/inch)
% +
% + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + +

% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
% .  SECTION (#1): Unpack Input Data Array and Wwrite User Name and PID
% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
   disp('     (1) Unpack Input Data and Write User Name and PID')

   nplot    = dataIn( 1);   % number of output plot data points
   Lo       = dataIn( 2);   % Wing Length (inch)
   Co       = dataIn( 3);   % Wing Chord (inch)
   tmax     = dataIn( 4);   % Maximum Wing Thickness (inch)
   Kaw      = dataIn( 5);   % Secondary Structure Added Weight (%)
   to_sk    = dataIn( 6);   % Wing Skin Thickness (inch)
   rho_sk   = dataIn( 7);   % Wing Skin Weight Density (lb/inch^3)
   Go_sk    = dataIn( 8);   % Skin Material Shear Modulus (Msi)
   Sys_sk   = dataIn( 9);   % Skin Material Yield Shear Strength (Ksi)
   Sus_sk   = dataIn(10);   % Skin Material Ultimate Shear Strength (Ksi)
   yo_str1  = dataIn(11);   % Stringer 1 y-location (inch)
   A_str1   = dataIn(12);   % Stringer 1 Cross-Section Area (inch^2)
   Iyy_str1 = dataIn(13);   % Stringer 1 Iyy Inertia about the y-axis (inch^4)
   Izz_str1 = dataIn(14);   % Stringer 1 Izz Inertia about the z-axis (inch^4)
   Iyz_str1 = dataIn(15);   % Stringer 1 Iyz Product of Inertia (inch^4)
   rho_str1 = dataIn(16);   % Stringer 1 Wing Skin Weight Density (lb/inch^3)
   Eo_str1  = dataIn(17);   % Stringer 1 Material Young's Modulus (Msi)
   Syt_str1 = dataIn(18);   % Stringer 1 Material Yield Strength    - Tension (Ksi)
   Sut_str1 = dataIn(19);   % Stringer 1 Material Ultimate Strength - Tension (Ksi)
   Syc_str1 = dataIn(20);   % Stringer 1 Material Yield Strength    - Compression (Ksi)
   Suc_str1 = dataIn(21);   % Stringer 1 Material Ultimate Strength - Compression (Ksi)
   yo_str2  = dataIn(22);   % Stringer 2 y-location (inch)
   A_str2   = dataIn(23);   % Stringer 2 Cross-Section Area (inch^2)
   Iyy_str2 = dataIn(24);   % Stringer 2 Iyy Inertia about the y-axis (inch^4)
   Izz_str2 = dataIn(25);   % Stringer 2 Izz Inertia about the z-axis (inch^4)
   Iyz_str2 = dataIn(26);   % Stringer 2 Iyz Product of Inertia (inch^4)
   rho_str2 = dataIn(27);   % Stringer 2 Wing Skin Weight Density (lb/inch^3)
   Eo_str2  = dataIn(28);   % Stringer 2 Material Young's Modulus (Msi)
   Syt_str2 = dataIn(29);   % Stringer 2 Material Yield Strength    - Tension (Ksi)
   Sut_str2 = dataIn(30);   % Stringer 2 Material Ultimate Strength - Tension (Ksi)
   Syc_str2 = dataIn(31);   % Stringer 2 Material Yield Strength    - Compression (Ksi)
   Suc_str2 = dataIn(32);   % Stringer 2 Material Ultimate Strength - Compression (Ksi)
   yo_str3  = dataIn(33);   % Stringer 3 y-location (inch)
   A_str3   = dataIn(34);   % Stringer 3 Cross-Section Area (inch^2)
   Iyy_str3 = dataIn(35);   % Stringer 3 Iyy Inertia about the y-axis (inch^4)
   Izz_str3 = dataIn(36);   % Stringer 3 Izz Inertia about the z-axis (inch^4)
   Iyz_str3 = dataIn(37);   % Stringer 3 Iyz Product of Inertia (inch^4)
   rho_str3 = dataIn(38);   % Stringer 3 Wing Skin Weight Density (lb/inch^3)
   Eo_str3  = dataIn(39);   % Stringer 3 Material Young's Modulus (Msi)
   Syt_str3 = dataIn(40);   % Stringer 3 Material Yield Strength    - Tension (Ksi)
   Sut_str3 = dataIn(41);   % Stringer 3 Material Ultimate Strength - Tension (Ksi)
   Syc_str3 = dataIn(42);   % Stringer 3 Material Yield Strength    - Compression (Ksi)
   Suc_str3 = dataIn(43);   % Stringer 3 Material Ultimate Strength - Compression (Ksi)
   yo_str4  = dataIn(44);   % Stringer 4 y-location (inch)
   A_str4   = dataIn(45);   % Stringer 4 Cross-Section Area (inch^2)
   Iyy_str4 = dataIn(46);   % Stringer 4 Iyy Inertia about the y-axis (inch^4)
   Izz_str4 = dataIn(47);   % Stringer 4 Izz Inertia about the z-axis (inch^4)
   Iyz_str4 = dataIn(48);   % Stringer 4 Iyz Product of Inertia (inch^4)
   rho_str4 = dataIn(49);   % Stringer 4 Wing Skin Weight Density (lb/inch^3)
   Eo_str4  = dataIn(50);   % Stringer 4 Material Young's Modulus (Msi)
   Syt_str4 = dataIn(51);   % Stringer 4 Material Yield Strength    - Tension (Ksi)
   Sut_str4 = dataIn(52);   % Stringer 4 Material Ultimate Strength - Tension (Ksi)
   Syc_str4 = dataIn(53);   % Stringer 4 Material Yield Strength    - Compression (Ksi)
   Suc_str4 = dataIn(54);   % Stringer 4 Material Ultimate Strength - Compression (Ksi)
   SFy      = dataIn(55);   % Safety Factor - Yield
   SFu      = dataIn(56);   % Safety Factor - Ultimate
   LF       = dataIn(57);   % Aircraft Load Factor
   py0      = dataIn(58);   % Drag Distribution - Constant (lb/in)
   pyr      = dataIn(59);   % Drag Distribution - rth order (lb/in)
   rth      = dataIn(60);   % Drag Distribution - polynomial order
   pz0      = dataIn(61);   % Lift Distribution - Constant (lb/in)
   pz2      = dataIn(62);   % Lift Distribution - 2nd Order (lb/in)
   pz4      = dataIn(63);   % Lift Distribution - 4th Order (lb/in)
   mx0      = dataIn(64);   % Twist Moment Distribution - Constant (lb-in/in)
   mx1      = dataIn(65);   % Twist Moment Distribution - 1st Order (lb-in/in)

% Define author name and PID (Write in your name and PID)    
   name  = {'Etka Uzun'};
   PID   = {'A15956274'};
%% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
% .  SECTION (#2): Calculate the Section Properties
% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
   disp('     (2) Calculate the Section Properties')

A_tot = A_str1 + A_str2 + A_str3 + A_str4;
yc = ((A_str1*yo_str1)+((A_str2*yo_str2)+(A_str3*yo_str3)+(A_str4*yo_str4)))/A_tot;
zc = ((A_str1*0)+((A_str2*tmax/(-2))+(A_str3*0)+(A_str4*tmax/2)))/A_tot;

a = Co/4; b = tmax/2; circum = pi*(3*a + 3*b - sqrt((3*a+b)*(a+3*b)));
peri = circum/2 + 2*Co/4 + 2*sqrt((tmax^2+Co^2)/4);
rhoA = (to_sk*rho_sk*peri + rho_str1*A_str1 + rho_str2*A_str2 + rho_str3*A_str3 + rho_str4*A_str4)*(1+ Kaw/100);

EA = (Eo_str1*(10^6)*A_str1)+(Eo_str2*(10^6)*A_str2)+(Eo_str3*(10^6)*A_str3)+(Eo_str4*(10^6)*A_str4);

EIyy = ((Eo_str1*(10^6)*Iyy_str1)+(Eo_str1*(10^6)*A_str1*(0-zc)^2))...
        +((Eo_str2*(10^6)*Iyy_str2)+(Eo_str2*(10^6)*A_str2*(-tmax/2 - zc)^2))...
        +(Eo_str3*(10^6)*Iyy_str3)+(Eo_str3*(10^6)*A_str3*(0-zc)^2)...
        +((Eo_str4*(10^6)*Iyy_str4)+(Eo_str4*(10^6)*A_str4*(tmax/2-zc)^2));

EIzz = ((Eo_str1*(10^6)*Izz_str1)+(Eo_str1*(10^6)*A_str1*(yo_str1-yc)^2))...
        +((Eo_str2*(10^6)*Izz_str2)+(Eo_str2*(10^6)*A_str2*(yo_str2-yc)^2))...
        +(Eo_str3*(10^6)*Izz_str3)+(Eo_str3*(10^6)*A_str3*(yo_str3-yc)^2)...
        +((Eo_str4*(10^6)*Izz_str4)+(Eo_str4*(10^6)*A_str4*(yo_str4-yc)^2));

EIyz = ((Eo_str1*(10^6)*Iyz_str1)+(Eo_str1*(10^6)*A_str1*(yo_str1-yc)*(0-zc)))...
        +((Eo_str2*(10^6)*Iyz_str2)+(Eo_str2*(10^6)*A_str2*(yo_str2-yc)*(-tmax/2 - zc)))...
        +(Eo_str3*(10^6)*Iyz_str3)+(Eo_str3*(10^6)*A_str3*(yo_str3-yc)*(0-zc))...
        +((Eo_str4*(10^6)*Iyz_str4)+(Eo_str4*(10^6)*A_str4*(yo_str4-yc)*(tmax/2-zc)));

A_wing = ((Co/4)*tmax) + (tmax*(Co/2)/2) + (pi*a*b/2);
GJ = (4*A_wing^2*Go_sk*to_sk*10^6)/peri;

A12 = (pi*(Co/4)*(tmax/2)/4) + ((tmax/2)*(yo_str2 - Co/4)/2);
A23 = ((tmax/2)*(yo_str2 - Co/4)/2) + ((tmax/2)*(Co/2 - yo_str2)) + ((tmax/2)*(Co/2)/2);
A34 = ((tmax/2)*(yo_str4 - Co/4)/2) + ((tmax/2)*(Co/2 - yo_str4)) + ((tmax/2)*(Co/2)/2);
A41 = (pi*(Co/4)*(tmax/2)/4) + ((tmax/2)*(yo_str4 - Co/4)/2);
Kyy = EIyy / (EIyy*EIzz - EIyz^2);
Kzz = EIzz / (EIyy*EIzz - EIyz^2);
Kyz = EIyz / (EIyy*EIzz - EIyz^2);
K = [2*A12 2*A23 2*A34 2*A41;1 -1 0 0;0 1 -1 0;0 0 1 -1];
fm = [1;0;0;0];
fy = [-zc;
     Eo_str2*(10^6)*A_str2*(yo_str2-yc)*Kyy - Eo_str2*(10^6)*A_str2*(-tmax/2 - zc)*Kyz;
     Eo_str3*(10^6)*A_str3*(yo_str3-yc)*Kyy - Eo_str3*(10^6)*A_str3*(0-zc)*Kyz;
     Eo_str4*(10^6)*A_str4*(yo_str4-yc)*Kyy - Eo_str4*(10^6)*A_str4*(tmax/2 - zc)*Kyz;
     ];
fz =[yc - Co/4;
     Eo_str2*(10^6)*A_str2*(-tmax/2 - zc)*Kzz - Eo_str2*(10^6)*A_str2*(yo_str2-yc)*Kyz;
     Eo_str3*(10^6)*A_str3*(0-zc)*Kzz - Eo_str3*(10^6)*A_str3*(yo_str3-yc)*Kyz;
     Eo_str4*(10^6)*A_str4*(tmax/2 - zc)*Kzz - Eo_str4*(10^6)*A_str4*(yo_str4-yc)*Kyz;
    ];
peri1 = circum/4 + (yo_str2 - Co/4);
peri2 = (Co/2 - yo_str2) + sqrt((tmax/2)^2 + (Co/2)^2);
peri3 = (Co/2 - yo_str4) + sqrt((tmax/2)^2 + (Co/2)^2);
peri4 = circum/4 + (yo_str4 - Co/4);
perim = [peri1 peri2 peri3 peri4];
ey = -((perim/(Go_sk*to_sk))*(K^(-1))*fz)/((perim/(Go_sk*to_sk))*(K^(-1))*fm);
ysc = ey + yc;
ez = ((perim/(Go_sk*to_sk))*(K^(-1))*fy)/((perim/(Go_sk*to_sk))*(K^(-1))*fm);
zsc = ez + zc;

W_wing = rhoA * Lo;
%% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
% .  SECTION (#3): Calculate Root Internal Stress Resultants for Applied
% .                Concentrated Forces and Applied Aerodynamic Loads
% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
   disp('     (3) Calculate Root Stress Resultants for Applied Concentrated Loads and Aero Loads')
% Find: Vxo Vyo Vzo Mxo Myo Mzo

Wn = W_wing*LF; % defining weight with load factor
% Summing forces in x,y,z directions for forces
Vxo = 0;
Vyo = (py0*Lo) + (pyr* Lo/(rth+1)); % includes integration of Py
Vzo = (pz0*Lo) + (pz2*Lo/3) + (pz4*Lo/5) - Wn; % includes integration of Pz & weight with load factor

% Calculating the moments in x,y,z directions
Mxo = (mx0*Lo + (mx1/(2*Lo))*Lo^2) - ((pz0*Lo + (pz2/(3*Lo^2))*(Lo^3) + (pz4/(5*Lo^4))*(Lo^5)))*(yc-(Co/4)) - W_wing*((Co/2)-yc)*LF - (py0*Lo+(pyr/Lo^rth)*(Lo^(rth+1))/(rth+1))*-zc;
Myo = (Wn*Lo/2) - (pz0*(Lo^2)/2) - (pz2*(Lo^2)/4) - (pz4*(Lo^2)/6); % includes weight and integration of Pz*x
Mzo = (py0*(Lo^2)/2) + (pyr*(Lo^2)/(rth+2)); % includes integration of Py*x

%% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
% .  SECTION (#4): Calculate Allowable Properties, Root Stresses and Margin
% .                of Safety
% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
   disp('     (4) Calculate Allowable Properties, Root Stresses, and Margins of Safety')

y1_c = yo_str1-yc; y2_c = yo_str2-yc; y3_c = yo_str3-yc; y4_c = yo_str4-yc;
z1_c = 0-zc; z2_c = (-tmax/2)-zc; z3_c = 0-zc; z4_c = (tmax/2)-zc;
S = [1/EA 0 0;0 Kyy -Kyz;0 -Kyz Kzz];
Sxxo_str1 = Eo_str1*(10^3)*[1 -y1_c -z1_c]*S*[Vxo; Mzo; -Myo];
Sxxo_str2 = Eo_str2*(10^3)*[1 -y2_c -z2_c]*S*[Vxo; Mzo; -Myo];
Sxxo_str3 = Eo_str3*(10^3)*[1 -y3_c -z3_c]*S*[Vxo; Mzo; -Myo];
Sxxo_str4 = Eo_str4*(10^3)*[1 -y4_c -z4_c]*S*[Vxo; Mzo; -Myo];

S_allow_T_str1 = min(abs(Syt_str1/SFy), abs(Sut_str1/SFu));
S_allow_T_str2 = min(abs(Syt_str2/SFy), abs(Sut_str2/SFu));
S_allow_T_str3 = min(abs(Syt_str3/SFy), abs(Sut_str3/SFu));
S_allow_T_str4 = min(abs(Syt_str4/SFy), abs(Sut_str4/SFu));

S_allow_C_str1 = min(abs(Syc_str1/SFy), abs(Suc_str1/SFu));
S_allow_C_str2 = min(abs(Syc_str2/SFy), abs(Suc_str2/SFu));
S_allow_C_str3 = min(abs(Syc_str3/SFy), abs(Suc_str3/SFu));
S_allow_C_str4 = min(abs(Syc_str4/SFy), abs(Suc_str4/SFu));
if S_allow_C_str1>0
    S_allow_C_str1 = S_allow_C_str1* -1;
end % if
if S_allow_C_str2 > 0
    S_allow_C_str2 = S_allow_C_str2* -1;
end % if
if S_allow_C_str3 > 0
    S_allow_C_str3 = S_allow_C_str3* -1;
end % if
if S_allow_C_str4 > 0
    S_allow_C_str4 = S_allow_C_str4* -1;
end % if

if Sxxo_str1 > 0
    MS_str1 = (S_allow_T_str1/Sxxo_str1) - 1;
elseif Sxxo_str1 < 0
    MS_str1 = (S_allow_C_str1/Sxxo_str1) - 1;
end % if

if Sxxo_str2 > 0
    MS_str2 = (S_allow_T_str2/Sxxo_str2) - 1;
elseif Sxxo_str2 < 0
    MS_str2 = (S_allow_C_str2/Sxxo_str2) - 1;
end % if

if Sxxo_str3 > 0
    MS_str3 = (S_allow_T_str3/Sxxo_str3) - 1;
elseif Sxxo_str3 < 0
    MS_str3 = (S_allow_C_str3/Sxxo_str3) - 1;
end % if

if Sxxo_str4 > 0
    MS_str4 = (S_allow_T_str4/Sxxo_str4) - 1;
elseif Sxxo_str4 < 0
    MS_str4 = (S_allow_C_str4/Sxxo_str4) - 1;
end % if

q = K^(-1) * ((Vyo*fy)+(Vzo*fz)+(Mxo*fm));
to = [1/to_sk 0 0 0;0 1/to_sk 0 0;0 0 1/to_sk 0;0 0 0 1/to_sk];
Tau = to*q*10^-3;
Tau_o_sk12 = Tau(1);
Tau_o_sk23 = Tau(2);
Tau_o_sk34 = Tau(3);
Tau_o_sk41 = Tau(4);

Tau_allow_S_sk12 = min(abs(Sys_sk/SFy), abs((Sus_sk/SFu)));
Tau_allow_S_sk23 = min(abs(Sys_sk/SFy), abs((Sus_sk/SFu)));
Tau_allow_S_sk34 = min(abs(Sys_sk/SFy), abs((Sus_sk/SFu)));
Tau_allow_S_sk41 = min(abs(Sys_sk/SFy), abs((Sus_sk/SFu)));

MS_sk12 = (Tau_allow_S_sk12/abs(Tau_o_sk12)) - 1;
MS_sk23 = (Tau_allow_S_sk23/abs(Tau_o_sk23)) - 1;
MS_sk34 = (Tau_allow_S_sk34/abs(Tau_o_sk34)) - 1;
MS_sk41 = (Tau_allow_S_sk41/abs(Tau_o_sk41)) - 1;

%% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
% .  SECTION (#5): Calculate the Data Arrays for Plotting
% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
   disp('     (5) Calculate the Data Arrays for Future Plotting')

x = linspace(0, Lo, nplot);

py = py0 + (pyr * (x/Lo).^rth);
% figure(1); plot(x,py)
pz = pz0 + (pz2 * (x/Lo).^2) + (pz4*(x/Lo).^4) - W_wing*LF/Lo;
% figure(2); plot(x,pz)
mx = mx0 + (mx1 * (x/Lo).^2) + (zc*py) - ((yc- Co/4)*(pz0 + (pz2 * (x/Lo).^2) + (pz4*(x/Lo).^4)))  - ((Co/2 - yc)*W_wing/(Lo*LF));
% figure(3); plot(x, mx)
Vy = (py0.*(Lo-x)) + ( pyr*((Lo/(rth+1)) - (x.^(rth+1)/((rth+1)*Lo^rth))) );
% figure(4); plot(x,Vy);
Vz = pz0.*(Lo-x) + pz2.*((Lo/3)-(x.^3./(3*Lo^2))) + pz4.*((Lo/5)-(x.^5./(5*Lo^4))) - Wn.*(x(end)/Lo - x./Lo);
% figure(5); plot(x,Vz)
Mx = Mxo - mx0.*x - mx1*x.^3/(3*Lo^2)...
     - ((zc)*(py0.*x + pyr*x.^(rth+1)/((Lo^rth)*(rth+1))))...
     + (yc-(Co/4))*(pz0.*x + pz2*x.^3/(3*Lo^2) + pz4*x.^5/(5*Lo^4))...
     + ((Co/2)-yc).*x*(W_wing/(Lo*LF));
% figure(6); plot(x,Mx);
My = Myo + pz0*(Lo.*x - x.^2/2) + pz2*(Lo.*x/3 - x.^4/(12*Lo^2))...
    + pz4*(Lo*x/5 - x.^6/(30*Lo^4)) - W_wing*(x(end).*x/Lo) - x.^2/(2*Lo^2);
% figure(7); plot(x,My)

Mz = Mzo - py0*(Lo.*x - (x.^2)/2)...
    - pyr*((Lo.*x)/(rth+1) - x.^(rth+2)/((rth+1)*(rth+2)*(Lo^rth)));
% figure(8); plot(x,Mz);

Sxx_str1 = Eo_str1*(10^3)*[1 -y1_c -z1_c]*S*[Vxo.*x; Mz; -My];
Sxx_str2 = Eo_str2*(10^3)*[1 -y2_c -z2_c]*S*[Vxo.*x; Mz; -My];
Sxx_str3 = Eo_str3*(10^3)*[1 -y3_c -z3_c]*S*[Vxo.*x; Mz; -My];
Sxx_str4 = Eo_str4*(10^3)*[1 -y4_c -z4_c]*S*[Vxo.*x; Mz; -My];
% figure(9); hold on; plot(x,Sxx_str1),plot(x,Sxx_str2),plot(x,Sxx_str3),plot(x,Sxx_str4)
q_s5 = K^(-1) * ((Vy.*fy)+(Vz.*fz)+(Mx.*fm));
to = [1/to_sk 0 0 0;0 1/to_sk 0 0;0 0 1/to_sk 0;0 0 0 1/to_sk];
Tau = to*q_s5*10^-3;
Tau_sk12 = Tau(1,:);
Tau_sk23 = Tau(2,:);
Tau_sk34 = Tau(3,:);
Tau_sk41 = Tau(4,:);
% figure(10); hold on; plot(x, Tau_sk12);plot(x, Tau_sk23);plot(x, Tau_sk34);plot(x, Tau_sk41)
Disp_Y = Kyz*( (-(pz0*Lo + pz2*(Lo^3/(3*Lo^2)) + pz4*(Lo^5/(5*Lo^4))) +  LF*(W_wing))*(Lo*x.^2/2 - x.^3/6) - ( ( -(pz0*Lo^2/2 + pz2*(Lo^4/(12*Lo^2)) + pz4*(Lo^6/(30*Lo^4))) + LF*(W_wing)*(Lo^2/(2*Lo)))*x.^2/2 - (- (pz0*x.^4/24 + pz2*(x.^6/(360*Lo^2)) + pz4*(x.^8/(210*8*Lo^4))) + LF*(W_wing)*(x.^4/(24*Lo))) ) )...
        +Kyy*( (py0*Lo + pyr*(Lo^(rth+1)/((rth+1)*Lo^(rth))))*(Lo*x.^2/2 - x.^3/6) - ( (py0*Lo^2/2 + pyr*(Lo^(rth+2)/((rth+2)*(rth+1)*Lo^(rth))))*x.^2/2 - (py0*x.^4/24 + pyr*(x.^(rth+4)/((rth+4)*(rth+3)*(rth+2)*(rth+1)*Lo^(rth)))) ) );
% Disp_Y(nplot)
% figure(11); plot(x,Disp_Y);
Disp_Z = - Kyz*( (py0*Lo + pyr*(Lo^(rth+1)/((rth+1)*Lo^(rth))))*(Lo*x.^2/2 - x.^3/6) - ( (py0*Lo^2/2 + pyr*(Lo^(rth+2)/((rth+2)*(rth+1)*Lo^(rth))))*x.^2/2 - (py0*x.^4/24 + pyr*(x.^(rth+4)/((rth+4)*(rth+3)*(rth+2)*(rth+1)*Lo^(rth)))) ) )...
        -Kzz*( (-(pz0*Lo + pz2*(Lo^3/(3*Lo^2)) + pz4*(Lo^5/(5*Lo^4))) +  LF*(W_wing))*(Lo*x.^2/2 - x.^3/6) - ( ( -(pz0*Lo^2/2 + pz2*(Lo^4/(12*Lo^2)) + pz4*(Lo^6/(30*Lo^4))) + LF*(W_wing)*(Lo^2/(2*Lo)))*x.^2/2 - (- (pz0*x.^4/24 + pz2*(x.^6/(360*Lo^2)) + pz4*(x.^8/(210*8*Lo^4))) + LF*(W_wing)*(x.^4/(24*Lo))) ) ) ;
% Disp_Z(nplot)
% figure(12); plot(x,Disp_Z);

Twist = (180/pi)*(1/2*A_wing)*(perim/(Go_sk*to_sk))*K^(-1)*...
        ((fy*(pyr*((Lo.*x)/(rth+1) + x.^(rth+2)/((rth+1)*(rth+2)*(Lo^rth)))))+...
        (fz*( pz0*(Lo.*x - x.^2/2) + pz2*(Lo.*x/3 - x.^4/(12*Lo^2))+ pz4*(Lo*x/5 - x.^6/(30*Lo^4)) - W_wing*(x(end).*x/Lo) - x.^2/(2*Lo^2)))+...
        (fm* (Mxo.*x - mx0*x.^2/2 - mx1*x.^4/(12*Lo^2)...
        - ((zc)*(py0*x.^2/2 + pyr*x.^(rth+2)/((Lo^rth)*(rth+1)*(rth+2))))...
        + (yc-(Co/4))*(pz0.*x.^2/2 + pz2*x.^4/(12*Lo^2) + pz4*x.^6/(30*Lo^4))...
        + ((Co/2)-yc)*x.^2/2*(W_wing/(Lo*LF)))     ));
Twist(nplot)
figure(13); plot(x, Twist)

DvDx = Kyz*( (-(pz0*Lo + pz2*(Lo^3/(3*Lo^2)) + pz4*(Lo^5/(5*Lo^4))) +  LF*(W_wing))*(Lo.*x - x.^2/2) - ( ( -(pz0*Lo^2/2 + pz2*(Lo^4/(12*Lo^2)) + pz4*(Lo^6/(30*Lo^4))) + LF*(W_wing)*(Lo^2/(2*Lo))).*x - (- (pz0*x.^3/6 + pz2*(x.^5/(60*Lo^2)) + pz4*(x.^7/(30*8*Lo^4))) + LF*(W_wing)*(x.^3/(6*Lo))) ) )...
        +Kyy*( (py0*Lo + pyr*(Lo^(rth+1)/((rth+1)*Lo^(rth))))*(Lo.*x - x.^2/2) - ( (py0*Lo^2/2 + pyr*(Lo^(rth+2)/((rth+2)*(rth+1)*Lo^(rth)))).*x - (py0*x.^3/6 + pyr*(x.^(rth+3)/((rth+3)*(rth+2)*(rth+1)*Lo^(rth)))) ) );
% DvDx(nplot)
DwDx = - Kyz*( (py0*Lo + pyr*(Lo^(rth+1)/((rth+1)*Lo^(rth))))*(Lo.*x - x.^2/2) - ( (py0*Lo^2/2 + pyr*(Lo^(rth+2)/((rth+2)*(rth+1)*Lo^(rth)))).*x - (py0*x.^3/6 + pyr*(x.^(rth+3)/((rth+3)*(rth+2)*(rth+1)*Lo^(rth)))) ) )...
        -Kzz*( (-(pz0*Lo + pz2*(Lo^3/(3*Lo^2)) + pz4*(Lo^5/(5*Lo^4))) +  LF*(W_wing))*(Lo.*x - x.^2/2) - ( ( -(pz0*Lo^2/2 + pz2*(Lo^4/(12*Lo^2)) + pz4*(Lo^6/(30*Lo^4))) + LF*(W_wing)*(Lo^2/(2*Lo))).*x - (- (pz0*x.^3/6 + pz2*(x.^5/(60*Lo^2)) + pz4*(x.^7/(30*8*Lo^4))) + LF*(W_wing)*(x.^3/(6*Lo))) ) ) ;
% DwDx(nplot)



%% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
% .  SECTION (#6): Pack Calculated Data into the "dataOut1" Array size: (50)
% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
   disp('     (6) Pack the Calculated Data into Array: dataOut1')

     dataOut1(01) = yc;               % Modulus Weighted Centroid y-direction (inch)
     dataOut1(02) = zc;               % Modulus Weighted Centroid z-direction (inch)
     dataOut1(03) = rhoA;             % Cross-Section Weight (lb/inch)
     dataOut1(04) = EA;               % Axial   Stiffness (lb)
     dataOut1(05) = EIyy;             % Bending Stiffness (lb-in^2)   
     dataOut1(06) = EIzz;             % Bending Stiffness (lb-in^2)   
     dataOut1(07) = EIyz;             % Bending Stiffness (lb-in^2)   
     dataOut1(08) = GJ;               % Torsion Stiffness (lb-in^2)
     dataOut1(09) = ysc;              % Shear Center y-direction (inch)
     dataOut1(10) = zsc;              % Shear Center z-direction (inch)
     dataOut1(11) = W_wing;           % Total Half-Span Wing Weight (lb)
     dataOut1(12) = Vxo;              % Root Internal Force - X Direction (lb)
     dataOut1(13) = Vyo;              % Root Internal Force - Y Direction (lb)
     dataOut1(14) = Vzo;              % Root Internal Force - Z Direction (lb)
     dataOut1(15) = Mxo;              % Root Internal Moment - about X Direction (lb-in)
     dataOut1(16) = Myo;              % Root Internal Moment - about Y Direction (lb-in)
     dataOut1(17) = Mzo;              % Root Internal Moment - about Z Direction (lb-in)
     dataOut1(18) = Sxxo_str1;         % Stringer (#1) Calculated Axial Stress (lb/in^2)
     dataOut1(19) = S_allow_T_str1;   % Stringer (#1) Allowable Stress - Tension (lb/in^2)
     dataOut1(20) = S_allow_C_str1;   % Stringer (#1) Allowable Stress - Compression (lb/in^2)
     dataOut1(21) = MS_str1;          % Stringer (#1) Margin of Safety
     dataOut1(22) = Sxxo_str2;         % Stringer (#2) Calculated Axial Stress (lb/in^2)
     dataOut1(23) = S_allow_T_str2;   % Stringer (#2) Allowable Stress - Tension (lb/in^2)
     dataOut1(24) = S_allow_C_str2;   % Stringer (#2) Allowable Stress - Compression (lb/in^2)
     dataOut1(25) = MS_str2;          % Stringer (#2) Margin of Safety
     dataOut1(26) = Sxxo_str3;         % Stringer (#3) Calculated Axial Stress (lb/in^2)
     dataOut1(27) = S_allow_T_str3;   % Stringer (#3) Allowable Stress - Tension (lb/in^2)
     dataOut1(28) = S_allow_C_str3;   % Stringer (#3) Allowable Stress - Compression (lb/in^2)
     dataOut1(29) = MS_str3;          % Stringer (#3) Margin of Safety
     dataOut1(30) = Sxxo_str4;         % Stringer (#4) Calculated Axial Stress (lb/in^2)
     dataOut1(31) = S_allow_T_str4;   % Stringer (#4) Allowable Stress - Tension (lb/in^2)
     dataOut1(32) = S_allow_C_str4;   % Stringer (#4) Allowable Stress - Compression (lb/in^2)
     dataOut1(33) = MS_str4;          % Stringer (#4) Margin of Safety
     dataOut1(34) = Tau_o_sk12;       % Skin Panel (1.2) Calculated Shear Stress (lb/in^2)
     dataOut1(35) = Tau_allow_S_sk12; % Skin Panel (1.2) Allowable Shear Stress  (lb/in^2)
     dataOut1(36) = MS_sk12;          % Skin Panel (1.2) Margin of Safety
     dataOut1(37) = Tau_o_sk23;       % Skin Panel (2.3) Calculated Shear Stress (lb/in^2)
     dataOut1(38) = Tau_allow_S_sk23; % Skin Panel (2.3) Allowable Shear Stress  (lb/in^2)
     dataOut1(39) = MS_sk23;          % Skin Panel (2.3) Margin of Safety
     dataOut1(40) = Tau_o_sk34;       % Skin Panel (3.4) Calculated Shear Stress (lb/in^2)
     dataOut1(41) = Tau_allow_S_sk34; % Skin Panel (3.4) Allowable Shear Stress  (lb/in^2)
     dataOut1(42) = MS_sk34;          % Skin Panel (3.4) Margin of Safety
     dataOut1(43) = Tau_o_sk41;       % Skin Panel (4.1) Calculated Shear Stress (lb/in^2)
     dataOut1(44) = Tau_allow_S_sk41; % Skin Panel (4.1) Allowable Shear Stress  (lb/in^2)
     dataOut1(45) = MS_sk41;          % Skin Panel (4.1) Margin of Safety
     dataOut1(46) = Disp_Y(nplot);    % Tip Diplacement - Y Direction (inch)
     dataOut1(47) = Disp_Z(nplot);    % Tip Diplacement - Z Direction (inch)
     dataOut1(48) = Twist(nplot);     % Tip Twist (degree)
     dataOut1(49) = DvDx(nplot);      % Tip Bending Slope (dv/dx) (inch/inch)
     dataOut1(50) = DwDx(nplot);      % Tip Bending Slope (dw/dx) (inch/inch)

% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
% .  SECTION (#7): Pack the plot data arrays into "dataOut2" 
% .                matrix size: (nplot,22)  
% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
   disp('     (7) Pack the Calculated Plot Data into Array: dataOut2')

   for i = 1:nplot;
     dataOut2(i, 1) = x(i);           % x-location (inch)
     dataOut2(i, 2) = py(i);          % drag force (lb/in)
     dataOut2(i, 3) = pz(i);          % lift force (lb/in)
     dataOut2(i, 4) = mx(i);          % distributed torque (lb-in/in)
     dataOut2(i, 5) = Vy(i);          % Internal shear force - Vy (lb)
     dataOut2(i, 6) = Vz(i);          % Internal shear force - Vz (lb)
     dataOut2(i, 7) = Mx(i);          % Internal axial force - Mx (lb-in)
     dataOut2(i, 8) = My(i);          % Internal shear force - My (lb-in)
     dataOut2(i, 9) = Mz(i);          % Internal shear force - Mz (lb-in)
     dataOut2(i,10) = Sxx_str1(i);    % Stringer (#1) Axial Stress (lb/in^2) 
     dataOut2(i,11) = Sxx_str2(i);    % Stringer (#2) Axial Stress (lb/in^2) 
     dataOut2(i,12) = Sxx_str3(i);    % Stringer (#3) Axial Stress (lb/in^2) 
     dataOut2(i,13) = Sxx_str4(i);    % Stringer (#4) Axial Stress (lb/in^2) 
     dataOut2(i,14) = Tau_sk12(i);    % Skin Panel (1.2) Shear Stress (lb/in^2) 
     dataOut2(i,15) = Tau_sk23(i);    % Skin Panel (2.3) Shear Stress (lb/in^2) 
     dataOut2(i,16) = Tau_sk34(i);    % Skin Panel (3.4) Shear Stress (lb/in^2) 
     dataOut2(i,17) = Tau_sk41(i);    % Skin Panel (4.1) Shear Stress (lb/in^2)
     dataOut2(i,18) = Disp_Y(i);      % Displacement - Y Direction (inch)
     dataOut2(i,19) = Disp_Z(i);      % Displacement - Z Direction (inch)
     dataOut2(i,20) = Twist(i);       % Wing Twist (degree)
     dataOut2(i,21) = DvDx(i);        % Bending Slope (dv/dx) (inch/inch)
     dataOut2(i,22) = DwDx(i);        % Bending Slope (dw/dx) (inch/inch)
   
   end;
   
end

%  End of Function: Wing_Analysis_Function
%  ------------------------------------------------------------------------