function [Error_Before,Error_After] = Main(accur,D1,D2,D3,D,Test)
%Main function to execute the program. 
fprintf('Welcome to decision tree creation wizard \n');
fprintf('The decision tree is being created \n');
%[D1,D2,D3,D,Test] = DB_Create(DB_input);
%[D1,D2,D3,D,Test] = DB_Create_Extreme(DB_input);
[m,c]=size(D);
Num_Class = numel(unique(D(:,c)));
fprintf('Data Insights \n\n');
fprintf('Number of instances(Rows)in Database: %d \n',m);
fprintf('Number of Attributes ( Columns ) in the DataBase: %d \n',c);
fprintf('Number of classes in the database are: %d \n',Num_Class);
X=D(:,c);

for i = 1: Num_Class
    count(i) = sum(X==i);
end

for i = 1: Num_Class
    fprintf('The Number of Class %d elements are: %d \n',i,count(i));
end
%accur=input('Please Enter the amount of accuracy in \n terms of percentage you would like to have');
depth=1; label = 1;
fprintf('Initial Accuracy of D1,D2 and D3 are %d,%d,%d respectively',Accuracy(D1,Num_Class),Accuracy(D2,Num_Class),Accuracy(D3,Num_Class));
tree=struct;
[Tree1] = CreateTrees(D1,c,depth,accur,tree,'DB1',Num_Class);
[Tree2] = CreateTrees(D2,c,depth,accur,tree,'DB2',Num_Class);
[Tree3] = CreateTrees(D3,c,depth,accur,tree,'DB3',Num_Class);
save Tree1;
save Tree2;
save Tree3;
[RuleSet] = RulesCreator(Tree1,Tree2,Tree3);
[RuleSet] = SortRules(RuleSet);
[RuleSet ] = RuleSimplifier ( RuleSet );
[ RuleSet ] = DuplicateRemover( RuleSet );
save RuleSet
[AttributeSet] = AttributesInvolved ( RuleSet,c );
save RuleSet
save AttributeSet
[result1,probdist1,num1] = RulesValidator(RuleSet,D1,Num_Class);
[result2,probdist2,num2] = RulesValidator(RuleSet,D2,Num_Class);
[result3,probdist3,num3] = RulesValidator(RuleSet,D3,Num_Class);

result= [result1;result2;result3];
probDist = [probdist1;probdist2;probdist3];
SizeDB = [num1;num2;num3];
[ Metric ] = MetricCalculator(SizeDB,probDist,m,RuleSet,count,result);
% save result;
% save probDist;
% save SizeDB;
%save Metric;
[ RuleSet,Metric,SizeDB,ProbDist,Result ] = GroupRules (RuleSet,Metric,SizeDB,probDist,result,AttributeSet);
[Metric] = CombinedMetric(Metric,SizeDB);


save Result;
save probDist;
save SizeDB;
save Metric;
save RuleSet;
RulesViewer(RuleSet,SizeDB);
%[ Index,NewMetric,NewRuleSet,NewSizeDB,NewProbDist,NewResult ] = RulePruner(Metric,RuleSet,SizeDB,ProbDist,Result);
value = 1;
tic;
[ MetricNew,RuleSetNew,SizeDBNew,ProbDistNew,ResultNew ] = RulesRemover( RuleSet,Metric,SizeDB,ProbDist,Result,value );
save MetricNew;
save RuleSetNew;
save SizeDBNew;
save ProbDistNew;
save ResultNew; 
[ MetricNew,RuleSetNew,SizeDBNew,ProbDistNew,ResultNew] = MergeRules( RuleSetNew,Num_Class,count,m,c,D1,D2,D3 );
[ MetricNew,RuleSetNew,SizeDBNew,ProbDistNew,ResultNew] = OldRulesRemover( RuleSetNew,MetricNew,SizeDBNew,ProbDistNew,ResultNew);
save MetricNew;
save RuleSetNew;
save SizeDBNew;
save ProbDistNew;
save ResultNew; 

%Before the Negotiation Process:
[result,ProbabilityDistribution,SizeDBs] = RulesValidator(RuleSetNew,Test,Num_Class);
[ Error_Before ] = ErrorCalculator( result,ProbabilityDistribution,SizeDBs, RuleSetNew );
disp('Error Before negotiation')
disp(Error_Before)
disp('Result before negotitation, Number of 1s')
disp(numel(find(result==1)))

Modification = 3; % percentage change in the cutoff values.
%[RuleSetNew,ResultNew,MetricNew,SizeDBNew ] = Negotiator( RuleSetNew,ResultNew,MetricNew,Num_Class,m,count,D1,D2,D3,Modification );
[ RuleSetNew] = NegotiationEngine( RuleSetNew,ResultNew,MetricNew,Num_Class,m,count,D1,D2,D3,Modification );
%[ MetricNew,SizeDBNew,probDistNew,ResultNew ] = RulePerformance( RuleSet,Num_Class,count,m,c,D1,D2,D3 );

%After the Negotiation Process:
[result,ProbabilityDistribution,SizeDBs] = RulesValidator(RuleSetNew,Test,Num_Class);
[ Error_After ] = ErrorCalculator( result,ProbabilityDistribution,SizeDBs, RuleSetNew );
disp('Error After negotiation')
disp(Error_After)
disp('Result After negotitation, Number of 1s')
disp(numel(find(result==1)))
endTime = toc;
disp('End time is');
disp(endTime);
pause(5);
save MetricNew;
save RuleSetNew;
save SizeDBNew;
save ProbDistNew;
save ResultNew; 
%RulesViewer(RuleSetNew,SizeDBNew);
%[ ErrorCount ] = CalculateError(Test,RuleSetNew);
disp('Program Finished')
end


