function [ Error ] = ErrorCalculator( results,probabilityDist,SizeDBS, RuleSetNew )
%Calculates the error in the test classes after calculation

correctlyClassified = 0;
for i=1:numel(results)
    if(SizeDBS(i)~=0)
    correctlyClassified  = correctlyClassified + (((probabilityDist(i).prob(RuleSetNew(i).MaxClass))/100) * SizeDBS(i));
    end
end

disp(correctlyClassified)
totalItems = 0;
for i=1:numel(SizeDBS)
    totalItems = totalItems + SizeDBS(i);
end
disp(totalItems)
Error = 100 -(correctlyClassified/totalItems) * 100;

end

