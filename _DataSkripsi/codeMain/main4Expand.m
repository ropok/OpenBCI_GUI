close all; clear; clc;

folder1 = 'D:\Jaler\OpenBCI_GUI\_DataSkripsi\Dataset\rawData\';
folder2 = 'D:\Jaler\OpenBCI_GUI\_DataSkripsi\Dataset\rawData\temp14\';

data_rM = [];
data_rB = [];

files = dir([folder1 '*.txt']);

for h = 1:length(files)
% for h = 1:2 % for Test purpose
    [rM, rB] = main2(files(h,1).name, 1);

    % -- Mengumpulkan rM seluruh subjek ------
    data_rM = [data_rM; rM];
    data_rB = [data_rB; rB];
    % -- data_rM data_rB
end

% -- JST
inputs = [data_rM' data_rB']; % input untuk JST
[~,N] = size(inputs);
n = N/2;
targets(1,1:n) = ones;
    targets(2,n+1:N) = ones;

% Membuat Pattern Recognition Network
hiddenLayerSize = 10;
net = patternnet(hiddenLayerSize);

% Set up Division of Data for Training, Validation, Testing
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;

% Train the Network
[net,tr] = train(net, inputs, targets);

% Test the Network
outputs = net(inputs);
errors = gsubtract(targets, outputs);
performance = perform(net, targets, outputs)

% View the Network
view(net)