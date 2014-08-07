function [D] = sorting(D)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
for i=1:49
    for j=i+1:49
        if(D(i)>D(j))
            temp=D(i);
            D(i)=D(j);
            D(j)=temp;
        end
    end
end
end

