function [ Metric ] = CombinedMetric( Metric,SizeDB )
%A weighted Sum of Metric from 3 databases is done in this function
[m,c] = size(Metric);
for i = 1:c
    Metric(5,i) = 0;
    total(i) = 0;
end
for i =1:c
    for j = 1:m
    total(i) = total(i) + SizeDB(j);
    end
end
for i = 1: c
    for j = 1:m
   %     Metric(5,i) = Metric(5,i) +(((SizeDB(j))/total(i))*Metric(j,i));
         Metric(5,i) = Metric(5,i) + Metric(j,i);
    end
    Metric(5,i) = Metric(5,i)/3;
end
end

