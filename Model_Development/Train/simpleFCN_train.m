function Simple_FCN=simpleFCN_train(x_i,x_q,y_i,y_q,M)
% 设置输入/输出矩阵，并设计网络
dim = length(x_i);
X = zeros(2*(M + 1), dim-M);
for j = 1:length( y_i) - M
    X(:, j) = [ y_i(j : j + M);  y_q(j : j + M)];
end
Y = [ x_i(M + 1 : end)';  x_q(M + 1 : end)'];

% 调整参数，并训练模型
% 更多细节可见：https://ww2.mathworks.cn/help/deeplearning/ref/trainingoptions.html
layers = [
    sequenceInputLayer(2*(M + 1),"Name","sequence")
    fullyConnectedLayer(32,"Name","fc_1")
    reluLayer("Name","relu_1")
    fullyConnectedLayer(64,"Name","fc_2")
    reluLayer("Name","relu_2")
    fullyConnectedLayer(128,"Name","fc_3")
    reluLayer("Name","relu_3")
    fullyConnectedLayer(64,"Name","fc_4")
    reluLayer("Name","relu_4")
    fullyConnectedLayer(32,"Name","fc_5")
    reluLayer("Name","relu_5")
    fullyConnectedLayer(16,"Name","fc_6")
    reluLayer("Name","relu_6")
    fullyConnectedLayer(8,"Name","fc_7")
    fullyConnectedLayer(4,"Name","fc_8")
    fullyConnectedLayer(2,"Name","fc_9")
    regressionLayer("Name","regressionoutput")];

num = 6000;
X_Validation = X(:, num:end);
Y_Validation = Y(:, num:end);
maxEpochs = 1200;
miniBatchSize = 256;
options = trainingOptions('adam', ...
    'MaxEpochs', maxEpochs, ...                         % 最大训练轮次
    'MiniBatchSize', miniBatchSize, ...                 % 单次迭代（iteration）使用的数据量
    'InitialLearnRate', 0.003, ...                      % 初始学习率
    'GradientThreshold', 1, ...                         % 梯度裁剪阈值，防止梯度爆炸
    'ValidationData', {X_Validation, Y_Validation}, ... % 验证数据集，用于监控模型泛化性能。
    'ValidationFrequency', 80, ...                     % 验证频率
    'ValidationPatience',5,...                          % 若验证损失连续 5 次未改善，则提前停止训练。
    'Shuffle', 'every-epoch', ...                       % 是否打乱数据顺序
    'Plots', 'training-progress', ...                   % 实时绘制训练损失和验证损失曲线
    'ExecutionEnvironment', 'multi-gpu', ...            % 训练环境
    'LearnRateSchedule', 'piecewise', ...               % 学习率衰减策略（此处为分段衰减）
    'LearnRateDropFactor', 0.5, ...                     % 学习率衰减因子
    'LearnRateDropPeriod', 600, ...                     % 学习率衰减周期
    'Verbose', 1, ...                                   % 是否输出日志
    'VerboseFrequency', 1000);                          % 命令行日志输出频率

%'ValidationPatience',5,...                          % 若验证损失连续 5 次未改善，则提前停止训练。
% 'Plots', 'none', ...
% 'Shuffle','never', ...

Simple_FCN = trainNetwork(X(:, 1:num), Y(:, 1:num), layers, options);

end