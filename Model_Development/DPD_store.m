function output_sim=DPD_Extra(input,M,algorithm,path)
% algorithm：1-FNN;2-SVM;3-DNN;
dim=length(input);
input_vector1=zeros(2*(M+1),dim);

for i=1:M+1
    input_vector1(i,:) = real(Pack( Delay(input,M+1-i) ));
    input_vector1(i+M+1,:) = imag(Pack( Delay(input,M+1-i) ));
end

data = load(path);

switch algorithm
    case 1 % FNN
        DPD_output_m = sim(data.model,input_vector1);
        DPD_output = DPD_output_m(1,:) + 1j * DPD_output_m(2,:);
    case 2 % SVM
        input_vector = input_vector1';
        DPD_output_i = data.model_i.predictFcn(input_vector);
        DPD_output_q = data.model_q.predictFcn(input_vector);
        DPD_output = DPD_output_i(:) + 1j * DPD_output_q(:);
        DPD_output = DPD_output.';
    otherwise
        DPD_output_m = predict(data.model,input_vector1);
        DPD_output = DPD_output_m(1,:) + 1j * DPD_output_m(2,:);
end
% 设置输出
output_sim=UnPack(DPD_output);
end