function [x_o_i, x_o_q, y_o_i, y_o_q]=DataProcess(input_i,input_q,output_i,output_q)

dim = length(input_i) / 2;
[x_o_i, x_o_q, y_o_i, y_o_q] = deal(zeros(dim, 1));
for k = 1:dim
    [x_o_i(k), x_o_q(k), y_o_i(k), y_o_q(k)] = deal(input_i(2 * k), input_q(2 * k), output_i(2 * k), output_q(2 * k));
end 
% 这么写的原因是因为其奇数位的数据为时间

end