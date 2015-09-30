function[result]=cal_histogram(x_train,x_test,h)
total_x=length(x_train);
min_x=min(x_train);
max_x=max(x_train);
width=max_x-min_x;
no_of_bins=ceil(width/h);
probability_of_bin=zeros(1,no_of_bins);
%Calculate the probability of each bin
start=min_x;
finish=start+h;
for i=1:no_of_bins
    no_of_points=length(find(x_train>=start & x_train<finish));
    probability_of_bin(1,i)=(no_of_points/(total_x*width));
    start=finish;
    finish=start+h;
end
%Output the probabilities of test data
size_test=length(x_test);
result=zeros(size_test,1);
for i=1:size_test
    %Determine which bin it belongs to
    new_point_bin=ceil((x_test(i)-min_x)/h);
    if(new_point_bin<1)
        new_point_bin=1;
    elseif(new_point_bin>no_of_bins)
        new_point_bin=no_of_bins;
    end
    result(i,1)=probability_of_bin(1,new_point_bin);
end
