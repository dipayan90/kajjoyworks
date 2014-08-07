function [RuleSet] = RulesCreator(Tree1,Tree2,Tree3)
%This is a Function located in the exchange whose sole objective is to
%create rules and create a Rule Exchange.

[t1Rows,t1cols] = size(Tree1.DB1.depth);
k = 1;
for i=1:t1cols
    for j=1:numel(Tree1.DB1.depth(i).left)
        if(Tree1.DB1.depth(i).left(j).Lclass~=0 | isempty(Tree1.DB1.depth(i).left(j).Lclass))
            RuleSet(k).probdist= Tree1.DB1.depth(i).left(j).probdist;
            RuleSet(k).MaxClass= Tree1.DB1.depth(i).left(j).Lclass;
            RuleSet(k).DBName = 'DB1';
            for l=1:i
            RuleSet(k).attributes(l)=Tree1.DB1.depth(i).left(j).attributeList(l);
            RuleSet(k).cutoff(l)=Tree1.DB1.depth(i).left(j).cutoffList(l);
            RuleSet(k).isGreater(l)= Tree1.DB1.depth(i).left(j).isGreater(l);
            end
            k = k+1;
        end
    end
end

for i=1:t1cols
 for j=1:numel(Tree1.DB1.depth(i).Right)
        if(Tree1.DB1.depth(i).Right(j).Rclass~=0)
            RuleSet(k).probdist= Tree1.DB1.depth(i).Right(j).probdist;
            RuleSet(k).MaxClass= Tree1.DB1.depth(i).Right(j).Rclass;
            RuleSet(k).DBName = 'DB1';
            for l=1:i
            RuleSet(k).attributes(l)=Tree1.DB1.depth(i).Right(j).attributeList(l);
            RuleSet(k).cutoff(l)=Tree1.DB1.depth(i).Right(j).cutoffList(l);
            RuleSet(k).isGreater(l)= Tree1.DB1.depth(i).Right(j).isGreater(l);
            end
            k = k + 1;
        end
 end
end

[t2Rows,t2cols] = size(Tree2.DB2.depth);

for i=1:t2cols
    for j=1:numel(Tree2.DB2.depth(i).left)
        if(Tree2.DB2.depth(i).left(j).Lclass~=0)
            RuleSet(k).probdist= Tree2.DB2.depth(i).left(j).probdist;
            RuleSet(k).MaxClass= Tree2.DB2.depth(i).left(j).Lclass;
            RuleSet(k).DBName = 'DB2';
            for l=1:i
            RuleSet(k).attributes(l)=Tree2.DB2.depth(i).left(j).attributeList(l);
            RuleSet(k).cutoff(l)=Tree2.DB2.depth(i).left(j).cutoffList(l);
            RuleSet(k).isGreater(l)= Tree2.DB2.depth(i).left(j).isGreater(l);
            end
            k = k+1;
        end
    end
end

for i=1:t2cols
 for j=1:numel(Tree2.DB2.depth(i).Right)
        if(Tree2.DB2.depth(i).Right(j).Rclass~=0)
            RuleSet(k).probdist= Tree2.DB2.depth(i).Right(j).probdist;
            RuleSet(k).MaxClass= Tree2.DB2.depth(i).Right(j).Rclass;  
            RuleSet(k).DBName = 'DB2';
            for l=1:i
            RuleSet(k).attributes(l)=Tree2.DB2.depth(i).Right(j).attributeList(l);
            RuleSet(k).cutoff(l)=Tree2.DB2.depth(i).Right(j).cutoffList(l);
            RuleSet(k).isGreater(l)= Tree2.DB2.depth(i).Right(j).isGreater(l);
            end
            k = k + 1;
        end
 end
end


[t3Rows,t3cols] = size(Tree3.DB3.depth);

for i=1:t3cols
    for j=1:numel(Tree3.DB3.depth(i).left)
        if(Tree3.DB3.depth(i).left(j).Lclass~=0)
            RuleSet(k).probdist= Tree3.DB3.depth(i).left(j).probdist;
            RuleSet(k).MaxClass= Tree3.DB3.depth(i).left(j).Lclass;
            RuleSet(k).DBName = 'DB3';
            for l=1:i
            RuleSet(k).attributes(l)=Tree3.DB3.depth(i).left(j).attributeList(l);
            RuleSet(k).cutoff(l)=Tree3.DB3.depth(i).left(j).cutoffList(l);
            RuleSet(k).isGreater(l)= Tree3.DB3.depth(i).left(j).isGreater(l);
            end
            k = k+1;
        end
    end
end

for i=1:t3cols
 for j=1:numel(Tree3.DB3.depth(i).Right)
        if(Tree3.DB3.depth(i).Right(j).Rclass~=0)
            RuleSet(k).probdist= Tree3.DB3.depth(i).Right(j).probdist;
            RuleSet(k).MaxClass= Tree3.DB3.depth(i).Right(j).Rclass;
            RuleSet(k).DBName = 'DB3';
            for l=1:i
            RuleSet(k).attributes(l)=Tree3.DB3.depth(i).Right(j).attributeList(l);
            RuleSet(k).cutoff(l)=Tree3.DB3.depth(i).Right(j).cutoffList(l);
            RuleSet(k).isGreater(l)= Tree3.DB3.depth(i).Right(j).isGreater(l);
            end
        end
 end
end
end

