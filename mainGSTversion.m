%This is the GST copy of main meant to be turned in for testing. It follows
%all the rubric guidelines

clc                                                                         %Clears the screen
clear                                                                       %Clears the variables
           
%load('PracticeProblemInput.mat');                                          %inputs to test the Practice Problem and Custom Truss tests
%load('TrussDesign1_Leo_Dom_Mike_A6.mat');                                  %Leo's Designs
%load('TrussDesign1a_Leo_Dom_Mike_A6.mat'); % >30oz (load on roller side)
%load('TrussDesign2_DomLeoMichael_A6.mat');                                 %Dom's Designs
%load('TrussDesign2a_DomLeoMichael_A6.mat'); % >30oz (load on pin side)
%load('TrussDesign3_DomLeoMichael_A6.mat');                                 %Michael's Designs
%load('TrussDesign3a_DomLeoMichael_A6.mat');
load('matlab.mat'); %FINAL WITH
%load('matlab2.mat');    %THISISTHEWINNERVERSIOIN AND MATLAB CHANGES TO YOUR REPORT WITH THE OUTPUT %SHOWLENGTHS %SHOW NEW .mat


%{
C = Connection Matrix
Sx = Location Matrix of Reaction Forces in X-Direction
Sy = Location Matrix of Reaction Forces in Y-Direction
X = Joint Location Vector of X Values
Y = Joint Location Vector of Y Values
L = Applied External Load Vector
%}

T = algorithm(C, Sx, Sy, X, Y, L);                                         %determines the deliverables from the given test variables

[W, Wcrit, critMem] = calcCritLoad(C, X, Y, T, L);                         %determines the critical weight for each member when a load is applied at a given joint
                                                                          
cost = getCost(C, X, Y);                                                   %determines the cost of the truss

%{
T = Vector of the tension in every member when a given load is applied (Load Magnitude/Location specific) + the support reaction forces
W = Vector of the critical applied loads for each member. The load must be applied at a specific joint (Same as done in L). 
Therefore, the lowest value in this vector is the critical load of the
truss and it's index corresponds to the critical member (Load Location specific ONLY)
cost = Decimal Cost of the given truss
Wcrit = The max weight that can be applied at load location in L before buckling
%}

R = getLength(X, Y, C);

GSToutput(cost, T, Wcrit, L, critMem, R);                                     %outputs the deliverables in the GST requested format
