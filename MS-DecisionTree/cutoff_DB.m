function [cutoff_X,flag] = cutoff_DB(X)
%This function is used to findout all the possible cutoff points.
%possible cutoff points are those when there is a change in class.
%Probsplit gives us all the indices of the possible split points.cutoff_X
%gives all the values of the split points. cutoff_X is a (N x c) vector
%where N is the number of cutoff points and c is the total number of
%attributes.
[m,c]=size(X);
flag=1;
cutoff_X = zeros(m,c-1);

if(X==0)
    flag=0;
end
if(flag==1)
    j=1;
    prob_split=ones(1,m);
    if(m==2)
        if(X(2,c)~=X(1,c))
            prob_split(1)=2; %finds all the split points, where classes differ
        end
    end
    for i=1:(m-1)
        if(m==1)
            prob_split(j)=i;
        end
        if((X(i+1,c)~=X(i,c)) && m~=1)
            prob_split(j)=i; %finds all the split points, where classes differ
            j=j+1;
        end
    end
    %If incase its a pure class, then flag is turned to 0.
    if(prob_split==ones(1,m))
        fprintf('This is a pure class,its time to stop dude, the pure database is  \n');
        disp(X);
        flag=0;
    end
    prob_split=prob_split(prob_split~=1);
    %If incase its a pure class, it returs cutoof values to be all zeros
    if(flag==0)
        cutoff_X=zeros(1,c-1);
    else
        cutoff_X=ones(length(prob_split),(c-1));
        for i=1:length(prob_split)
            for j=1:(c-1)
                cutoff_X(i,j)=X(prob_split(i),j);% Vector having all the split points
            end
        end
    end
    
end
end


