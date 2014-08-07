function [ Metric,SizeDB,probDist,result ] = RulePerformance( RuleSet,Num_Class,count,m,c,D1,D2,D3 )
%After Negotiation Shows how good the rules have become
[result1,probdist1,num1] = RulesValidator(RuleSet,D1,Num_Class);
[result2,probdist2,num2] = RulesValidator(RuleSet,D2,Num_Class);
[result3,probdist3,num3] = RulesValidator(RuleSet,D3,Num_Class);
[AttributeSet] = AttributesInvolved ( RuleSet,c );
result= [result1;result2;result3];
probDist = [probdist1;probdist2;probdist3];
SizeDB = [num1;num2;num3];
[ Metric ] = MetricCalculator(SizeDB,probDist,m,RuleSet,count,result);
[ RuleSet,Metric,SizeDB,ProbDist,Result ] = GroupRules (RuleSet,Metric,SizeDB,probDist,result,AttributeSet);
[Metric] = CombinedMetric(Metric,SizeDB);
end

