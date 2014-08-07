function [ AttributeSet ] = AttributesInvolved ( RuleSet,n )
%This function is used to find all the attributes that are involved in the
%decision tree creation process, for each of the rules. 
AttributeSet = zeros(numel(RuleSet),n);

for i=1:numel(RuleSet)
        for k = 1:numel(RuleSet(i).attributes)
            AttributeSet(i,RuleSet(i).attributes(k))=1;
        end
end
end

