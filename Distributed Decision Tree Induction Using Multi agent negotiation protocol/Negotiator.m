function [RuleSetNew,ResultNew,MetricNew,SizeDBNew ] = Negotiator( RuleSetNew,ResultNew,MetricNew,Num_Class,NumInst,count,D1,D2,D3,Modification )

%This is the main class that performs the task of negotiation so that all
%the three datasets are happy with the rules created. This would in-turn
%help in generating better rules.

%Every cutoff value is tweaked 10% +/- and seen if that results in a better
%rule. Modification is the value that is set for changing the cutoff. It is
%a percentage value

k = 1;
for i=1:numel(RuleSetNew)
    selected(k) = i;
    k = k +1;
end

for i=1:numel(selected)
    LocalRules(i) = RuleSetNew(selected(i));
end

for i =1:numel(selected)
    if(strcmp(RuleSetNew(i).DBName,'DB1')==1)
        selectedDB(i,1)=2;
        selectedDB(i,2)=3;
    end
    
    if(strcmp(RuleSetNew(i).DBName,'DB2')==1)
        selectedDB(i,1)=1;
        selectedDB(i,2)=3;
    end
    
    
    if(strcmp(RuleSetNew(i).DBName,'DB3')==1)
        selectedDB(i,1)=1;
        selectedDB(i,2)=2;
    end
end

for i=1:numel(selected)
    contin = 1;
    iter = 0;
    while((contin ~= 0) && (iter<=100))
        k = 1;
        flag = 0;
        for j=1:numel(RuleSetNew(selected(i)).cutoff)
            LocalRules(i) = RuleSetNew(selected(i));
            LocalRules(i).cutoff(j) = LocalRules(i).cutoff(j) + ((Modification)/100)* LocalRules(i).cutoff(j);
            for a =1:2 %running through the other 2 databases. The ones from which the rule has not come from.
                if(selectedDB(i,a)==1)
                    [ result,probdist,siz ] = RulesValidator((LocalRules(i)),D1,Num_Class);
                    probability = probdist.prob(LocalRules(i).MaxClass);
                    Metric= ((((probability)/100)*((siz)/(NumInst/3))) * (( ((probability)/100)*(siz))/count(LocalRules(i).MaxClass)))*10000;
                    if(Metric > MetricNew(selectedDB(i,a),selected(i)))
                        [ result1,probdist1,siz1 ] = RulesValidator((LocalRules(i)),D2,Num_Class);
                        [ result2,probdist2,siz2 ] = RulesValidator((LocalRules(i)),D3,Num_Class);
                        probability1 = probdist1.prob(LocalRules(i).MaxClass);
                        probability2 = probdist2.prob(LocalRules(i).MaxClass);
                        Metric1= ((((probability1)/100)*((siz1)/(NumInst/3))) * (( ((probability1)/100)*(siz1))/count(LocalRules(i).MaxClass)))*10000;
                        Metric2= ((((probability2)/100)*((siz2)/(NumInst/3))) * (( ((probability2)/100)*(siz2))/count(LocalRules(i).MaxClass)))*10000;
                        if((Metric1>=MetricNew(2,selected(i))) && (Metric2>=MetricNew(3,selected(i))))
                            RuleStack(k) = LocalRules(i);
                            results(k,:) = [result,result1,result2];
                            merit(k,:) = [Metric,Metric1,Metric2];
                            sizes(k,:) = [siz,siz1,siz2];
                            flag = 1;
                            k = k+1;
                        end
                    end
                end
                
                if(selectedDB(i,a)==2)
                    [ result,probdist,siz ] = RulesValidator((LocalRules(i)),D2,Num_Class);
                    probability = probdist.prob(LocalRules(i).MaxClass);
                    Metric= ((((probability)/100)*((siz)/(NumInst/3))) * (( ((probability)/100)*(siz))/count(LocalRules(i).MaxClass)))*10000;
                    if(Metric > MetricNew(selectedDB(i,a),selected(i)))
                        [ result1,probdist1,siz1 ] = RulesValidator((LocalRules(i)),D1,Num_Class);
                        [ result2,probdist2,siz2 ] = RulesValidator((LocalRules(i)),D3,Num_Class);
                        probability1 = probdist1.prob(LocalRules(i).MaxClass);
                        probability2 = probdist2.prob(LocalRules(i).MaxClass);
                        Metric1= ((((probability1)/100)*((siz1)/(NumInst/3))) * (( ((probability1)/100)*(siz1))/count(LocalRules(i).MaxClass)))*10000;
                        Metric2= ((((probability2)/100)*((siz2)/(NumInst/3))) * (( ((probability2)/100)*(siz2))/count(LocalRules(i).MaxClass)))*10000;
                        if((Metric1>=MetricNew(1,selected(i))) && (Metric2>=MetricNew(3,selected(i))))
                            RuleStack(k) = LocalRules(i);
                            results(k,:) = [result,result1,result2];
                            merit(k,:) = [Metric,Metric1,Metric2];
                            sizes(k,:) = [siz,siz1,siz2];
                            flag = 1;
                            k = k+1;
                        end
                    end
                end
                
                if(selectedDB(i,a)==3)
                    [ result,probdist,siz ] = RulesValidator((LocalRules(i)),D3,Num_Class);
                    probability = probdist.prob(LocalRules(i).MaxClass);
                    Metric= ((((probability)/100)*((siz)/(NumInst/3))) * (( ((probability)/100)*(siz))/count(LocalRules(i).MaxClass)))*10000;
                    if(Metric > MetricNew(selectedDB(i,a),selected(i)))
                        [ result1,probdist1,siz1 ] = RulesValidator((LocalRules(i)),D1,Num_Class);
                        [ result2,probdist2,siz2 ] = RulesValidator((LocalRules(i)),D2,Num_Class);
                        probability1 = probdist1.prob(LocalRules(i).MaxClass);
                        probability2 = probdist2.prob(LocalRules(i).MaxClass);
                        Metric1= ((((probability1)/100)*((siz1)/(NumInst/3))) * (( ((probability1)/100)*(siz1))/count(LocalRules(i).MaxClass)))*10000;
                        Metric2= ((((probability2)/100)*((siz2)/(NumInst/3))) * (( ((probability2)/100)*(siz2))/count(LocalRules(i).MaxClass)))*10000;
                        if((Metric1>=MetricNew(1,selected(i))) && (Metric2>=MetricNew(2,selected(i))))
                            RuleStack(k) = LocalRules(i);
                            results(k,:) = [result,result1,result2];
                            merit(k,:) = [Metric,Metric1,Metric2];
                            sizes(k,:) = [siz,siz1,siz2];
                            flag = 1;
                            k = k+1;
                        end
                    end
                end
            end
            LocalRules(i).cutoff = RuleSetNew(selected(i)).cutoff;
            LocalRules(i).cutoff(j) = LocalRules(i).cutoff(j) - ((Modification)/100)* LocalRules(i).cutoff(j);
            
            for a=1:2
                if(selectedDB(i,a)==1)
                    [ result,probdist,siz ] = RulesValidator((LocalRules(i)),D1,Num_Class);
                    probability = probdist.prob(LocalRules(i).MaxClass);
                    Metric= ((((probability)/100)*((siz)/(NumInst/3))) * (( ((probability)/100)*(siz))/count(LocalRules(i).MaxClass)))*10000;
                    if(Metric > MetricNew(selectedDB(i,a),selected(i)))
                        [ result1,probdist1,siz1 ] = RulesValidator((LocalRules(i)),D2,Num_Class);
                        [ result2,probdist2,siz2 ] = RulesValidator((LocalRules(i)),D3,Num_Class);
                        probability1 = probdist1.prob(LocalRules(i).MaxClass);
                        probability2 = probdist2.prob(LocalRules(i).MaxClass);
                        Metric1= ((((probability1)/100)*((siz1)/(NumInst/3))) * (( ((probability1)/100)*(siz1))/count(LocalRules(i).MaxClass)))*10000;
                        Metric2= ((((probability2)/100)*((siz2)/(NumInst/3))) * (( ((probability2)/100)*(siz2))/count(LocalRules(i).MaxClass)))*10000;
                        if((Metric1>=MetricNew(2,selected(i))) && (Metric2>=MetricNew(3,selected(i))))
                            
                            RuleStack(k) = LocalRules(i);
                            results(k,:) = [result,result1,result2];
                            merit(k,:) = [Metric,Metric1,Metric2];
                            sizes(k,:) = [siz,siz1,siz2];
                            flag = 1;
                            k = k+1;
                            
                        end
                    end
                end
                
                if(selectedDB(i,a)==2)
                    [ result,probdist,siz ] = RulesValidator((LocalRules(i)),D2,Num_Class);
                    probability = probdist.prob(LocalRules(i).MaxClass);
                    Metric= ((((probability)/100)*((siz)/(NumInst/3))) * (( ((probability)/100)*(siz))/count(LocalRules(i).MaxClass)))*10000;
                    if(Metric > MetricNew(selectedDB(i,a),selected(i)))
                        [ result1,probdist1,siz1 ] = RulesValidator((LocalRules(i)),D1,Num_Class);
                        [ result2,probdist2,siz2 ] = RulesValidator((LocalRules(i)),D3,Num_Class);
                        probability1 = probdist1.prob(LocalRules(i).MaxClass);
                        probability2 = probdist2.prob(LocalRules(i).MaxClass);
                        Metric1= ((((probability1)/100)*((siz1)/(NumInst/3))) * (( ((probability1)/100)*(siz1))/count(LocalRules(i).MaxClass)))*10000;
                        Metric2= ((((probability2)/100)*((siz2)/(NumInst/3))) * (( ((probability2)/100)*(siz2))/count(LocalRules(i).MaxClass)))*10000;
                        if((Metric1>=MetricNew(1,selected(i))) && (Metric2>=MetricNew(3,selected(i))))
                            
                            RuleStack(k) = LocalRules(i);
                            results(k,:) = [result,result1,result2];
                            merit(k,:) = [Metric,Metric1,Metric2];
                            sizes(k,:) = [siz,siz1,siz2];
                            flag = 1;
                            k = k+1;
                            
                        end
                    end
                end
                
                if(selectedDB(i,a)==3)
                    [ result,probdist,siz ] = RulesValidator((LocalRules(i)),D3,Num_Class);
                    probability = probdist.prob(LocalRules(i).MaxClass);
                    Metric= ((((probability)/100)*((siz)/(NumInst/3))) * (( ((probability)/100)*(siz))/count(LocalRules(i).MaxClass)))*10000;
                    if(Metric > MetricNew(selectedDB(i,a),selected(i)))
                        [ result1,probdist1,siz1 ] = RulesValidator((LocalRules(i)),D1,Num_Class);
                        [ result2,probdist2,siz2 ] = RulesValidator((LocalRules(i)),D2,Num_Class);
                        probability1 = probdist1.prob(LocalRules(i).MaxClass);
                        probability2 = probdist2.prob(LocalRules(i).MaxClass);
                        Metric1= ((((probability1)/100)*((siz1)/(NumInst/3))) * (( ((probability1)/100)*(siz1))/count(LocalRules(i).MaxClass)))*10000;
                        Metric2= ((((probability2)/100)*((siz2)/(NumInst/3))) * (( ((probability2)/100)*(siz2))/count(LocalRules(i).MaxClass)))*10000;
                        if((Metric1>=MetricNew(1,selected(i))) && (Metric2>=MetricNew(2,selected(i))))
                            
                            RuleStack(k) = LocalRules(i);
                            results(k,:) = [result,result1,result2];
                            merit(k,:) = [Metric,Metric1,Metric2];
                            sizes(k,:) = [siz,siz1,siz2];
                            flag = 1;
                            k = k+1;
                            
                        end
                    end
                end
            end
        end
        
        
        if(flag ==1 & (results~=0))
            
            [ RuleStack,DuplicateRule ] = DuplicateRemover( RuleStack );
            k = numel(RuleStack);
            
            if(DuplicateRule~=0)
                for ptr=1:numel(DuplicateRule)
                    results(DuplicateRule(ptr),:) = [0;0;0];
                    merit(DuplicateRule(ptr),:) = [0;0;0];
                    sizes(DuplicateRule(ptr),:) = [0;0;0];
                end
                
                ptr = 1;
                limit = numel(results)/3;
                while(ptr<=limit)
                    if(results(ptr,:)==0)
                        results(ptr,:) = [];
                        merit(ptr,:) = [];
                        sizes(ptr,:) = [];
                        limit = limit-1;
                    else
                        ptr= ptr+1;
                    end
                end
            end
            
            if(numel(RuleStack)>k)
                while ((k+1)<=numel(RuleStack))
                    RuleStack(k+1) = [];
                    results(k+1,:) = [];
                    merit(k+1,:) = [];
                    sizes(k+1,:) = [];
                end
            end
            [m,c] = size(merit);
            for p = 1:m
                totalSize(p) = 0;
                ts = numel(totalSize);
                NetMerit(p) = 0;
                nm = numel(NetMerit);
                if(ts>k)
                    totalSize(k+1:ts) = [];
                    NetMerit(k+1:nm) = [];
                end
            end
            
            disp('totalSize')
            disp(totalSize)
            
            disp('NetMerit')
            disp(NetMerit)
            for p=1:m
                for q = 1:c
                    totalSize(p) = totalSize(p) + sizes(p,q);
                end
            end
            
            for p = 1:m
                for q = 1:c
                    NetMerit(p) = NetMerit(p) +  ((sizes(p,q)/totalSize(p)) * merit(p,q));
                end
            end
            
            for p=1:numel(RuleStack)
                %                 if(numel(find(results(p,:)==1))==3)
                %                     disp('dipayan')
                %                     RuleSetNew(selected(i)) = RuleStack(p);
                %
                %                     MeritNew(1,selected(i)) = merit(p,1);
                %                     MeritNew(2,selected(i)) = merit(p,2);
                %                     MeritNew(3,selected(i)) = merit(p,3);
                %                     MeritNew(5,selected(i)) = NetMerit(p);
                %
                %                     contin = 0;
                %                     break;
                %                 else
                [a,b] = max(NetMerit);
                RuleSetNew(selected(i)) = RuleStack(b);
                
                MetricNew(1,selected(i)) = merit(b,1);
                MetricNew(2,selected(i)) = merit(b,2);
                MetricNew(3,selected(i)) = merit(b,3);
                MetricNew(5,selected(i)) = NetMerit(b);
                
                ResultNew(1,selected(i)) = results(b,1);
                ResultNew(2,selected(i)) = results(b,2);
                ResultNew(3,selected(i)) = results(b,3);
                
                SizeDBNew(1,selected(i)) = sizes(b,1);
                SizeDBNew(2,selected(i)) = sizes(b,2);
                SizeDBNew(3,selected(i)) = sizes(b,3);
                
                iter = iter+1;
                contin = 0;
                % end
            end
        end
        iter = 101;
    end
end
end




