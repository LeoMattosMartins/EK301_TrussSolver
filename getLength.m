function R = getLength(X, Y, C)
%Returns the length of each member in a vector

joints = size(C, 1);
members = size(C, 2);
R = zeros(1, members);
for i = 1:joints                                                            %Loop through the number of joints 
    for j = 1:members                                                       %Loop through the number of members
        if C(i, j) == 1                                                     %If the given member connects at the given joint, set it's Force equation coefficients
            otherConnection = find(C(:, j), 1, 'first');
            if otherConnection(1) == i
                otherConnection = find(C(:, j), 1, 'last');
            end
            R(j) = sqrt(((X(otherConnection(1))-X(i))^2)+((Y(otherConnection(1))-Y(i))^2)); %The length of the given member
        end
    end
end

end

