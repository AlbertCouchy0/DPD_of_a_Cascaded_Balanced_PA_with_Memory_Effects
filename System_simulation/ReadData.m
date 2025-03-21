function [C,R,I]=ReadData(type,path)

switch type
    case 1 % 有时间戳的文件
        % 打开文件
        fid = fopen(path);
        data = textscan(fid, '%f %s %s %s %*[^\n]');
        fclose(fid);
        % 提取第二列的复数字符串
        realStr = data{2};
        opStr = data{3};
        imagStr = data{4};
    otherwise % 无时间戳的文件
        % 打开文件
        fid = fopen(path);
        data = textscan(fid, '%s %s %s %*[^\n]');
        fclose(fid);
        % 提取第一列的复数字符串
        realStr = data{1};
        opStr = data{2};
        imagStr = data{3};
end

% 预处理
realNumbers = zeros(size(realStr));
imagNumbers = zeros(size(imagStr));
for i = 1:numel(realStr)
    % 移除字符串中的所有空格
    str_r = strrep(realStr{i}, ' ', '');
    str_i = strrep(imagStr{i}, ' ', '');
    % 转换为复数
    realNumbers(i) = str2double(str_r);
    if opStr{i} == '+'
        imagNumbers(i) = str2double(str_i);
    elseif opStr{i} == '-'
        imagNumbers(i) = -str2double(str_i);
    end
end

% 合成
R = realNumbers;
I = imag(imagNumbers);
C = realNumbers + imagNumbers ;

end