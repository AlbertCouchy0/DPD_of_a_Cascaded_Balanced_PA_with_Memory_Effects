function [Sys_x_i,Sys_x_q,Sys_y_i,Sys_y_q,dim]=ReadFile_Model(type)
%% 读系统的输入输出
switch type
    case 'A'
    fileID = fopen('Data_M_A\Sys_input_i.txt'); C = textscan(fileID, '%f'); Sys_input_i = C{1, 1}; fclose(fileID);
    fileID = fopen('Data_M_A\Sys_input_q.txt'); C = textscan(fileID, '%f'); Sys_input_q = C{1, 1}; fclose(fileID);
    fileID = fopen('Data_M_A\Sys_output_i.txt');C = textscan(fileID, '%f'); Sys_output_i = C{1, 1}; fclose(fileID);
    fileID = fopen('Data_M_A\Sys_output_q.txt');C = textscan(fileID, '%f'); Sys_output_q = C{1, 1}; fclose(fileID);
    case 'B'
    fileID = fopen('Data_M_B\Sys_input_i.txt'); C = textscan(fileID, '%f'); Sys_input_i = C{1, 1}; fclose(fileID);
    fileID = fopen('Data_M_B\Sys_input_q.txt'); C = textscan(fileID, '%f'); Sys_input_q = C{1, 1}; fclose(fileID);
    fileID = fopen('Data_M_B\Sys_output_i.txt');C = textscan(fileID, '%f'); Sys_output_i = C{1, 1}; fclose(fileID);
    fileID = fopen('Data_M_B\Sys_output_q.txt');C = textscan(fileID, '%f'); Sys_output_q = C{1, 1}; fclose(fileID);
    otherwise 
end
dim = length(Sys_input_i) / 2;
[Sys_x_i, Sys_x_q, Sys_y_i, Sys_y_q] = deal(zeros(dim, 1));
for k = 1:dim
    [Sys_x_i(k), Sys_x_q(k)] = deal(Sys_input_i(2 * k), Sys_input_q(2 * k));
    [Sys_y_i(k), Sys_y_q(k)] = deal(Sys_output_i(k), Sys_output_q(k));
end % 这么写的原因是因为其奇数位的数据为时间

end
