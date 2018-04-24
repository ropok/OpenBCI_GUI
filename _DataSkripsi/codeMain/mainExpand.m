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

% Mengumpulkan data dari semua objek
for h = 1:length(files)
% for h = 1:2 % for Test purpose
    [M, B] = mainLoop(files(h,1).name, 1);

    % -- Mengumpulkan rM seluruh subjek ------
    ciriMerah = [ciriMerah M];
    ciriBiru = [ciriBiru B];
    % -- data_rM data_rB

    loading('Load Data', h, length(files));
end