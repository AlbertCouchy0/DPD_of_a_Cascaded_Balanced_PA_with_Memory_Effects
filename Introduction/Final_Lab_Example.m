%% DPD Extraction

% EXAMPLE for How to Extract DPD Models in Matlab
%%  Read Input/Output Signal from txt File

clc; 
clear all;

% Read txt file
fileID = fopen('input_i.txt'); C = textscan(fileID, '%f'); input_i = C{1, 1}; fclose(fileID);
fileID = fopen('input_q.txt'); C = textscan(fileID, '%f'); input_q = C{1, 1}; fclose(fileID);
fileID = fopen('output_i.txt');C = textscan(fileID, '%f'); output_i = C{1, 1}; fclose(fileID);
fileID = fopen('output_q.txt');C = textscan(fileID, '%f'); output_q = C{1, 1}; fclose(fileID);
dim = length(input_i) / 2;
[x_i, x_q, y_i, y_q] = deal(zeros(dim, 1));
for k = 1:dim 
    [x_i(k), x_q(k), y_i(k), y_q(k)] = deal(input_i(2 * k), input_q(2 * k), output_i(2 * k), output_q(2 * k));
end

% Input/Output complex signal
x_sync_01 = x_i + 1j * x_q;
y_sync_01 = y_i + 1j * y_q;

%%  -----------------------------Example I : Feedforward Neural Network----------------------------

% Set Input/Output Matrix
M=2; % Memory Depth
X1 = zeros(2*(M + 1), dim-M);
for j = 1:length(y_i) - M
    X1(:, j) = [y_i(j : j + M); y_q(j : j + M)];
end
Y = [x_i(M + 1 : end)'; x_q(M + 1 : end)'];

% Adjust Parameters and Train Models
net = feedforwardnet(5 ); 
trained_net = train(net, X1, Y);

% Check Modeling Performance and Save Models
Y_pred = sim(trained_net, X1);
a = Y_pred(1, :) + Y_pred(2, :) * 1i;
b = Y(1, :) + Y(2, :) * 1i;
nmse_db = NMSE_dB(a, b)
save('NN.mat', 'trained_net');
%%  ------------------------------Example II : Regression Learner APP------------------------------

%%  Set Input/Output Matrix  
M=2; % Memory Depth
X = zeros(2*(M + 1), dim-M);
for j = 1:length(y_i) - M
    X(:, j) = [y_i(j : j + M); y_q(j : j + M)];
end
X = X.';
Y_i = x_i(M + 1 : end);
Y_q = x_q(M + 1 : end);
XY = [X, Y_i, Y_q];

%%  Train Models in App and Export to Workspace

%%  Check Modeling Performance and Save Models
y_model = Model_I.predictFcn(X) + Model_Q.predictFcn(X) * 1j;
y_measure = Y_i + Y_q * 1j;
nmse_db = NMSE_dB(y_model, y_measure)
save('Model.mat', 'Model_I', 'Model_Q');

%%  ----------------------------Example III : Deep Network Designer APP----------------------------

%% Design Network and Set Input/Output Matrix 

layers = [
    sequenceInputLayer(6,"Name","sequence")
    fullyConnectedLayer(8,"Name","fc_1")
    reluLayer("Name","relu_1")
    fullyConnectedLayer(8,"Name","fc_2")
    reluLayer("Name","relu_2")
    fullyConnectedLayer(2,"Name","Regression Output")
    regressionLayer("Name","regressionoutput")];

 
M=2; % Memory Depth
X1 = zeros(2*(M + 1), dim-M);
for j = 1:length(y_i) - M
    X1(:, j) = [y_i(j : j + M); y_q(j : j + M)];
end
Y = [x_i(M + 1 : end)'; x_q(M + 1 : end)'];


%% Adjust Parameters and Train Models
% More Details in https://ww2.mathworks.cn/help/deeplearning/ref/trainingoptions.html
num = 5000;
XValidation = X1(:, num:end);
YValidation = Y(:, num:end);
maxEpochs = 2000;
miniBatchSize = 512;
options = trainingOptions('adam', ...
    'MaxEpochs', maxEpochs, ...
    'MiniBatchSize', miniBatchSize, ... 
    'InitialLearnRate', 0.005, ...
    'GradientThreshold', 1, ...
    'ValidationData', {XValidation, YValidation}, ...
    'ValidationFrequency', 500, ...
    'Shuffle', 'never', ...
    'Plots', 'training-progress', ...
    'ExecutionEnvironment', 'cpu', ...
    'LearnRateSchedule', 'piecewise', ...
    'LearnRateDropFactor', 0.5, ...
    'LearnRateDropPeriod', 600, ...
    'Verbose', 1, ...
    'VerboseFrequency', 1000);
%     'ValidationPatience',5,...

deep_net = trainNetwork(X1(:, 1:num), Y(:, 1:num), layers, options);

%%  Check Modeling Performance and Save Models
Y_pred = predict(deep_net, X1);
a = Y_pred(1, :) + Y_pred(2, :) * 1i;
b = Y(1, :) + Y(2, :) * 1i;
nmse_db = NMSE_dB(a, b)
save('DeepNN.mat', 'deep_net');
