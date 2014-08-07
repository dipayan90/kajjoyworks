function [ RuleSetNew] = NegotiationEngine( RuleSetNew,ResultNew,MetricNew,Num_Class,NumInst,count,D1,D2,D3,Modification )
%[ RuleSetNew,ResultNew,MetricNew,SizeDBNew ]
%This is the main class that performs the task of negotiation so that all
%the three datasets are happy with the rules created. This would in-turn
%help in generating better rules.

%Every cutoff value is tweaked 10% +/- and seen if that results in a better
%rule. Modification is the value that is set for changing the cutoff. It is
%a percentage value

%Telling the Algorithm which databases need to agree
for i=1:numel(RuleSetNew)
    [ RuleStack ] = Negotiate( RuleSetNew(i),Num_Class,NumInst,count,D1,D2,D3,Modification );
    
    iter = 1;
    while(iter<5)
        if(~isempty(fieldnames(RuleStack)))
            ptr = 1;
            flag = 0;
            for j = 1:numel(RuleStack)
                if(~isempty(RuleStack(j).DBName))
                    [ RuleDump ] = Negotiate( RuleStack(j),Num_Class,NumInst,count,D1,D2,D3,Modification );
                    if(~isempty(fieldnames(RuleDump)))
                        NewStack(ptr).Rules = RuleDump; %New RuleStacks being generated.
                        ptr = ptr+1;
                        flag = 1;
                    end
                end
            end
            
            if(flag==1)
                if(numel(NewStack)>ptr)
                    while ((ptr+1)<=numel(NewStack))
                        NewStack(ptr+1) = [];
                    end
                end
                
                
                k = 1;
                for j =1:numel(NewStack)
                    for p = 1:numel(NewStack(j).Rules)
                        GeneratedStack(k) = NewStack(j).Rules(p);
                        k = k+1;
                    end
                end
                
                if(numel(GeneratedStack)>k)
                    while ((k+1)<=numel(GeneratedStack))
                        GeneratedStack(k+1) = [];
                    end
                end
                RuleStack = GeneratedStack;
            end
        end
        iter = iter+1;
    end
    % RuleStack is the final set of rules obtained after negotiation of the
    % rule. Once this is done, we choose the rule that has the maximum
    % weighted average Metric value.
    
    if(~isempty(fieldnames(RuleStack)))
        [result1,probdist1,num1] = RulesValidator(RuleStack,D1,Num_Class);
        [result2,probdist2,num2] = RulesValidator(RuleStack,D2,Num_Class);
        [result3,probdist3,num3] = RulesValidator(RuleStack,D3,Num_Class);
        
        result= [result1;result2;result3];
        probDist = [probdist1;probdist2;probdist3];
        SizeDB = [num1;num2;num3];
        [ Metric ] = MetricCalculator(SizeDB,probDist,NumInst,RuleStack,count,result);
        [ Metric ] = CombinedMetric( Metric,SizeDB );
        [C,I] = max(Metric(5,:));
        RuleSetNew(i) = RuleStack(I(1));
    end
end

end

