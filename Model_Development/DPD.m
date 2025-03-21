function output_sim=DPD(input,M,algorithm,path)
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
        DPD_output_m = sim(data.FNN,input_vector1);
        DPD_output = DPD_output_m(1,:) + 1j * DPD_output_m(2,:);
    case 2 % SVM
        input_vector = input_vector1';
        DPD_output_i = data.SVM_I.predictFcn(input_vector);
        DPD_output_q = data.SVM_Q.predictFcn(input_vector);
        DPD_output = DPD_output_i(:) + 1j * DPD_output_q(:);
        DPD_output = DPD_output.';
    case 3 % Tree
        input_vector = input_vector1';
        DPD_output_i = data.Tree_I.predictFcn(input_vector);
        DPD_output_q = data.Tree_Q.predictFcn(input_vector);
        DPD_output = DPD_output_i(:) + 1j * DPD_output_q(:);
        DPD_output = DPD_output.';
    case 4 % DNN
        DPD_output_m = predict(data.DNN,input_vector1);
        DPD_output = DPD_output_m(1,:) + 1j * DPD_output_m(2,:);
    case 5 % CNN
        DPD_output_m = predict(data.CNN,input_vector1);
        DPD_output = DPD_output_m(1,:) + 1j * DPD_output_m(2,:);
    case 6 % FCN
        DPD_output_m = predict(data.FCN,input_vector1);
        DPD_output = DPD_output_m(1,:) + 1j * DPD_output_m(2,:);
    case 7 % LSTM
        DPD_output_m = predict(data.LSTM,input_vector1);
        DPD_output = DPD_output_m(1,:) + 1j * DPD_output_m(2,:);
    case 8 % Bi-LSTM
        DPD_output_m = predict(data.Bi_LSTM,input_vector1);
        DPD_output = DPD_output_m(1,:) + 1j * DPD_output_m(2,:);
    case 9 % GRU
        DPD_output_m = predict(data.GRU,input_vector1);
        DPD_output = DPD_output_m(1,:) + 1j * DPD_output_m(2,:);
    case 10 % Simple-FCN
        DPD_output_m = predict(data.Simple_FCN,input_vector1);
        DPD_output = DPD_output_m(1,:) + 1j * DPD_output_m(2,:);

    case 11 % Simple-FCN_B2
        DPD_output_m = predict(data.Simple_FCN_B2,input_vector1);
        DPD_output = DPD_output_m(1,:) + 1j * DPD_output_m(2,:);
    case 12 % FNN_B5
        DPD_output_m = sim(data.FNN_B5,input_vector1);
        DPD_output = DPD_output_m(1,:) + 1j * DPD_output_m(2,:);
    otherwise
end
% 设置输出
output_sim=UnPack(DPD_output);
end