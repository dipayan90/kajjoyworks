load D1;
load D2;
load D3;
DB = [D1;D2;D3];
DB_input=input('Please enter the database name with format: \n','s');
%accur = input('Please enter the accuracy you would like to have in the leaf levels');
%A = [80 85 90 95 100];
A = [100];
[D1,D2,D3,D,Test] = DB_Create(DB_input);
%[D1,D2,D3,D,Test] = DB_Create_Extreme(DB_input);
DataBase = [D1;D2;D3];
save DataBase
for i=1:length(A)
   accur = A(i);
   [Error_Before,Error_After] = Main(accur,D1,D2,D3,D,Test);
    % before(i) = Error_Before;
   after(i) = Error_After;
end
% x_axis_X = 1:length(before);
% y_axis_Y = 1:length(after);
% 
% figure;plot(x_axis_X, before,'o-', y_axis_Y, after, 'x-');
figure; plot(A,after)