% -- Untuk Looping pemilihan sesi mana yang akan diekstraksi ciri

close all; clear; clc;

folder1 = 'D:\Jaler\OpenBCI_GUI\_DataSkripsi\Dataset\rawData\';             % Sesi1 Sesi2
% folder1 = 'D:\Jaler\OpenBCI_GUI\_DataSkripsi\Dataset\rawData\Sesi1\';     % Sesi1
% folder1 = 'D:\Jaler\OpenBCI_GUI\_DataSkripsi\Dataset\rawData\Sesi2\';     % Sesi2
% folder2 = 'D:\Jaler\OpenBCI_GUI\_DataSkripsi\Dataset\rawData\temp21\';

ciriMerah = [];
ciriBiru = [];
% ciriSesi = 'Sesi1';
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

% -- Daftar per subjek (ciri) - Sesi1Sesi2
% subjek2 : 1:30
% subjek3 : 31:60
% subjek4 : 61:90
% subjek5 : 91:120
% subjek6 : 121:150
% subjek7 : 151:180
% subjek8 : 181:210
% subjek9 : 211:240
%  -- subjek : 1:1*30

% -- Daftar per subjek (ciri) - 1 Sesi
% subjek2 : 1:15
% subjek3 : 16:30
% subjek4 : 31:45
% subjek5 : 46:60
% subjek6 : 61:75
% subjek7 : 76:90
% subjek8 : 91:105
% subjek9 : 106:120
%  -- subjek : 1:1*15

% Mengumpulkan data dari semua objek
for h = 1:length(files)
% for h = 1:1
% for h = 77:86 % for Test purpose
    [M, B] = mainLoop(folder1, files(h,1).name, 1);

    % -- Mengumpulkan rM seluruh subjek ------
    ciriMerah = [ciriMerah M];
    ciriBiru = [ciriBiru B];
    % -- data_rM data_rB

    loading('Load Data', h, length(files));
end

% Membuat Tabel + Pelabelan
% -- Menata variable untuk table (Sesi1Sesi2)
for i = 0:7
    start = i*30+1;
    finish = i*30+30;
    subjek{i+2} = [ciriMerah(:,start:finish) ciriBiru(:,start:finish)];
end

% % -- Menata variable untuk table (1 Sesi)
% for i = 0:7
%     start = i*15+1;
%     finish = i*15+15;
%     subjek{i+2} = [ciriMerah(:,start:finish) ciriBiru(:,start:finish)];
% end

% % -- Menata variable untuk table
% subjek1 = subjek{1};
% subjek2 = subjek{2};
% subjek3 = subjek{3};    
% subjek4 = subjek{4};
% subjek5 = subjek{5};
% subjek6 = subjek{6};
% subjek7 = subjek{7};
% subjek8 = subjek{8};
% subjek9 = subjek{9};

% -- Labeling Row untuk Nama Ciri
RowCiri = {'ciriDelta_Fp1' ; 'ciriDelta_Fp2' ; 'ciriDelta_C3' ; 'ciriDelta_C4' ; ...
            'ciriTheta_Fp1' ;  'ciriTheta_Fp2' ;  'ciriTheta_C3' ;  'ciriTheta_C4' ; ... 
            'ciriAlpha_Fp1' ;  'ciriAlpha_Fp2' ;  'ciriAlpha_C3' ;  'ciriAlpha_C4' ; ... 
            'ciriBeta_Fp1' ;  'ciriBeta_Fp2' ;  'ciriBeta_C3' ;  'ciriBeta_C4' ; ... 
            'ciriGamma_Fp1' ;  'ciriGamma_Fp2' ;  'ciriGamma_C3' ;  'ciriGamma_C4' ; ... 
            
            'ciri11Hz_Fp1' ;  'ciri11Hz_Fp2' ;  'ciri11Hz_C3' ;  'ciri11Hz_C4' ; ... 
            'ciri22Hz_Fp1' ;  'ciri22Hz_Fp2' ;  'ciri22Hz_C3' ;  'ciri22Hz_C4' ; ... 
            'ciri33Hz_Fp1' ;  'ciri33Hz_Fp2' ;  'ciri33Hz_C3' ;  'ciri33Hz_C4' ; ... 
            'ciri13Hz_Fp1' ;  'ciri13Hz_Fp2' ;  'ciri13Hz_C3' ;  'ciri13Hz_C4' ; ... 
            'ciri26Hz_Fp1' ;  'ciri26Hz_Fp2' ;  'ciri26Hz_C3' ;  'ciri26Hz_C4' ; ... 
            'ciri39Hz_Fp1' ;  'ciri39Hz_Fp2' ;  'ciri39Hz_C3' ;  'ciri39Hz_C4' ; ... 
            };


tabel32Ciri_Sesi1Sesi2 = table(subjek2, subjek3, subjek4, subjek5, subjek6, subjek7, subjek8, subjek9, 'RowNames', RowCiri);