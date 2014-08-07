function [ MetricNew,RuleSetNew,SizeDBNew,ProbDistNew,ResultNew ] = RulesRemover( RuleSet,Metric,SizeDB,ProbDist,Result,value )
%This function removes rules from the ruleset based on input value of the
%metric provided by user.

%NewMetric,NewRuleSet,NewSizeDB,NewProbDist,NewResult
point = 1;
[m,c] = size(Metric);

for i = 1:c
    if(Metric(5,i)>=value)
        Selected(point) = i;
        point = point + 1;
    end
end

for i = 1: numel(Selected)
    RuleSetNew(i) = RuleSet(Selected(i));
    MetricNew(:,i) = Metric(:,Selected(i));
    SizeDBNew(:,i) = SizeDB(:,Selected(i));
    ProbDistNew(:,i) = ProbDist(:,Selected(i));
    ResultNew(:,i) = Result(:,Selected(i));
end

i = 1;
while(i<=numel(RuleSetNew))
    if(numel(find(ResultNew(:,i)==0))==2 | numel(find(ResultNew(:,i)==0))==3 )
        RuleSetNew(i)=[];
        MetricNew(:,i) =[];
        SizeDBNew(:,i) = [];
        ProbDistNew(:,i) = [];
        ResultNew(:,i) = [];
    else
        i = i+1;
    end
end
        
end

