%Preprocessing data

function Data_Array=preprocess_tic(filename)
%
%1. Create a hashmap for different attributes
featureMap = containers.Map();
featureMap('x')=[0 0 1];
featureMap('o')=[0 1 0];
featureMap('b')=[1 0 0];
featureMap('positive')=1;
featureMap('negative')=2;
%
%2.Read file
fileID=fopen(filename);
text=textscan(fileID,'%s'); %Entire data file
size_data=length(text{1}); %No of data examples
disp(size_data);

%
%3. Create Global data array to be returned.
%TicTacToe: Data array is N X 27 matrix. Label is N X 1 vector.

%Initialize global data array with all zeros
Data_Array=zeros(size_data,27);
%The label column vector of dimension N*1
Label_vector=zeros(size_data,1);

%
%4. Read file line by line
for i=1:size_data %for each training example
    line=text{1}{i};                    %Extract the whole line
    chars=strsplit(line,',');           % Split on ',' to obtain individual chars
    Label_vector(i,1)=featureMap(chars{length(chars)});
    for j=1:length(chars)-1               % For every character
        key=chars{j};                  %Every character is the key
        value=featureMap(key);          %Extract the corresponding value
        [r,c]=find(value);              %Find position of 1 in vector value
        k=(j-1)*3;
        Data_Array(i,k+c)=Data_Array(i,k+c)+1; %Update Global data array
    end
end
 fclose(fileID);       
 disp(Label_vector);
        
        
    