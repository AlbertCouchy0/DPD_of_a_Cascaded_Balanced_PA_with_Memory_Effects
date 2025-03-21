function [Data_matrix,dim]=ReadFile_Original()
% Data_matrix每一列对应的是
% Data_matrix=[Sys_x_i, Sys_x_q,...
%              PA1_x_i, PA1_x_q,...
%              PA2_x_i, PA2_x_q,...
%              PA3_x_i, PA3_x_q,...
%              PA4_x_i, PA4_x_q,...
%              PA3_y_i, PA3_y_q,...
%              PA4_y_i, PA4_y_q,...
%              Sys_y_i, Sys_y_q];
%% 读文件
fileID = fopen('Data_O\Sys_input_i.txt'); C = textscan(fileID, '%f'); Sys_input_i = C{1, 1}; fclose(fileID);
fileID = fopen('Data_O\Sys_input_q.txt'); C = textscan(fileID, '%f'); Sys_input_q = C{1, 1}; fclose(fileID);

fileID = fopen('Data_O\PA1_input_i.txt'); C = textscan(fileID, '%f'); PA1_input_i = C{1, 1}; fclose(fileID);
fileID = fopen('Data_O\PA1_input_q.txt'); C = textscan(fileID, '%f'); PA1_input_q = C{1, 1}; fclose(fileID);
fileID = fopen('Data_O\PA2_input_i.txt'); C = textscan(fileID, '%f'); PA2_input_i = C{1, 1}; fclose(fileID);
fileID = fopen('Data_O\PA2_input_q.txt'); C = textscan(fileID, '%f'); PA2_input_q = C{1, 1}; fclose(fileID);
fileID = fopen('Data_O\PA3_input_i.txt'); C = textscan(fileID, '%f'); PA3_input_i = C{1, 1}; fclose(fileID);
fileID = fopen('Data_O\PA3_input_q.txt'); C = textscan(fileID, '%f'); PA3_input_q = C{1, 1}; fclose(fileID);
fileID = fopen('Data_O\PA4_input_i.txt'); C = textscan(fileID, '%f'); PA4_input_i = C{1, 1}; fclose(fileID);
fileID = fopen('Data_O\PA4_input_q.txt'); C = textscan(fileID, '%f'); PA4_input_q = C{1, 1}; fclose(fileID);
fileID = fopen('Data_O\PA3_output_i.txt'); C = textscan(fileID, '%f'); PA3_output_i = C{1, 1}; fclose(fileID);
fileID = fopen('Data_O\PA3_output_q.txt'); C = textscan(fileID, '%f'); PA3_output_q = C{1, 1}; fclose(fileID);
fileID = fopen('Data_O\PA4_output_i.txt'); C = textscan(fileID, '%f'); PA4_output_i = C{1, 1}; fclose(fileID);
fileID = fopen('Data_O\PA4_output_q.txt'); C = textscan(fileID, '%f'); PA4_output_q = C{1, 1}; fclose(fileID);

fileID = fopen('Data_O\Sys_output_i.txt');C = textscan(fileID, '%f'); Sys_output_i = C{1, 1}; fclose(fileID);
fileID = fopen('Data_O\Sys_output_q.txt');C = textscan(fileID, '%f'); Sys_output_q = C{1, 1}; fclose(fileID);
%% 数据处理
dim = length(Sys_input_i) / 2;

[Sys_x_i, Sys_x_q,PA1_x_i, PA1_x_q,PA2_x_i, PA2_x_q, PA3_x_i, PA3_x_q,PA4_x_i, PA4_x_q,...
 PA3_y_i, PA3_y_q,PA4_y_i, PA4_y_q,Sys_y_i, Sys_y_q] = deal(zeros(dim, 1));
for k = 1:dim
    [Sys_x_i(k), Sys_x_q(k), Sys_y_i(k), Sys_y_q(k)] = deal(Sys_input_i(2 * k), Sys_input_q(2 * k), Sys_output_i(2 * k), Sys_output_q(2 * k));
    [PA1_x_i(k), PA1_x_q(k)]=deal(PA1_input_i(2 * k),PA1_input_q(2 * k));
    [PA2_x_i(k), PA2_x_q(k)]=deal(PA2_input_i(2 * k),PA2_input_q(2 * k));
    [PA3_x_i(k), PA3_x_q(k)]=deal(PA3_input_i(2 * k),PA3_input_q(2 * k));
    [PA4_x_i(k), PA4_x_q(k)]=deal(PA4_input_i(2 * k),PA4_input_q(2 * k));
    [PA3_y_i(k), PA3_y_q(k)]=deal(PA3_output_i(2 * k),PA3_output_q(2 * k));
    [PA4_y_i(k), PA4_y_q(k)]=deal(PA4_output_i(2 * k),PA4_output_q(2 * k));
end % 这么写的原因是因为其奇数位的数据为时间

Data_matrix=[Sys_x_i, Sys_x_q,...
             PA1_x_i, PA1_x_q,...
             PA2_x_i, PA2_x_q,...
             PA3_x_i, PA3_x_q,...
             PA4_x_i, PA4_x_q,...
             PA3_y_i, PA3_y_q,...
             PA4_y_i, PA4_y_q,...
             Sys_y_i, Sys_y_q];
end
