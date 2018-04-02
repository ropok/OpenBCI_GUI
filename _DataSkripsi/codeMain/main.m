% --- Function based code - just edit on main

close all; clear; clc;

subjek = 'subjek2c_22.txt';
folder1 = 'D:\Jaler\OpenBCI_GUI\_DataSkripsi\Dataset\rawData\';
folder2 = 'D:\Jaler\OpenBCI_GUI\_DataSkripsi\Dataset\rawData\temp12\';
files = dir([folder1 '*.txt']);
fs = 200;
% - loadRaw - Fnotch50Hz - BP1-50Hz
data = load([folder1 subjek]);
data = filterNotch50(data, fs);
[data,BP] = filterBP(data, fs, 1, 50);
[data,BP] = filterBP(data, fs, 8, 26);
[M,B,durasi] = potongData(data, fs, 2);
M_PSD = PSDAll(M, fs);
B_PSD = PSDAll(B, fs);
[xlim1, xlim2, durasi, BPLabel] = labelPlot(5, 30, durasi, BP);
subjek(regexp(subjek, '[.txt]'))=[];
plotPSD1(M_PSD, 'Merah-9Hz', xlim1, xlim2, durasi, BPLabel); print([folder2 sprintf('M_PSD_%s',subjek)],'-dpng');
plotPSD1(B_PSD, 'Biru-14Hz', xlim1, xlim2, durasi, BPLabel); print([folder2 sprintf('B_PSD_%s',subjek)],'-dpng');

% data11 = filterBP(data, fs, 10.5, 11.5);
% data13 = filterBP(data, fs, 12.5, 13.5);
% [M11,B11] = potongData(data11, fs, 2);
% [M13,B13] = potongData(data13, fs, 2);