function output_sim=DPD_M(input,M,algorithm)
% algorithm：1-FNN;2-SVM;3-DNN;
dim=length(input);
input_vector1=zeros(2*(M+1),dim);

for i=1:M+1
    input_vector1(i,:) = real(Pack( Delay(input,M+1-i) ));
    input_vector1(i+M+1,:) = imag(Pack( Delay(input,M+1-i) ));
end

DPD_output_m = predict(algorithm,input_vector1);
DPD_output = DPD_output_m(1,:) + 1j * DPD_output_m(2,:);

% 设置输出
output_sim=UnPack(DPD_output);
end