function [ D1,D2,D3,D,Test] = DB_Create_Extreme(DB_input)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%Creates the database from sourcefiles and returns multiple databases.
%database is randomized after segmentation
%DB_input=input('Please enter the database name with format: \n','s');
DB=xlsread(DB_input);
[m,c]=size(DB);

D=DB(1:abs(0.7 * m),1:c);
[m,c]=size(D);
save D
k = randperm(m/3);
for i=1:c
    for j=1:m/3
        D1(j,i)=D(k(j),i);
    end
end
save D1

D2=D(((m/3)+1):(2*(m/3)),1:c);
temp = D2;
for i=1:c
    for j=1:m/3
        D2(j,i)=temp(k(j),i);
    end
end
save D2
D3=D((2*(m/3)+1):m,1:c);
temp = D3;
for i=1:c
    for j=1:m/3
        D3(j,i)=temp(k(j),i);
    end
end
save D3

[m,c]=size(DB);
Test=DB(abs(0.7*m)+1:abs(m),1:c);
save Test

%Num_Class = numel(unique(DB(:,c)));
end

