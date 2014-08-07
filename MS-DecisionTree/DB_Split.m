function [db_1,db_2,cutoff] = DB_Split(db,att)
%This Function is used to divide the database based on the input Cutoff
%point and the attribute. 
[gain,cut] = Gain_values(db);
cutoff=cut(att*3);
if(max(unique(db(:,att)))== cutoff)
    index_top=find(db(:,att)==cutoff);
    index_bottom=find(db(:,att)<cutoff);
elseif(min(unique(db(:,att)))== cutoff)
    index_top=find(db(:,att)>cutoff);
    index_bottom=find(db(:,att)==cutoff);
else
    index_top=find(db(:,att)>cutoff);
    index_bottom=find(db(:,att)<=cutoff);
end
db_1=db(index_bottom,:);
db_2=db(index_top,:);
end

