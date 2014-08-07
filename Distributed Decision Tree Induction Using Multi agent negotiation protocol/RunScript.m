load D1;
load D2;
load D3;
DB = [D1;D2;D3];
DB_input=input('Please enter the database name with format: \n','s');
accur = input('Please enter the accuracy you would like to have in the leaf levels');
for i=1:10
   [Error_Before,Error_After] = Main(DB_input,accur);
   before(i) = Error_Before;
   after(i) = Error_After;
end
x_axis_X = 1:length(before);
y_axis_Y = 1:length(after);

figure;plot(x_axis_X, before,'o-', y_axis_Y, after, 'x-');