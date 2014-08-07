function [att] = InfoGain(X)
%This function calculates the information gain values for a given database.
%%
[cutoff_X,flag1] = cutoff_DB(X);
att = 0;
if(flag1==0)
    return
end
iter=1; % Signifies The iteration(time) the learner function is being called.
if((flag1~=0) & (X~=0))
    [gain1,cut1] = Gain_values(X);
    [g,c]=size(X);
    Num_Class = numel(unique(X(:,c)));
%     class1=0;
%     class2=0;
%     class3=0;
    information_gain1=zeros((c-1)*3,70);
    %To find parent entropy
%     for b=1:g
%         if(X(b,c)==1)
%             class1=class1+1;
%         end
%         if(X(b,c)==2)
%             class2=class2+1;
%         end
%         if(X(b,c)==3)
%             class3=class3+1;
%         end
%     end
    
    for i = 1:Num_Class
        count(i) = sum(X(:,c)==i);
    end
    
    for i=1:(c-1)*3
        if(iter==1)
            Parent_entropy=0;
            for j = 1: Num_Class
                Parent_entropy = Parent_entropy+ ((divide(count(j),g)*logck(divide(count(j),g))));
                %+ (divide(class2,g)*logck(divide(class2,g)))+ (divide(class3,g)*logck(divide(class3,g))));
            end
            Parent_entropy = -1 * Parent_entropy;
            information_gain1(i,iter)=Parent_entropy - gain1(i);
        else
            information_gain1(i,iter)=gain1(i)-information_gain1(i,iter-1);
        end
    end
end

%%
[m1,c]=size(X);%gets size for table 1
gain=zeros((c-1)*3,1);
if(flag1~=0)
    gain(:,1)=information_gain1(:,iter); %gain of DB1
else
    gain(:,1)=0;
end

[C,I]=max(gain);
disp(I)
att=ceil(I/3);

%fprintf('The best attribute to split is: %d',I/3);
fprintf('The best attribute to split is: %d',att);

iter=iter+1;
end




