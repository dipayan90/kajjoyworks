function [ RuleSet] = SortRules(RuleSet)
%This function takes in the RuleSet and sorts it according to the attribute
%order
n = numel(RuleSet);
for k = 1:n
            sample(:,1) = RuleSet(k).attributes(:);
            sample(:,2) = RuleSet(k).cutoff(:);
            sample(:,3) = RuleSet(k).isGreater(:);
            sample = sortrows(sample,1);
            RuleSet(k).attributes = sample(:,1)';
            RuleSet(k).cutoff = sample(:,2)';
            RuleSet(k).isGreater = sample(:,3)';
            sample=[];
end
end

