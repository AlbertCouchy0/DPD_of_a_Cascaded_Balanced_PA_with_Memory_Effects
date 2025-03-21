function output=Pack(input)
% 实现功能：把列向量转成行向量
dim=length(input);
output=zeros(1,dim);
for i=1:dim
    output(i)=input(i);
end
end