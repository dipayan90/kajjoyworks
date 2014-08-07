function [ RuleSet,DuplicateRule ] = DuplicateRemover( RuleSet )
%The main objective of the function is to go throguh all the rules and if
%any rules is found to be a duplicate, remove it.

k = 1;
for i = 1:numel(RuleSet)
    for j = i+1:numel(RuleSet)
        if(isequal(RuleSet(i),RuleSet(j)))
            RuleSet(j).probdist = 0;
            RuleSet(j).MaxClass = 0;
            RuleSet(j).attributes = 0;
            RuleSet(j).cutoff = 0;
            RuleSet(j).isGreater = 0;
            RuleSet(j).att = 0;
            DuplicateRule(k) = j;
            k = k+1;
        end
    end
end

if(k ==1)
    DuplicateRule(k) = 0;
end

i = numel(RuleSet);
while(i>=1)
    if(RuleSet(i).attributes == 0)
        RuleSet(i) = [];
    end
    i = i-1;
end
end

