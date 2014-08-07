function [ RuleStackFinal ] = LocalRuleCreator( LocalRule,DB_Num,Num_Class,NumInst,count,D1,D2,D3,Modification )
%Tweeks the rules ranges and creates new rules if the New rule formed has
%an higher metric value than its current metric value.

Allowed_Incoming_error = 2;

if(DB_Num == 1)
    DB = D1;
    DB_Name = 'DB1';
elseif(DB_Num == 2)
    DB = D2;
    DB_Name = 'DB2';
else
    DB= D3;
    DB_Name = 'DB3';
end

InitialRuleCopy = LocalRule;

% calculates the metric value of the rule DB picks up.
[ result,probdist,siz ] = RulesValidator(LocalRule,DB,Num_Class);
probability = probdist.prob(LocalRule.MaxClass);
Metric= ((((probability)/100)*((siz)/(NumInst/3))) * (( ((probability)/100)*(siz))/count(LocalRule.MaxClass)))*10000;
Incoming_Error = 100 - probability;
%Metric gives the initial Metric.
k = 1;
%DB decides to add Modification% to the cutoff value.
for j=1:numel(LocalRule.cutoff)
    LocalRule.cutoff(j) = LocalRule.cutoff(j) + ((Modification)/100)* LocalRule.cutoff(j);
    [ result,probdist,siz ] = RulesValidator(LocalRule,DB,Num_Class);
    probability = probdist.prob(LocalRule.MaxClass);
    Metric_temp= ((((probability)/100)*((siz)/(NumInst/3))) * (( ((probability)/100)*(siz))/count(LocalRule.MaxClass)))*10000;
    New_Error = 100 - probability;
    Prob_Diff = New_Error - Incoming_Error; % Calculates how much error the change in cutoff is taking in. [ Very important for a good rule]
    if(Metric_temp>Metric)
        if(Prob_Diff < Allowed_Incoming_error)
            RuleStack(k) = LocalRule;
            RuleStack(k).DBName = DB_Name; %DB puts modified rule to the rule stack
            k = k+1;
        end
    end
    LocalRule = InitialRuleCopy; %Reset the Rules back
    
    %DB Picks ups the rules and substracts Modification% from
    %cutoff value
    LocalRule.cutoff(j) = LocalRule.cutoff(j) - ((Modification)/100)* LocalRule.cutoff(j);
    [ result,probdist,siz ] = RulesValidator(LocalRule,DB,Num_Class);
    probability = probdist.prob(LocalRule.MaxClass);
    Metric_temp= ((((probability)/100)*((siz)/(NumInst/3))) * (( ((probability)/100)*(siz))/count(LocalRule.MaxClass)))*10000;
    New_Error = 100 - probability;
    Prob_Diff = New_Error - Incoming_Error; % Calculates how much error the change in cutoff is taking in. [ Very important for a good rule]
    if(Metric_temp>Metric)
        if(Prob_Diff < Allowed_Incoming_error)
            RuleStack(k) = LocalRule;
            RuleStack(k).DBName = DB_Name; %DB puts modified rule to the rule stack
            k = k+1;
        end
    end
    LocalRule = InitialRuleCopy;%Reset the Rules back
end
if(k>1)
    RuleStackFinal = RuleStack;
else
    RuleStackFinal = struct();
end
end

