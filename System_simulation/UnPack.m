function output=UnPack(input)
% 实现功能：把行向量转成列向量
dim=length(input);
output=zeros(dim,1);
for i=1:dim
    output(i)=input(i);
end
end