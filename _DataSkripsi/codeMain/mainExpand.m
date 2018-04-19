% -- Untuk Looping pemilihan sesi mana yang akan diekstraksi ciri

close all; clear; clc;

folder1 = 'D:\Jaler\OpenBCI_GUI\_DataSkripsi\Dataset\rawData\';             % Sesi1 Sesi2
% folder1 = 'D:\Jaler\OpenBCI_GUI\_DataSkripsi\Dataset\rawData\Sesi1\';     % Sesi1
% folder1 = 'D:\Jaler\OpenBCI_GUI\_DataSkripsi\Dataset\rawData\Sesi2\';     % Sesi2
folder2 = 'D:\Jaler\OpenBCI_GUI\_DataSkripsi\Dataset\rawData\temp21\';

ciriMerah = [];
ciriBiru = [];
ciriSesi = 'ciriSesi1Sesi2';
files = dir([folder1 '*.txt']); 

% Mengumpulkan data dari semua objek
for h = 1:length(files)
% for h = 1:2 % for Test purpose
    [M, B] = mainFilter1(files(h,1).name, 1); % Guna filter1 atau filter2

    % [M, B] = mainFilter2(files(h,1).name, 1); % Guna filter1 atau filter2

    % -- Mengumpulkan rM seluruh subjek ------
    ciriMerah = [ciriMerah M];
    ciriBiru = [ciriBiru B];
    % -- data_rM data_rB

    loading('Load Data', h, length(files));
end

% -- RMS1
load([folder2 sprintf('%s.mat', ciriSesi)]);
ciriSesi1Sesi2.RMS1_Merah = ciriMerah;
ciriSesi1Sesi2.RMS1_Biru = ciriBiru;
save([folder2 sprintf('%s.mat', ciriSesi)],ciriSesi);

% % -- RMS2
% load([folder2 sprintf('%s.mat', ciriSesi)]);
% ciriSesi1Sesi2.RMS2_Merah = ciriMerah;
% ciriSesi1Sesi2.RMS2_Biru = ciriBiru;
% save([folder2 sprintf('%s.mat', ciriSesi)],ciriSesi);

% % -- RatioRMS1
% load([folder2 sprintf('%s.mat', ciriSesi)]);
% ciriSesi1Sesi2.RatioRMS1_Merah = ciriMerah;
% ciriSesi1Sesi2.RatioRMS1_Biru = ciriBiru;
% save([folder2 sprintf('%s.mat', ciriSesi)],ciriSesi);

% % -- RatioRMS2
% load([folder2 sprintf('%s.mat', ciriSesi)]);
% ciriSesi1Sesi2.RatioRMS2_Merah = ciriMerah;
% ciriSesi1Sesi2.RatioRMS2_Biru = ciriBiru;
% save([folder2 sprintf('%s.mat', ciriSesi)],ciriSesi);