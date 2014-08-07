function [gain_X,cutoff] = Gain_values(X)
%This function calculates the entropy of the the section of the whole
%database and returns a vector that has the entropy value if each of the
%attributes are splitted
%%
[g,c]=size(X);
[cutoff_X] = cutoff_DB(X); % A n X 7 vector having all the split values for different columns of the DB based on split points
m=numel(cutoff_X)/(c-1); % number of split points for which entropy needs to be found
entropy_X=zeros(m,(c-1));
gain=zeros(m,(c-1));
Num_Class = numel(unique(X(:,c)));

z=zeros(m,c-1);
z_dash=zeros(m,c-1);
E1=zeros(m,c-1);
E2=zeros(m,c-1);
k = struct;
for var = 1:(2*Num_Class)
    k(var).count=zeros(m,c-1);
end
    

% k1=zeros(m,c-1);
% k2=zeros(m,c-1);
% k3=zeros(m,c-1);
% k4=zeros(m,c-1);
% k5=zeros(m,c-1);
% k6=zeros(m,c-1);
%%
% for n=1:m
%     for i=1:(c-1)
%         for j=1:g
%             if(X(j,i)>cutoff_X(n,i))
%                 k(n,i)=k(n,i)+1;
%             end
%             if(X(j,i)>cutoff_X(n,i) && X(j,c)==1) %this is class%
%                 k1(n,i)=k1(n,i)+1;
%             end
%             if(X(j,i)>cutoff_X(n,i) && X(j,c)==2)
%                 k2(n,i)=k2(n,i)+1;
%             end
%             if(X(j,i)>cutoff_X(n,i) && X(j,c)==3)
%                 k3(n,i)=k3(n,i)+1;
%             end
%             if(X(j,i)<=cutoff_X(n,i) && X(j,c)==1)
%                 k4(n,i)=k4(n,i)+1;
%             end
%             if(X(j,i)<=cutoff_X(n,i) && X(j,c)==2)
%                 k5(n,i)=k5(n,i)+1;
%             end
%             if(X(j,i)<=cutoff_X(n,i) && X(j,c)==3)
%                 k6(n,i)=k6(n,i)+1;
%             end
%         end
%     end
% end


for n =1:m
    for i = 1:(c-1)
        for j = 1:g
             if(X(j,i)>cutoff_X(n,i))
                z(n,i)=z(n,i)+1;
             end
              p = 1;
             while(p<=Num_Class)
             if(X(j,i)>cutoff_X(n,i) && X(j,c)==p)
                k(p).count(n,i)=k(p).count(n,i)+1;
             end
             p = p+1;
             end
             q = 1;
             while(q<=(Num_Class))
             if(X(j,i)<=cutoff_X(n,i) && X(j,c)==q)
                 temp = Num_Class+q;
                k(temp).count(n,i)= k(temp).count(n,i)+1;
             end
             q = q+1;
             end
        end
    end
end


for n = 1:m
    for i = 1:(c-1)
        z_dash(n,i)=divide(numel(X),c)-z(n,i);
        for j = 1:Num_Class
            
             E1(n,i) = E1(n,i) + ((divide(k(j).count(n,i),z(n,i)))*logck(divide(k(j).count(n,i),z(n,i))));
             %+((divide(k2(n,i),k(n,i)))*logck(divide(k2(n,i),k(n,i))))+((divide(k3(n,i),k(n,i)))*logck(divide(k3(n,i),k(n,i)))));
             E2(n,i) = E2(n,i) + (((divide(k(j+Num_Class).count(n,i),z_dash(n,i))))*logck(divide(k(j+Num_Class).count(n,i),z_dash(n,i))));
            %+((divide(k5(n,i),k_dash(n,i)))*logck(divide(k5(n,i),k_dash(n,i))))+((divide(k6(n,i),k_dash(n,i)))*logck(divide(k6(n,i),k_dash(n,i)))));
        end
         E1(n,i) = -1 *  E1(n,i);
         E2(n,i) = -1 * E2(n,i);
        entropy_X(n,i)=((z(n,i)/(numel(X)/c))*E1(n,i))+ ((z_dash(n,i)/(numel(X)/c))*E2(n,i));
        gain(n,i)=(entropy_X(n,i));
    end
end


% for n=1:m
%     for i=1:(c-1)
%         k_dash(n,i)=divide(numel(X),c)-k(n,i);
%         E1(n,i)=-1*((divide(k1(n,i),k(n,i))*logck(divide(k1(n,i),k(n,i))))+((divide(k2(n,i),k(n,i)))*logck(divide(k2(n,i),k(n,i))))+((divide(k3(n,i),k(n,i)))*logck(divide(k3(n,i),k(n,i)))));
%         E2(n,i)=-1*(((divide(k4(n,i),k_dash(n,i)))*logck(divide(k4(n,i),k_dash(n,i))))+((divide(k5(n,i),k_dash(n,i)))*logck(divide(k5(n,i),k_dash(n,i))))+((divide(k6(n,i),k_dash(n,i)))*logck(divide(k6(n,i),k_dash(n,i)))));
%         entropy_X(n,i)=((k(n,i)/(numel(X)/c))*E1(n,i))+ ((k_dash(n,i)/(numel(X)/c))*E2(n,i));
%         gain(n,i)=(entropy_X(n,i));
%     end
% end

cutoff=ones((c-1));
[g_size1,ind1]=size(gain);
[gain_X1,index1]=max(gain);
if(size(gain)==[1 c-1])
    gain_X1=gain;
    index1=ones(1,c-1);
end
for k=1:(c-1)
    cutoff1(k)=cutoff_X(index1(k),k);
end
for i=1:c-1
    for j=1:g_size1
        if(gain(j,i)==gain_X1(i))
            gain(j,i)=0;
        end
    end
end

[gain_X2,index2]=max(gain);
if(size(gain)==[1 c-1])
    gain_X2=gain;
    index2=ones(1,c-1);
end
for k=1:(c-1)
    cutoff2(k)=cutoff_X(index2(k),k);
end
for i=1:c-1
    for j=1:g_size1
        if(gain(j,i)==gain_X2(i))
            gain(j,i)=0;
        end
    end
end

[gain_X3,index3]=max(gain);
if(size(gain)==[1 c-1])
    gain_X3=gain;
    index3=ones(1,c-1);
end
for k=1:(c-1)
    cutoff3(k)=cutoff_X(index3(k),k);
end

cutoff=[cutoff1;cutoff2;cutoff3];
cutoff=cutoff(:);
gain_X=[gain_X1;gain_X2;gain_X3];
gain_X=gain_X(:);
end

