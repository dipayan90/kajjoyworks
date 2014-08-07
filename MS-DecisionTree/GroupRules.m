function [ Ruleset,Metric,SizeDB,ProbDist,Result ] = GroupRules (Ruleset,Metric,SizeDB,ProbDist,Result,AttributeSet)
%This Function groups the table based on attributes present in the rules.
%This function basicaly is used to group all the rules having same
%attributes in their path.

[C,ia,ib]= unique(AttributeSet,'rows');
disp('C')
disp(C)

for i=1:numel(Ruleset)
Ruleset(i).att = ib(i);
end
Afields = fieldnames(Ruleset);
Acell = struct2cell(Ruleset);
sz = size(Acell);
disp(sz)

Acell = reshape(Acell, sz(1), []); 
Acell = Acell';      
Acell = sortrows(Acell, 7);
Acell = reshape(Acell', sz);
Asorted = cell2struct(Acell, Afields, 1);
Ruleset=Asorted;

Metric = Metric';
Metric(:,4)=ib';
Metric = sortrows(Metric,4);
Metric = Metric';
disp(Metric)

SizeDB = SizeDB';
SizeDB(:,4) = ib';
SizeDB = sortrows(SizeDB,4);
SizeDB=SizeDB';
disp(SizeDB)

for i=1:3
    for j = 1:(numel(ProbDist)/3)
    ProbDist(i,j).att = ib(j);
    end
end
Bfields = fieldnames(ProbDist);
Bcell = struct2cell(ProbDist);
sz = size(Bcell);
disp(sz)

Bcell = reshape(Bcell, sz(1), []); 
Bcell = Bcell';      
Bcell = sortrows(Bcell, 2);
Bcell = reshape(Bcell', sz);
Bsorted = cell2struct(Bcell, Bfields, 1);
ProbDist=Bsorted;

Result=Result';
Result(:,4) = ib';
Result = sortrows(Result,4);
Result=Result';
disp(Result)

end

