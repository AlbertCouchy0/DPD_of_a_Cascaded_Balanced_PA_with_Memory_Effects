function CNN=CNN_train(x_i,x_q,y_i,y_q,M)
% 设置输入/输出矩阵，并设计网络

dim = length(x_i);
X = zeros(2*(M + 1), dim-M);
for j = 1:length( y_i) - M
    X(:, j) = [ y_i(j : j + M);  y_q(j : j + M)];
end
Y = [ x_i(M + 1 : end)';  x_q(M + 1 : end)'];
layers = [
    sequenceInputLayer(2*(M + 1),"Name","sequence")
    convolution1dLayer(3,32,"Name","conv1d_1","Padding","same")
    reluLayer("Name","relu_1")
    averagePooling1dLayer(5,"Name","avgpool1d_1","Padding","same")
    convolution1dLayer(3,64,"Name","conv1d_2","Padding","same")
    reluLayer("Name","relu_2")
    averagePooling1dLayer(5,"Name","avgpool1d_2","Padding","same")
    convolution1dLayer(3,32,"Name","conv1d_3","Padding","same")
    reluLayer("Name","relu_3")
    averagePooling1dLayer(5,"Name","avgpool1d_3","Padding","same")
    fullyConnectedLayer(16,"Name","fc_1")
    fullyConnectedLayer(8,"Name","fc_2")
    fullyConnectedLayer(2,"Name","fc_3")
    regressionLayer("Name","regressionoutput")];

% 调整参数，并训练模型
% 更多细节可见：https://ww2.mathworks.cn/help/deeplearning/ref/trainingoptions.html
num = 7000;
X_Validation = X(:, num:end);
Y_Validation = Y(:, num:end);
maxEpochs = 1600;
miniBatchSize = 512;
options = trainingOptions('adam', ...
    'MaxEpochs', maxEpochs, ...                         % 最大训练轮次
    'MiniBatchSize', miniBatchSize, ...                 % 单次迭代（iteration）使用的数据量
    'InitialLearnRate', 0.003, ...                      % 初始学习率
    'GradientThreshold', 1, ...                         % 梯度裁剪阈值，防止梯度爆炸
    'ValidationData', {X_Validation, Y_Validation}, ... % 验证数据集，用于监控模型泛化性能。
    'ValidationFrequency', 80, ...                      % 验证频率
    'ValidationPatience',5,...                          % 若验证损失连续 10 次未改善，则提前停止训练。
    'Shuffle', 'every-epoch', ...                       % 是否打乱数据顺序
    'Plots', 'training-progress', ...                   % 实时绘制训练损失和验证损失曲线
    'ExecutionEnvironment', 'multi-gpu', ...            % 训练环境
    'LearnRateSchedule', 'piecewise', ...               % 学习率衰减策略（此处为分段衰减）
    'LearnRateDropFactor', 0.5, ...                     % 学习率衰减因子
    'LearnRateDropPeriod', 600, ...                     % 学习率衰减周期
    'Verbose', 1, ...                                   % 是否输出日志
    'VerboseFrequency', 1000);                          % 命令行日志输出频率

% 'Plots', 'none', ...
% 'Shuffle','never', ...

CNN = trainNetwork(X(:, 1:num), Y(:, 1:num), layers, options);
end