function V=ReadV(path)
% 打开文件
fid = fopen(path);
data = textscan(fid, '%f %*[,]');
fclose(fid);
% 提取第二列的复数字符串
V = data{1};
V=V';
end