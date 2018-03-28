close all; clear; clc;

folder1 = 'D:\Jaler\OpenBCI_GUI\_DataSkripsi\Dataset\rawData\';
folder2 = 'D:\Jaler\OpenBCI_GUI\_DataSkripsi\Dataset\rawData\temp9\';

files = dir([folder1 '*.txt']);

% for h = 1:length(files)
for h = 80:80
    code9(files(h,1).name, folder2);
end