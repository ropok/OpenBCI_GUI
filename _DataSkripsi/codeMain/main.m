% --- Function based code - just edit on main

close all; clear; clc;

folder1 = 'D:\Jaler\OpenBCI_GUI\_DataSkripsi\Dataset\rawData\';
files = dir([folder1 '*.txt']);
fs = 200;
% - loadRaw - Fnotch50Hz - BP1-50Hz
data = load([folder1 'subjek2b_1.txt']);
data = filterNotch50(data, fs);
data = filterBP(data, fs, 1, 50);

data11 = filterBP(data, fs, 10.5, 11.5);
data13 = filterBP(data, fs, 12.5, 13.5);
[M11,B11] = potongData(data11, fs, 2);
[M13,B13] = potongData(data13, fs, 2);