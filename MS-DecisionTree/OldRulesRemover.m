function [  MetricNew,RuleSetNew,SizeDBNew,ProbDistNew,ResultNew  ] = OldRulesRemover( RuleSetNew,MetricNew,SizeDBNew,ProbDistNew,ResultNew)
%This function removes the rules that have already been merged.
i = 1;
while(i<=numel(RuleSetNew))
    if(~isempty(RuleSetNew(i).isNew))
        if(strcmp(RuleSetNew(i).isNew,'False'))
        RuleSetNew(i)=[];
        MetricNew(:,i) =[];
        SizeDBNew(:,i) = [];
        ProbDistNew(:,i) = [];
        ResultNew(:,i) = [];
        else
            i = i+1;
        end   
    else
        i = i+1;
    end
end


end

