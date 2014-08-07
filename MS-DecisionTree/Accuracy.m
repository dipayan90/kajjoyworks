function [accuracy,class,probdist] = Accuracy(DB,Classes)
%This function checks out how good is the accuracy of the classifier by
%seeing the accuracy of the database. Maximum number of elements belonging
%to the same class is checked. If this number is greater than the
%predefined value for purity required by the user then the program stops
%splitting that particular database and call it as a pure class.
[m,n]=size(DB);
if(isempty(DB))
    for i=1:Classes
        p(i) = 0/0;
    end
    
    for i=1:Classes
    probdist(i)=p(i)*100;
    end
    
    [C,I]=max(probdist);
    accuracy = C;
    class = I;
    
    return;
end

% class1=0;
% class2=0;
% class3=0;
% for k=1:m
%     if DB(k,n)==1
%         class1=class1+1;
%     end
%     if DB(k,n)==2
%         class2=class2+1;
%     end
%     if DB(k,n)==3
%         class3=class3+1;
%     end
% end

for i = 1: Classes
    count(i) = sum(DB(:,n)==i);
   % p(i) = count(i)/m;
end

for i = 1: Classes
    p(i) = count(i)/m;
end

% p(1)=class1/m;
% p(2)=class2/m;
% p(3)=class3/m;

for i=1:Classes
    probdist(i)=p(i)*100;
end

[C,I]=max(probdist);
accuracy = C;
class = I;
end

