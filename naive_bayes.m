function [new_accu, train_accu] = naive_bayes(train_data, train_label, new_data, new_label)
% naive bayes classifier
% Input:
%  train_data: N*D matrix, each row as a sample and each column as a
%  feature
%  train_label: N*1 vector, each row as a label
%  new_data: M*D matrix, each row as a sample and each column as a
%  feature
%  new_label: M*1 vector, each row as a label
%
% Output:
%  new_accu: accuracy of classifying new_data
%  train_accu: accuracy of classifying train_data 
%
% CSCI 567: Machine Learning, Fall 2015, Homework 1

%The total no of examples:
size_dataset=length(train_label);
total_features=size(train_data,2);

%Calculate the priors for each class label
[frequency,label]=hist(train_label,unique(train_label)); %Label has the classes and corresponding frequency count of each class in dataset
total_classes=size(label,1);                       %Total no of classes
prior = frequency/size_dataset;                         %probability of each class

model=zeros(total_classes,total_features);
%Count the number of times a feature shows up for each class
for i=1:total_classes
    class=label(i);                                    %For each class
    for j=1:total_features                             %For each feature 
        k=find(train_label==class);                    %Find all rows that has class i
        count_feature=sum(train_data(k,j)==1); %for each column j of those selected rows,add the no of 1's
        model(i,j)=count_feature/frequency(i);
        if(model(i,j)==0)
            model(i,j)=0.1;
        end
    end 
end
new_accu=classify(train_label,model,new_data,new_label);
train_accu=classify(train_label,model,train_data,train_label);

function[accu]=classify(train_label,model,new_data,new_label)
size_dataset=length(train_label);
%Calculate the priors for each class label
[frequency,label]=hist(train_label,unique(train_label)); %Label has the classes and corresponding frequency count of each class in dataset
total_classes=size(label,1);                       %Total no of classes
prior = frequency/size_dataset;                         %probability of each class
%Classify data
total_testfeatures=size(new_data,2);
total_testeg=length(new_label);
predictedLabels=zeros(total_testeg,1);
for t=1:total_testeg
    prob=zeros(1,total_classes);
    for i=1:total_classes
        prob_f_given_c=1;
        for j=1:total_testfeatures
            if(new_data(t,j)==1)
                    prob_j=model(i,j);
                prob_f_given_c=prob_f_given_c*prob_j;
            end
        end
        prob(i)=prior(i)*prob_f_given_c;
    end
    %Assign the class with the highest posterior probability
    [max_prob, class_index] = max(prob);
    predictedLabels(t) = label(class_index);
end
 accu = sum(predictedLabels == new_label)/total_testeg;


