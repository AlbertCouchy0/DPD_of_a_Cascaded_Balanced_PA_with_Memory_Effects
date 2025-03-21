function output=Delay(input,N)

dim = length(input);
output = zeros(dim,1);
for i=1:dim-N
    output(i+N)=input(i);
end

end