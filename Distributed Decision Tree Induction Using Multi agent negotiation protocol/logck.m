function [x] = logck(x)
%This function handles the NaN error caused due to log0 being NaN.
%   Detailed explanation goes here
if(x~=0)
    x=log(x);
else
    x=1;
end
end

