function tree = CreateTrees(X,NumCols,depth,accur,tree,DBName,Num_Class)
%This Function takes in a Dataset T and devides it into two LD and RD. The
%whole process of recursion takes place untill the accuracy is meet or the
%maximum depth level has reached.
persistent temp1;
if(isempty(temp1)==true)
temp1=zeros(100,1);
end
persistent count1;
if(isempty(count1)==true)
count1=ones(100,1);
end

persistent cutoffList;persistent attributeList;persistent isGreaterList;

[a,b,c]=Accuracy(X,Num_Class);
if(a>accur)
    fprintf('The Majority class in the database %s is Class: %d \n',DBName,b);
    tree.(DBName).depth(depth).class=b;
    tree.(DBName).depth(depth).probdist=c;
    return
end

[att]=InfoGain(X);
fprintf('The Depth of the tree is');
disp(depth);
if(att==0) %The DataBase can't be split further
    return
end

if((Accuracy(X,Num_Class)<accur) & (Accuracy(X,Num_Class)~=0)  & (X~=0)) 
[LD1,RD1,cutoff] = DB_Split(X,att);
flag1=(isempty(LD1) | isempty(RD1))
if(flag1==true)
    LD1=0;
    RD1=0;
end

[a,b,c]=Accuracy(LD1,Num_Class);
fprintf('The cutoff value on Depth(%d) for %s is %d \n',depth,DBName,cutoff);
fprintf('The attribute value on Depth(%d) for %s is %d \n',depth,DBName,att);
fprintf('Number of Rows on left split for Depth(%d) on %s is:%d \n',depth,DBName,numel(LD1)/NumCols);
fprintf('The Accuracy of the left split for Depth(%d) on %s is:%d \n',depth,DBName,a);
f1=0;
if(a>=accur)
    class=b;
    if(temp1(depth)==1)
        count1(depth)=count1(depth)+1;
    end
    tree.(DBName).depth(depth).left(count1(depth)).Lclass=b;  
    tree.(DBName).depth(depth).left(count1(depth)).probdist=c;
    cutoffList(depth)=cutoff;
    tree.(DBName).depth(depth).left(count1(depth)).cutoff=cutoff;  
    tree.(DBName).depth(depth).left(count1(depth)).cutoffList = cutoffList;
    attributeList(depth) = att;
    tree.(DBName).depth(depth).left(count1(depth)).attribute=att;
    tree.(DBName).depth(depth).left(count1(depth)).attributeList=attributeList;
    temp1(depth)=1;
    f1=1;
    fprintf('For a value lesser than "%d" for attribute "%d" the class predicted is: Class %d \n',cutoff,att,class); 
    LD1=0;
else
    tree.(DBName).depth(depth).left(count1(depth)).Lclass=0;  
   % isGreaterList(depth) = 0;
   % tree.(DBName).depth(depth).left(count1(depth)).isGreater=isGreaterList;
    cutoffList(depth)=cutoff;
    tree.(DBName).depth(depth).left(count1(depth)).cutoffList = cutoffList;
    attributeList(depth) = att;
    tree.(DBName).depth(depth).left(count1(depth)).attributeList=attributeList;
end

[a,b,c]=Accuracy(RD1,Num_Class);
fprintf('Number of Rows on Right split for Depth(%d) on D1 is:%d \n',depth,numel(RD1)/NumCols);
fprintf('The Accuracy of the Right split for Depth(%d) on D1 is:%d \n',depth,a);
fprintf('The attribute value on Depth(%d) for %s is %d \n',depth,DBName,att);
if(a>=accur)
    class=b;
    if(temp1(depth)==1 & f1~=1)
        count1(depth)=count1(depth)+1;
    end
    tree.(DBName).depth(depth).Right(count1(depth)).Rclass=b;
    tree.(DBName).depth(depth).Right(count1(depth)).probdist=c;
    cutoffList(depth)=cutoff;
    tree.(DBName).depth(depth).Right(count1(depth)).cutoff=cutoff; 
    tree.(DBName).depth(depth).Right(count1(depth)).cutoffList=cutoffList; 
    attributeList(depth) = att;
    tree.(DBName).depth(depth).Right(count1(depth)).attribute=att;
    tree.(DBName).depth(depth).Right(count1(depth)).attributeList=attributeList;
    temp1(depth)=1;
    f1=0;
    fprintf('For a value greater than "%d" for attribute "%d" the class predicted is: Class %d \n',cutoff,att,class); 
    RD1=0;
else
    tree.(DBName).depth(depth).Right(count1(depth)).Rclass=0;
%     isGreaterList(depth) = 1;
%     tree.(DBName).depth(depth).Right(count1(depth)).isGreater=isGreaterList;
    cutoffList(depth)=cutoff;
    tree.(DBName).depth(depth).Right(count1(depth)).cutoffList=cutoffList;
    attributeList(depth) = att;
    tree.(DBName).depth(depth).Right(count1(depth)).attributeList=attributeList;
end
else
LD1=0;
RD1=0;
end

depth=depth+1;
fprintf('For depth : (%d) the label is: %c',depth-1,'L');
isGreaterList(depth-1) = 0;
tree.(DBName).depth(depth-1).left(count1(depth-1)).isGreater=isGreaterList; 
tree = CreateTrees(LD1,NumCols,depth,accur,tree,DBName,Num_Class);


fprintf('For depth : (%d) the label is: %c',depth-1,'R');
isGreaterList(depth-1) = 1;
tree.(DBName).depth(depth-1).Right(count1(depth-1)).isGreater=isGreaterList;
tree = CreateTrees(RD1,NumCols,depth,accur,tree,DBName,Num_Class);
end

