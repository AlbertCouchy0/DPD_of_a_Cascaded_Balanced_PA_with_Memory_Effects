function output=DPD_A1(input,M)
% 设置输入
DPD_input = input;
DPD_input_d1 = Delay(input,1);
DPD_input_d2 = Delay(input,2);

DPD_input=Pack(DPD_input);
DPD_input_d1=Pack(DPD_input_d1);
DPD_input_d2=Pack(DPD_input_d2);

% Example for DPD Validation
input_vector1 = [real(DPD_input_d2);
    real(DPD_input_d1);
    real(DPD_input);
    imag(DPD_input_d2);
    imag(DPD_input_d1);
    imag(DPD_input)];% 实部+虚部，维数一共2*(M+1)

data = load('Algorithm_A\NN.mat');
DPD_output_m = sim(data.trained_net,input_vector1);
DPD_output_m = double(DPD_output_m);
DPD_output = DPD_output_m(1,:) + 1j * DPD_output_m(2,:);

% 设置输出
output=UnPack(DPD_output);
end