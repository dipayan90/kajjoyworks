function [ RuleSet ] = RuleSimplifier ( RuleSet )
%This function takes the ruleset as input and removes anomilies from rules.
%It is basically used in scenatios where we have att1>5 and att1>6 we write
%it as att1>6
for i=1:numel(RuleSet)
    [c,ia,ib]=unique(RuleSet(i).attributes);
    if(ia(1)~=1)
        ia = cat(1,0,ia')';
    end
    if(numel(RuleSet(i).attributes)~=ia(numel(ia)))
        ia = cat(1,ia',numel(RuleSet(i).attributes))';
    end
    
    k=1;
    while(k<=(numel(ia)-1))
        p=1;
        q=1;
        A = zeros(1,15);
        B = [1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000];
        if((ia(k+1)-ia(k))>1)
        for j=(ia(k)+1):ia(k+1)
            if(RuleSet(i).isGreater(j)==1)
                A(p)= RuleSet(i).cutoff(j);
                p=p+1;
            else
                B(q)= RuleSet(i).cutoff(j);
                q=q+1;
            end
        end 
        end
        c1=max(A);        
        c2=min(B);
        ind1=find(RuleSet(i).cutoff==c1);
        ind2=find(RuleSet(i).cutoff==c2);
        if((c1~=0) | (c2~=1000))
        for j=(ia(k)+1):ia(k+1)
            if(isempty(ind1))
                ind1=20;
            end
            if(isempty(ind2))
                ind2=20;
            end
            try
            if((ind1 == j) | (ind2 == j))
                RuleSet(i).cutoff(j)=RuleSet(i).cutoff(j);
                RuleSet(i).isGreater(j)=RuleSet(i).isGreater(j);
                RuleSet(i).attributes(j)=RuleSet(i).attributes(j);  
            else
                RuleSet(i).cutoff(j)=0;
                RuleSet(i).isGreater(j)=0;
                RuleSet(i).attributes(j)=0;       
            end
            catch err
                disp(err)
            end
        end
        end
        k = k+1;
    end        
end

for i = 1:numel(RuleSet)
    j = numel(RuleSet(i).attributes);
    while(j>0)
        if(RuleSet(i).attributes(j) == 0)
            RuleSet(i).attributes(j) = [];
            RuleSet(i).cutoff(j) = [];
            RuleSet(i).isGreater(j) = [];
            j = j-1;
        else
            j = j-1;
        end
    end
end
        
        


end

