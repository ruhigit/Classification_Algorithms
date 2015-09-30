function[var]=histogram_h(h)
load('hw1progde.mat')
data = x_te;
permuted = data(randperm(length(data)));
n = 19;
subsets = reshape(permuted, n, length(data)/n);
stepsize=1/49;
test_data=0:stepsize:1;

intermediate_histogram=zeros(19,50);
for i=1:19
    intermediate_histogram(i,:)=cal_histogram(subsets(i,:),test_data,h);
end
%Calculate variance
%Mean
mean=zeros(1,19);
for i=1:19
    mean(1,i)=sum(intermediate_histogram(i,:))/50;
end
variance=zeros(1,19);
for i=1:19
    variance(1,i)=sum((mean(1,i)-test_data(1,:)).^2)/50;
end
var=sum(variance(1,:))/19;