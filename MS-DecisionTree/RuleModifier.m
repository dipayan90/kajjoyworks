function [ RuleSetNew ] = RuleModifier( RuleSetNew )
%% This Section of the code is used to provide upper or lower bounds to all the cutoffs that have only a upper or only a lower bound
for i = 1:numel(RuleSetNew)
    j = 1;
    NumElements = numel(RuleSetNew(i).attributes);
    while(j<=NumElements)
        if(j~=NumElements)
            if(RuleSetNew(i).attributes(j)~=RuleSetNew(i).attributes(j+1))
                if(RuleSetNew(i).isGreater(j)==0)
                    num = numel(RuleSetNew(i).attributes);
                    temp1 = RuleSetNew(i).attributes(j+1:num);
                    temp2 = RuleSetNew(i).cutoff(j+1:num);
                    temp3 = RuleSetNew(i).isGreater(j+1:num);
                    
                    RuleSetNew(i).attributes = horzcat(RuleSetNew(i).attributes(1:j),RuleSetNew(i).attributes(j));
                    RuleSetNew(i).attributes = horzcat(RuleSetNew(i).attributes,temp1);
                    
                    RuleSetNew(i).cutoff = horzcat(RuleSetNew(i).cutoff(1:j),0);
                    RuleSetNew(i).cutoff = horzcat(RuleSetNew(i).cutoff,temp2);
                    
                    RuleSetNew(i).isGreater = horzcat(RuleSetNew(i).isGreater(1:j),1);
                    RuleSetNew(i).isGreater = horzcat(RuleSetNew(i).isGreater,temp3);
                elseif(RuleSetNew(i).isGreater(j)==1)
                    num = numel(RuleSetNew(i).attributes);
                    temp1 = RuleSetNew(i).attributes(j+1:num);
                    temp2 = RuleSetNew(i).cutoff(j+1:num);
                    temp3 = RuleSetNew(i).isGreater(j+1:num);
                    
                    RuleSetNew(i).attributes = horzcat(RuleSetNew(i).attributes(1:j),RuleSetNew(i).attributes(j));
                    RuleSetNew(i).attributes = horzcat(RuleSetNew(i).attributes,temp1);
                    
                    RuleSetNew(i).cutoff = horzcat(RuleSetNew(i).cutoff(1:j),10000);
                    RuleSetNew(i).cutoff = horzcat(RuleSetNew(i).cutoff,temp2);
                    
                    RuleSetNew(i).isGreater = horzcat(RuleSetNew(i).isGreater(1:j),0);
                    RuleSetNew(i).isGreater = horzcat(RuleSetNew(i).isGreater,temp3);
                end
            end
        end
        
        if(j==NumElements)
            RuleSetNew(i).attributes(j+1) = RuleSetNew(i).attributes(j);
            if(RuleSetNew(i).isGreater(j) == 0)
                RuleSetNew(i).isGreater(j+1) = RuleSetNew(i).isGreater(j);
                RuleSetNew(i).isGreater(j) = 1;
                RuleSetNew(i).cutoff(j+1) = RuleSetNew(i).cutoff(j);
                RuleSetNew(i).cutoff(j) = 0;
            elseif(RuleSetNew(i).isGreater(j) == 1)
                RuleSetNew(i).isGreater(j+1) = 0;
                RuleSetNew(i).cutoff(j+1) = 10000;
            end
        end
        j = j+2;
        NumElements = numel(RuleSetNew(i).attributes);
    end
end


%%

for i = 1:numel(RuleSetNew)
    j = 1;
    NumElements = numel(RuleSetNew(i).attributes);
    while(j<=NumElements)
        if(RuleSetNew(i).isGreater(j)<RuleSetNew(i).isGreater(j+1))
            var1 = RuleSetNew(i).isGreater(j);
            RuleSetNew(i).isGreater(j) = RuleSetNew(i).isGreater(j+1);
            RuleSetNew(i).isGreater(j+1) = var1;
            
            var2 = RuleSetNew(i).cutoff(j);
            RuleSetNew(i).cutoff(j) = RuleSetNew(i).cutoff(j+1);
            RuleSetNew(i).cutoff(j+1) = var2;
        end
        j = j+2;
    end
end

end

