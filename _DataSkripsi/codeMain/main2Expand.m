close all; clear; clc;

folder1 = 'D:\Jaler\OpenBCI_GUI\_DataSkripsi\Dataset\rawData\';
% folder2 = 'D:\Jaler\OpenBCI_GUI\_DataSkripsi\Dataset\rawData\temp13\';

scoreAllM = [];
scoreAllB = [];

files = dir([folder1 '*.txt']);

% for h = 1:length(files)
for h = 1:2 % for Test purpose
    [scoreM, scoreB] = main2(files(h,1).name);

    % -- Mengumpulkan score seluruh subjek ------
    scoreAllM = [scoreAllM; scoreM];
    scoreAllB = [scoreAllB; scoreB];
    % -- scoreAllM scoreAllB

end