function [W, Wcrit, critMem] = calcCritLoad(C, X, Y, T, L)
%This function will return the critical load
%   Create own T with a test of one small load and get the T (algorithm function in each member
%   to find the R vector which you will then use the find the critical W
%   for each member

members = size(C, 2);

Rm = zeros(1, members);
W = zeros(1, members);                  

Wl= L(find(L));                                                            %Find the value of the load

for i = 1:members
    Rm(i) = T(i) / Wl;                                                     %Determine a reference proportion using the Tensions you already found
    Connection = find(C(:, i), 1, 'first');                                %Find the member connections 
    otherConnection = find(C(:, i), 1, 'last');
    r = sqrt(((X(otherConnection(1))-X(Connection(1)))^2)+((Y(otherConnection(1))-Y(Connection(1)))^2)); %Find member length
    U = 0.13*(r^2) - 4.21*r + 36.9; %calculate the uncertainty
        %fprintf('m%d Uncertainty: %g \n', i, abs(U));
    Pcrit = 3654.533 * (r^(-2.119)) +U; %subtract uncertainty 
        %fprintf('m%d Buckling Strength: %g \n', i, abs(Pcrit)); %get rid of U in calculationas         %Find Pcrit with the given equation from buckling lab results
    W(i) = (-1*Pcrit)/Rm(i);                                               %Find the maximum weight the member can take at it's length and location
end
 
                                                                           %Remove all members in tension as we assume tension is infinite
Wcrit = min(abs(W(W>=0)));                                                 %Find the member with the smallest buckling load
critMem = find(W==(min(W(W>=0))));                                         %Find which member buckles first
end