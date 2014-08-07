function [ result,ProbabailityDistribution,NumInstance ] = RulesValidator(RuleSet,X,Num_Class)
%This function applies the rule set to databases and find out how well the
%rules fit
n = numel (RuleSet);
DataSet = X;
for i=1:n
    X = DataSet;
    for j = 1:numel(RuleSet(i).attributes)
        [rows,cols] = size(X);
        if(RuleSet(i).isGreater(j) == 0)
            A = find(X(:,RuleSet(i).attributes(j))<=RuleSet(i).cutoff(j));
        else
            A = find(X(:,RuleSet(i).attributes(j))>=RuleSet(i).cutoff(j)); 
        end
        for k = 1 : numel(A)
            X(k,:) = X(A(k),:);
        end
        X((numel(A)+1):rows,:)=[];
    end
    [accuracy,class,probdist] = Accuracy(X,Num_Class);
    ProbabailityDistribution(i).prob = probdist;
    [a,b]= size(X);
    NumInstance(i)= a;
    if(class == RuleSet(i).MaxClass)
        result(i) = 1;       
    else
        result(i) = 0;
    end
end

end

