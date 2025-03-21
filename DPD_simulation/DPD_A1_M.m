function output_sim=DPD_A1_M(input,M)
dim=length(input);
input_vector1=zeros(2*(M+1),dim);

for i=1:M+1
    input_vector1(i,:) = real(Pack( Delay(input,M+1-i) ));
    input_vector1(i+M+1,:) = imag(Pack( Delay(input,M+1-i) ));
end

data = load('Algorithm_A\NN.mat');
DPD_output_m = sim(data.trained_net,input_vector1);
DPD_output_m = double(DPD_output_m);
DPD_output = DPD_output_m(1,:) + 1j * DPD_output_m(2,:);

% 设置输出
output_sim=UnPack(DPD_output);
end