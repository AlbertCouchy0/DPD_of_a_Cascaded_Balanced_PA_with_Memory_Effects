function FNN=FNN_train(x_i,x_q,y_i,y_q,M)
% 设置输入/输出矩阵，并设计网络
dim = length(x_i);
X = zeros(2*(M + 1), dim-M);
for j = 1:length(y_i) - M
    X(:, j) = [y_i(j : j + M); y_q(j : j + M)];
end
Y = [x_i(M + 1 : end)'; x_q(M + 1 : end)'];
net = feedforwardnet(20);% 神经元数量

FNN = train(net, X, Y);
end