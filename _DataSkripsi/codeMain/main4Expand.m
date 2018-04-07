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

    loading('Load Data', h, length(files));
end

% -- JST
inputs = [data_rM' data_rB']; % input untuk JST
% JST(inputs, 10);

for i = 1:9
    inputs1{1,i} = inputs(4*i-3:4*i,:);
    % loading('inputs', i, 9);
end