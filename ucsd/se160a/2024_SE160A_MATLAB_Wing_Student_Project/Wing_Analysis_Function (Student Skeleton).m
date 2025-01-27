function [name, PID, dataOut1, dataOut2] = Wing_Analysis_Function(dataIn);
% + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + +
% +
% +  SE-160A:  Aerospace Structural Analysis I
% +
% +  Project: (2) Wing Analysis
% +
% +  Title:   Wing_Analysis_Function
% +  Author:  Student Name
% +  PID:     Student PID
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
   name  = {'Student Name'};
   PID   = {'Student PID'};

% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
% .  SECTION (#2): Calculate the Section Properties
% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
   disp('     (2) Calculate the Section Properties')

% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
% .  SECTION (#3): Calculate Root Internal Stress Resultants for Applied
% .                Concentrated Forces and Applied Aerodynamic Loads
% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
   disp('     (3) Calculate Root Stress Resultants for Applied Concentrated Loads and Aero Loads')

% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
% .  SECTION (#4): Calculate Allowable Properties, Root Stresses and Margin
% .                of Safety
% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
   disp('     (4) Calculate Allowable Properties, Root Stresses, and Margins of Safety')

% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
% .  SECTION (#5): Calculate the Data Arrays for Plotting
% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
   disp('     (5) Calculate the Data Arrays for Future Plotting')

% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
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
     dataOut1(11) = W_wing:           % Total Half-Span Wing Weight (lb)
     dataOut1(12) = Vxo;              % Root Internal Force - X Direction (lb)
     dataOut1(13) = Vyo;              % Root Internal Force - Y Direction (lb)
     dataOut1(14) = Vzo;              % Root Internal Force - Z Direction (lb)
     dataOut1(15) = Mxo;              % Root Internal Moment - about X Direction (lb-in)
     dataOut1(16) = Myo;              % Root Internal Moment - about Y Direction (lb-in)
     dataOut1(17) = Mzo;              % Root Internal Moment - about Z Direction (lb-in)
     dataOut1(18) = Sxx_str1;         % Stringer (#1) Calculated Axial Stress (lb/in^2)
     dataOut1(19) = S_allow_T_str1;   % Stringer (#1) Allowable Stress - Tension (lb/in^2)
     dataOut1(20) = S_allow_C_str1;   % Stringer (#1) Allowable Stress - Compression (lb/in^2)
     dataOut1(21) = MS_str1;          % Stringer (#1) Margin of Safety
     dataOut1(22) = Sxx_str2;         % Stringer (#2) Calculated Axial Stress (lb/in^2)
     dataOut1(23) = S_allow_T_str2;   % Stringer (#2) Allowable Stress - Tension (lb/in^2)
     dataOut1(24) = S_allow_C_str2;   % Stringer (#2) Allowable Stress - Compression (lb/in^2)
     dataOut1(25) = MS_str2;          % Stringer (#2) Margin of Safety
     dataOut1(26) = Sxx_str3;         % Stringer (#3) Calculated Axial Stress (lb/in^2)
     dataOut1(27) = S_allow_T_str3;   % Stringer (#3) Allowable Stress - Tension (lb/in^2)
     dataOut1(28) = S_allow_C_str3;   % Stringer (#3) Allowable Stress - Compression (lb/in^2)
     dataOut1(29) = MS_str3;          % Stringer (#3) Margin of Safety
     dataOut1(30) = Sxx_str4;         % Stringer (#4) Calculated Axial Stress (lb/in^2)
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