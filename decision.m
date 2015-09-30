function[Accuracy_gdi,Accuracy_cross] = decision(x,y,x1,y1)
%Vary min leaf from 1..10
Accuracy_gdi=zeros(1,10);
for i=1:10
    tree=ClassificationTree.fit(x,y,'SplitCriterion','gdi','Prune','off','MinLeaf',i);
    Loss=loss(tree,x1,y1);
    Accuracy_gdi(i)=1-Loss;
end
Accuracy_cross=zeros(1,10);
for i=1:10
    tree=ClassificationTree.fit(x,y,'SplitCriterion','deviance','Prune','off','MinLeaf',i);
    Loss=loss(tree,x1,y1);
    Accuracy_cross(i)=1-Loss;
end
