% -- Untuk Looping pemilihan sesi mana yang akan diekstraksi ciri

close all; clear; clc;

folder1 = 'D:\Jaler\OpenBCI_GUI\_DataSkripsi\Dataset\rawData\';             % Sesi1 Sesi2
% folder1 = 'D:\Jaler\OpenBCI_GUI\_DataSkripsi\Dataset\rawData\Sesi1\';     % Sesi1
% folder1 = 'D:\Jaler\OpenBCI_GUI\_DataSkripsi\Dataset\rawData\Sesi2\';     % Sesi2
% folder2 = 'D:\Jaler\OpenBCI_GUI\_DataSkripsi\Dataset\rawData\temp21\';

ciriMerah = [];
ciriBiru = [];
ciriSesi = 'ciriSesi1Sesi2';
files = dir([folder1 '*.txt']); 

% -- Daftar per subjek (files)
% subjek2 : 1:10
% subjek3 : 11:20
% subjek4 : 21:30
% subjek5 : 31:40
% subjek6 : 41:50
% subjek7 : 51:60
% subjek8 : 61:70
% subjek9 : 71:80

% -- Daftar per subjek (ciri)
% subjek2 : 1:30
% subjek3 : 31:60
% subjek4 : 61:90
% subjek5 : 91:120
% subjek6 : 121:150
% subjek7 : 151:180
% subjek8 : 181:210
% subjek9 : 211:240

% Mengumpulkan data dari semua objek
for h = 1:length(files)
% for h = 1:1
% for h = 77:86 % for Test purpose
    [M, B] = mainLoop(files(h,1).name, 1);

    % -- Mengumpulkan rM seluruh subjek ------
    ciriMerah = [ciriMerah M];
    ciriBiru = [ciriBiru B];
    % -- data_rM data_rB

    loading('Load Data', h, length(files));
end