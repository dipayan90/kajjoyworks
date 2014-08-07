function [RuleSetNew] = RuleCombiner( RuleSetNew,Num_Class )
%This function goes through all the RuleSetNew and finds out overlapping
%ranges of cutoff for elements belonging to same attributeset. It resolves
%these rule conflicts by making a union. If union is not possible then it
%is left as it is.

k = 1;
for i =1:numel(RuleSetNew)-1
    if(RuleSetNew(i).att~=RuleSetNew(i+1).att)
        Gaps(k)=i;
        k = k+1;
    end
end
Gaps = horzcat(0,Gaps);
Gaps = horzcat(Gaps,numel(RuleSetNew));

NumRules = numel(RuleSetNew);
for k = 1:numel(Gaps)-1
    if(Gaps(k+1)-Gaps(k)>1)
        p=1;
        NumClass = zeros(Gaps(k+1)-Gaps(k),1);
        for j=(Gaps(k)+1):Gaps(k+1)
            NumClass(p) = RuleSetNew(j).MaxClass;
            p = p+1;
        end
        for i =1:Num_Class
            if(numel(find(NumClass == i))>1)
                Classes = find(NumClass == i);
                Classes = Classes + (Gaps(k));
                Dissimilarity = zeros(numel(Classes));
                for j = 1:numel(Classes)
                    for l = 1:numel(Classes)
                        Dissimilarity(j,l) = numel(find(RuleSetNew(Classes(j)).cutoff ~= RuleSetNew(Classes(l)).cutoff));
                    end
                end
                for j = 1:numel(Classes)
                    similar = find(Dissimilarity(j,:)==min(nonzeros(Dissimilarity(j,:))));
                    similar = Classes(similar);
                    r = 1;
                    while(r<=numel(similar))
                        m = 1;
                        NumRules = NumRules+1;
                        RuleSetNew(NumRules) = RuleSetNew(Classes(j));
                        while ( m<=numel(RuleSetNew(Gaps(k)+j).cutoff))
                            set1 = RuleSetNew(Classes(j)).cutoff(m:m+1);
                            set2 = RuleSetNew(similar(r)).cutoff(m:m+1);
                            RuleSetNew(Classes(j)).isNew = 'False';
                            RuleSetNew(similar(r)).isNew = 'False';
                            combine = union(set1,set2);
                            set = [min(combine) max(combine)];
                            RuleSetNew(NumRules).cutoff(m)=set(1);
                            RuleSetNew(NumRules).cutoff(m+1)=set(2);
                            RuleSetNew(NumRules).isNew = 'yes';
                            m = m+2;
                        end
                        r = r+1;
                    end
                    % NumRules = NumRules + 1;
                end
            end
        end
        
    end
end
end

