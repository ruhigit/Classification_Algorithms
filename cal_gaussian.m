function[result]=cal_gaussian(x_train,x_test,h)
%The kernel density estimaton
%x takes values from x_given
%h takes 5 values
train_size_iid=length(x_train);    %The size of dataset
test_size_iid=length(x_test);
result=zeros(test_size_iid,1); %The result matrix for KDE
deno=sqrt(2*pi);
for i=1:test_size_iid
    x=x_test(i);
    addition=0;
    for j=1:train_size_iid
        x_i=x_train(j);
        z=(x-x_i)^2;
        u=z/(h^2);
        exponent=exp(u*(-1/2));
        term=exponent/deno;
        addition=addition+term;
    end
        addition=addition/(train_size_iid*h);
        result(i,1)=addition;
end
