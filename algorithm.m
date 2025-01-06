function T = algorithm(C, Sx, Sy, X, Y, L)
%ALGORITHM takes in the defining values for a Truss and returns the member
%tensions given a load on a specific joint

%Algorithm uses joint analysis to solve for member tensions. It takes the
%joint force equations in the form:
%L(Net Force applied on a joint in a given direction) = A*T(member1) +
%A*T(member2) + ... A*S(support reaction)
%Where A[][] is the corresponding coefficient that creates the directional
%component from each applied force i.e. (X1-X2)/r || (Y1-Y2)/r
%Once we have A, we can solve the system of equations AT = L for T which is
%a vector containing all of the tensions in each member

joints = size(C, 1); %number of joints in truss
members = size(C, 2); %number of members in truss
reacts = 3; %number of reaction forces acting on the truss

%Create the Matrix A
A = zeros(joints, (members + reacts));

for i = 1:joints                                                            %Loop through the number of joints 
    for j = 1:members                                                       %Loop through the number of members
        if C(i, j) == 1                                                     %If the given member connects at the given joint, set it's Force equation coefficients
            otherConnection = find(C(:, j), 1, 'first');
            if otherConnection(1) == i
                otherConnection = find(C(:, j), 1, 'last');
            end
            r = sqrt(((X(otherConnection(1))-X(i))^2)+((Y(otherConnection(1))-Y(i))^2)); %The length of the given member
            A(i, j) = (X(otherConnection(1)) - X(i))/r;                        %Set the X-Component Coefficient
            A((i + joints), j) = (Y(otherConnection(1)) - Y(i))/r;             %Set the Y-Component Coefficient
        end
    end
end

for k = 1:(joints)                                                          %Loop through joints
    for h = 1:(reacts)                                                      %Loop through reaction forces
        if Sx(k, h) == 1                                                    %If there is a horizontal reaction force, assign it to appropriate joint
            A(k, h + members) = 1;
        end
        if Sy(k, h) == 1                                                    %If there is a vertical reaction force, assign it to appropriate joint
            A(k + joints, h + members) = 1;  
        end
    end
end

%Find T given A
T = mldivide(A, L);

end