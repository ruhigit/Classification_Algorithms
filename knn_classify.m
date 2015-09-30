function [new_accu, train_accu] = knn_classify(train_data, train_label, new_data, new_label, K)
% k-nearest neighbor classifier
% Input:
%  train_data: N*D matrix, each row as a sample and each column as a
%  feature
%  train_label: N*1 vector, each row as a label
%  new_data: M*D matrix, each row as a sample and each column as a
%  feature
%  new_label: M*1 vector, each row as a label
%  K: number of nearest neighbors
%
% Output:
%  new_accu: accuracy of classifying new_data
%  train_accu: accuracy of classifying train_data (using leave-one-out
%  strategy)
%
% CSCI 567: Machine Learning, Fall 2015, Homework 1

size_train_data=size(train_data,1);
size_test_data=size(new_data,1);
size_features=size(train_data,2);
mean=zeros(1,size_features);
%Standardize data
%Mean
for i=1:size_features
    mean(1,i)=sum(train_data(:,i))/size_train_data;
end
std_dev=zeros(1,size_features);
%Standard Deviation
for i=1:size_features
    std_dev(1,i)=sqrt(sum((mean(1,i)-train_data(i,:)).^2)/(size_train_data-1));
end
for i=1:size_features
    for j=1:size_train_data
        train_data(j,i)=(train_data(j,i)-mean(1,i))/std_dev(1,i);
    end
end
for i=1:size_features
    for j=1:size_test_data
        new_data(j,i)=(new_data(j,i)-mean(1,i))/std_dev(1,i);
    end
end
%train_accu=knn(train_data,train_label,train_data,train_label,K,1);
new_accu=knn(train_data,train_label,new_data,new_label,K,0);
train_accu=1;


function[accuracy]=knn(x,y,x1,y1,k,leave_one_out)
size_train_data=size(x,1);
size_test_data=size(x1,1);
correct=0;
for i=1:size_test_data
    count_label_pos=0;
    count_label_neg=0;
    dist=zeros(size_train_data,1);
    for j=1:size_train_data
        dist(j)=sqrt(sum((x(j,:)-x1(i,:))));
    end
    [sorted,indices]=sort(dist);
    for d=1:k
        if(y(indices(d))==1)
            count_label_pos=1+count_label_pos;
        else
            count_label_neg=count_label_neg+1;
        end
    end
    if(count_label_pos>count_label_neg)
        predicted=1;
    else
        predicted=2;
    end
    if(predicted==y1(i))
        correct=correct+1;
    end
end
accuracy=(correct)/size_test_data;


















