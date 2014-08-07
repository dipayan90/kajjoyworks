function RulesViewer(RuleSet,SizeDB)
%This function helps show the rules
n = numel(RuleSet);
fprintf('Rules Are As Follows:');
for k = 1:3
    fprintf('For DB:%d',k);
for i=1:n
    fprintf('Rule %d: \n',i);
    for j = 1:numel(RuleSet(i).attributes)
        if(RuleSet(i).isGreater(j) == 0)
        fprintf('For Attribute (%d),any thing lesser than (%d) and \n',RuleSet(i).attributes(j),RuleSet(i).cutoff(j));
        else
        fprintf('For Attribute (%d),any thing Greater than (%d) and \n',RuleSet(i).attributes(j),RuleSet(i).cutoff(j));
        end
    end
    fprintf('Gives %d as majority class and the probdist is as follows:',RuleSet(i).MaxClass);
    disp(RuleSet(i).probdist);
    disp('Elements in Leaf Level')
    disp( SizeDB(k,i))
end
end
end

