% --- Function based code - just edit on main

close all; clear; clc;

folder1 = 'D:\Jaler\OpenBCI_GUI\_DataSkripsi\Dataset\rawData\';
files = dir([folder1 '*.txt']);
fs = 200;
% - loadRaw - Fnotch50Hz - BP1-50Hz
data = load([folder1 'subjek2c_24.txt']);
data = filterNotch50(data, fs);
[data,BP] = filterBP(data, fs, 1, 50);
% [data,BP] = filterBP(data, fs, 14, 26);
[M,B,durasi] = potongData(data, fs, 2);
M_PSD = PSDAll(M, fs);
B_PSD = PSDAll(B, fs);
[xlim1, xlim2, durasi, BPLabel] = labelPlot(5, 30, durasi, BP);
plotPSD1(M_PSD, 'Merah', xlim1, xlim2, durasi, BPLabel);
plotPSD1(B_PSD, 'Biru', xlim1, xlim2, durasi, BPLabel);

% data11 = filterBP(data, fs, 10.5, 11.5);
% data13 = filterBP(data, fs, 12.5, 13.5);
% [M11,B11] = potongData(data11, fs, 2);
% [M13,B13] = potongData(data13, fs, 2);