function [cost] = getCost(C, X, Y)
%Returns the cost of the Truss

members = size(C, 2);                                                       %# of members
joints = size(C, 1);                                                        %# of joints
r = zeros(members, 1);                                                         %Array of member lengths

for i = 1:members
    Connection = find(C(:, i), 1, 'first');                                 %Find the member connections 
    otherConnection = find(C(:, i), 1, 'last');
    r(i) = sqrt(((X(otherConnection(1))-X(Connection(1)))^2)+((Y(otherConnection(1))-Y(Connection(1)))^2)); %Find the member length
end

cost = ((10*joints)+(sum(r)));                                              %find the cost by summing the member lengths and placing into given equation
end