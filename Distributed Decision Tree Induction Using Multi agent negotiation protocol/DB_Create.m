function [D1,D2,D3,D,Test] = DB_Create(DB_input)
%Creates the database from sourcefiles and returns multiple databases.
%database is randomized after segmentation
%DB_input=input('Please enter the database name with format: \n','s');
DB=xlsread(DB_input);
[m,c]=size(DB);
m=abs(0.7*m)+mod(m,3);
m = round(m);
k=randperm(m);
% for Randomization
for i=1:c
    for j=1:m
        D(j,i)=DB(k(j),i);
    end
end
%m=abs(0.7*m)+mod(m,3);
save D
D1=D(1:m/3,1:c);
save D1
D2=D(((m/3)+1):(2*(m/3)),1:c);
save D2
D3=D((2*(m/3)+1):m,1:c);
save D3

[tsize,c]=size(DB);
Test=DB(m+1:tsize,1:c);
save Test

end
