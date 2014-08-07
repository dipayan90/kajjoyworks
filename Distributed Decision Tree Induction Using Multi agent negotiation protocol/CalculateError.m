function [ ErrorCount ] = CalculateError(D,RuleSet)
%This function takes in the Rule set finally generated and the Test
%database. It compares the class of the test database with the class
%predicted by a matching rule and computes the error.

[inst,att] = size(D);
att = att-1;
ErrorCount = 0;
for i = 1:inst
    for j = 1: att
        for k = 1 : numel (RuleSet)
            % m = 1;
            att_pre = find(RuleSet(k).attributes ==j);
            if(~isempty(att_pre))
                %                 for l = 1:2
                %                     if(RuleSet(k).isGreater(att_pre(l))==1)
                %                         if(D(i,j) >= RuleSet(k).cutoff(att_pre(l)))
                %                             satisfaction(k).values(m) = 1;
                %                             m = m+1;
                %                         else
                %                             satisfaction(k).values(m) = 0;
                %                             m = m+1;
                %                         end
                %                     else
                %                         if(D(i,j) < RuleSet(k).cutoff(att_pre(l)))
                %                             satisfaction(k).values(m) = 1;
                %                             m = m+1;
                %                         else
                %                             satisfaction(k).values(m) = 0;
                %                             m = m+1;
                %                         end
                %                     end
                %                 end
                l = 1;
                if(RuleSet(k).isGreater(att_pre(l))==1)
                    if((D(i,j) >= RuleSet(k).cutoff(att_pre(l)))  & (D(i,j) < RuleSet(k).cutoff(att_pre(l+1))))
                        try
                            m = numel(satisfaction(k).values)+1;
                        catch err
                            disp(err);
                            m = 1;
                        end
                        satisfaction(k).values(m) = 1;
                    else
                        try
                            m = numel(satisfaction(k).values)+1;
                        catch err
                            disp(err);
                            m = 1;
                        end
                        satisfaction(k).values(m) = 0;
                    end
                else
                    if(RuleSet(k).isGreater(att_pre(l))==0)
                        if((D(i,j) < RuleSet(k).cutoff(att_pre(l)))  & (D(i,j) >= RuleSet(k).cutoff(att_pre(l+1))))
                            try
                                m = numel(satisfaction(k).values)+1;
                            catch err
                                disp(err);
                                m = 1;
                            end
                            satisfaction(k).values(m) = 1;
                        else
                            try
                                m = numel(satisfaction(k).values)+1;
                            catch err
                                disp(err);
                                m = 1;
                            end
                            satisfaction(k).values(m) = 0;
                        end
                    end
                end
            end
        end
    end
    
    ptr = 1;
    for j=1: numel(RuleSet)
        if(~any(satisfaction(j).values == 0))
            prob_rules(ptr) = j;
            ClassArray(ptr) = RuleSet(j).MaxClass;
            ptr = ptr+1;
        end
    end
    
    Class = mode(ClassArray);
    
    if(D(i,att+1) ~= Class)
        ErrorCount = ErrorCount + 1;
    end
end

disp('Errors in test DB is')
disp(ErrorCount)
end

