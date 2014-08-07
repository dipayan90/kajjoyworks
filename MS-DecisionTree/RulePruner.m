function [ Index,NewMetric,NewRuleSet,NewSizeDB,NewProbDist,NewResult ] = RulePruner(Metric,RuleSet,SizeDB,ProbDist,Result)
%This function takes the Metric output as the input. It then foes through
%each of the same attribute values and records it Metric values and stores
%only the highest from each attribute set. This function return the indexes
%of one of each attribute set.
k = 1;
for i =1:(numel(Metric)/5)-1
    if(Metric(4,i)~=Metric(4,i+1))
        Gaps(k)=i;
        k = k+1;
    end
end

k = 1;
for i = 1: numel(Gaps)
    Max = 0;
    if(isempty(Gaps)==1)
        error('All the rules have same attributes');
    end
    if(i~=numel(Gaps))
        if(i==1)
             for j = 1:Gaps(1)
            Avg = (Metric(1,j)+Metric(2,j)+Metric(3,j))/3;
            if(Avg>Max)
                Max = Avg;
                change(k)= j;
            end
        end
        end
    if((Gaps(i+1)-Gaps(i)~=1))
        for j = (Gaps(i)+1):Gaps(i+1)
            Avg = (Metric(1,j)+Metric(2,j)+Metric(3,j))/3;
            if(Avg>Max)
                Max = Avg;
                change(k)= j;
            end
        end
        if(isnan(Avg))
            temp(k) = j;
        end
        k = k+1;
    end
    elseif(i==numel(Gaps))
        for j = (Gaps(i)+1):(numel(Metric)/5)
            Avg = (Metric(1,j)+Metric(2,j)+Metric(3,j))/3;
            if(Avg>Max)
                Max = Avg;
                change(k)= j;
            end
        end
    end
    
end

for i = 1:numel(change)
    if(change(i)==0)
        change(i) = temp(i);
    end
end

disp('change')
disp(change)
disp('Gaps')
disp(Gaps)

j = 1;
for i=1:numel(Gaps)
    if(i ~=1)
        if(Gaps(i)-Gaps(i-1)~=1)
            if(Index(i-1)==change(1))
                Index(i) = Gaps(i);
            else
            Index(i) = change(j);
            end
            j = j+1;
        else
            Index(i) = Gaps(i);
        end
    else
        if(Gaps(i)>change(i))
            Index(i) = change(i);
        else
        Index(i) = Gaps(i);
        end
    end
    if(i==numel(Gaps) & (change(j)>Gaps(i)))
      Index(i+1) = change(j);
    end
end
disp('Index is:')
disp(Index)
for i = 1:numel(Index)
    NewMetric(:,i) = Metric(:,Index(i));
    NewRuleSet(i) = RuleSet(Index(i));
    NewSizeDB(:,i)=SizeDB(:,Index(i));
    NewProbDist(:,i) = ProbDist(:,Index(i));
    NewResult(:,i)=Result(:,Index(i));
end



end


