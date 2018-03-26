close all; clear; clc;

folder1 = 'D:\Jaler\OpenBCI_GUI\_DataSkripsi\Dataset\rawData\';
folder2 = 'D:\Jaler\OpenBCI_GUI\_DataSkripsi\Dataset\rawData\temp7-TD\';

files = dir([folder1 '*.txt']);

for h = 1:length(files)
% for h = 1:1
    code7(files(h,1).name, folder2);
end